import os

import config
import pandas as pd
import torch
from transformers import AutoModelForSequenceClassification, AutoTokenizer


def main(path="test.csv"):
    """
    Args:
        path (str): dataの中にある使いたいファイルを指定. Defaults to "test.csv".
    """

    # label_categories

    test_texts = pd.read_csv(os.path.join(config.DATA_PATH, path),
                             dtype=pd.StringDtype())

    all_pred = []
    output_val = {text: None for text in test_texts["text"]}
    for model_dir in config.FINETRAIN_MODEL_LIST:
        model_path = \
            os.path.join(config.FINETRAIN_PATH, model_dir)

        tokenizer = AutoTokenizer.\
            from_pretrained(model_path, local_files_only=True)

        model = AutoModelForSequenceClassification.\
            from_pretrained(model_path, local_files_only=True)

        for text in test_texts["text"]:
            inputs = tokenizer(str(text), return_tensors="pt",
                               truncation=True, padding=True)

            with torch.no_grad():
                outputs = model(**inputs)

            logits = outputs.logits.detach().cpu().numpy().tolist()[0]
            if not output_val[text]:
                output_val[text] = logits
            else:
                # 要素ごとに加算
                output_val[text] = \
                    [a + b for a, b in zip(output_val[text], logits)]
    all_pred.append(output_val)
    print(all_pred[0])

    for output_val in all_pred:
        # 各テキストごとに合計logitsから予測ラベルを決定
        rows = []
        for text in test_texts["text"]:
            logits = output_val[text]
            pred_idx = logits.index(max(logits))
            pred_label = config.DEFAULT_CATEGORY[pred_idx]
            logits_tensor = torch.tensor(logits, dtype=torch.float)
            # softmaxを適応させて出力の合計値を1にする
            softmax_tensor = torch.softmax(logits_tensor, dim=0)
            softmax_probabilities_list = softmax_tensor.tolist()

            rows.append({"text": text,
                         "pred_label": pred_label,
                         "negative": softmax_probabilities_list[0],
                         "neutral": softmax_probabilities_list[1],
                         "positive": softmax_probabilities_list[2]})
        df_out = pd.DataFrame(rows)

        # CSVファイルとして出力する
        output_path = os.path.join(config.DATA_PATH, "output", "output.csv")
        df_out.to_csv(output_path, index=False, encoding="utf-8")


if __name__ == "__main__":
    main()
