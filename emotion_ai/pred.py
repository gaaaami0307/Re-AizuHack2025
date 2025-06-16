import json
import os

import numpy as np
import pandas as pd
import torch
from transformers import AutoModelForSequenceClassification, AutoTokenizer


def main():
    # dataディレクトリのpath
    data_dir = os.path.join(
            os.path.dirname(__file__), "data"
        )

    # label_categoriesへのpath
    label_categories_path = os.path.join(
            data_dir, "label_categories.json"
        )

    # 存在していればロードなければデフォルトの3つを使う
    if os.path.exists(label_categories_path):
        with open(label_categories_path, "r", encoding="utf-8") as f:
            categories = json.load(f)
    else:
        # label_categories.json がない場合
        categories = ["negative", "neutral", "positive"]
        print(f"Warning: '{label_categories_path}' が見つかりませんでした "
              f"デフォルトカテゴリーの: {categories} を使います")

    finetuned_models = [
        "finetuned_koheiduck_bert-japanese-finetuned-sentiment",
        "finetuned_LoneWolfgang_bert-for-japanese-twitter-sentiment",
        "finetuned_lxyuan_distilbert-base-multilingual-cased-sentiments-student"  # noqa
    ]

    finetuned_time = [
        "first",
        "second",
        "third",
        "fourth"
    ]

    test_texts = pd.read_csv(data_dir + "/test.csv",
                             dtype=pd.StringDtype())

    all_pred = []
    for time in finetuned_time:
        output_val = {text: None for text in test_texts["text"]}
        for model_dir in finetuned_models:
            model_path = os.path.join(
                    os.path.dirname(__file__) + f"/{time}_time/{model_dir}"
                )

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

    with pd.ExcelWriter("output.xlsx") as writer:
        for time, output_val in zip(finetuned_time, all_pred):
            # 各テキストごとに合計logitsから予測ラベルを決定
            rows = []
            for text in test_texts["text"]:
                logits = output_val[text]
                logits_list = np.array(output_val[text])
                pred_idx = logits.index(max(logits))
                pred_label = categories[pred_idx]
                logits_tensor = torch.tensor(logits_list, dtype=torch.float)
                softmax_tensor = torch.softmax(logits_tensor, dim=0)
                softmax_probabilities_list = softmax_tensor.tolist()

                rows.append({"text": text,
                             "pred_label": pred_label,
                             "logits: negative, neutral, positive":
                                 softmax_probabilities_list})
            df_out = pd.DataFrame(rows)
            df_out.to_excel(writer, sheet_name=time, index=False)


if __name__ == "__main__":
    main()
