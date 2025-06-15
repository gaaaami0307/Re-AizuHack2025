import json
import os

import pandas as pd
from datasets import Dataset
from transformers import (AutoModelForSequenceClassification, AutoTokenizer,
                          Trainer, TrainingArguments)

df = pd.read_excel(r"D:\program\programming\app\emotion_ai\data"
                   r"\emotion_dataset_10000.xlsx",
                   header=None, names=["text", "label"])


df["label"] = df["label"].astype("category")
num_labels = len(df["label"].cat.categories)
categories = list(df["label"].cat.categories)

# ./dataへのpath
data_dir = os.path.join(os.path.dirname(__file__), "data")

# もしdataフォルダがない場合は作る
os.makedirs(data_dir, exist_ok=True)

output_path = os.path.join(data_dir, "label_categories.json")

with open(output_path, "w", encoding="utf-8") as f:
    json.dump(categories, f, ensure_ascii=False)

df["label"] = df["label"].cat.codes
dataset = Dataset.from_pandas(df[["text", "label"]])

# 3つのモデルをロードしてFTする
models = [
    "LoneWolfgang/bert-for-japanese-twitter-sentiment",
    "koheiduck/bert-japanese-finetuned-sentiment",
    "lxyuan/distilbert-base-multilingual-cased-sentiments-student"
]


for model_name in models:
    print(f"\n---------Fine Tuning: {model_name}----------")
    # モデルに適した前処理をしてくれるもの
    tokenizer = AutoTokenizer.from_pretrained(model_name)

    def preprocess(example):
        return tokenizer(example["text"],
                         truncation=True,
                         padding="longest"
                         )

    tokenized_dataset = dataset.map(preprocess)

    # これは自動で分類用のヘッドをつけてくれる
    model = AutoModelForSequenceClassification.\
        from_pretrained(model_name, num_labels=num_labels)

    # 4つのハイパーパラメータで学習をさせる
    params = [["first", 5, 4, 500, 0.1, 1e-5],
              ["second", 6, 8, 500, 0.1, 1e-5],
              ["third", 7, 16, 500, 0.1, 1e-5],
              ["fourth", 8, 32, 500, 0.1, 1e-5]]

    for param in params:
        training_args = TrainingArguments(
            output_dir = f'./{param[0]}_time/results_{model_name.replace("/", "_")}',  # noqa
            num_train_epochs = param[1],  # type: ignore  # noqa
            per_device_train_batch_size = param[2],  # type: ignore  # noqa
            save_strategy = "epoch",  # noqa
            logging_steps = param[3],  # type: ignore  # noqa
            warmup_ratio = param[4],  # type: ignore  # noqa
            learning_rate = param[5],  # type: ignore  # noqa
            report_to = "none",  # noqa
        )

        trainer = Trainer(
            model=model,
            args=training_args,
            train_dataset=tokenized_dataset,
            processing_class=tokenizer,
        )

        trainer.train()  # type: ignore
        model.save_pretrained(
            data_dir + f'/{param[0]}_time/{model_name.replace("/", "_")[:6]}'
        )

        tokenizer.save_pretrained(
            data_dir + f'/{param[0]}_time/{model_name.replace("/", "_")[:6]}'
        )

        print(
            "Saved:" + data_dir +
            f"/{param[0]}_time/{model_name.replace("/", "_")[:6]}"
        )
