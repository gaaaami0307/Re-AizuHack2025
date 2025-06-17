import os

import config
import pandas as pd
from datasets import Dataset
from transformers import (AutoModelForSequenceClassification, AutoTokenizer,
                          Trainer, TrainingArguments)

df = pd.read_excel(config.TRAIN_DATA_PATH,
                   header=None, names=["text", "label"])


df["label"] = df["label"].astype("category")
num_labels = len(df["label"].cat.categories)
categories = list(df["label"].cat.categories)

# dataディレクトリがなければ作る
config.check_data_dir()


df["label"] = df["label"].cat.codes
dataset = Dataset.from_pandas(df[["text", "label"]])


for model_name in config.MODELS_LIST:
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

    training_args = TrainingArguments(
        output_dir = f'./results_{model_name.replace("/", "_")}',  # noqa
        num_train_epochs = 6,  # type: ignore  # noqa
        per_device_train_batch_size = 8,  # type: ignore  # noqa
        save_strategy = "epoch",  # noqa
        logging_steps = 500,  # type: ignore  # noqa
        warmup_ratio = 0.1,  # type: ignore  # noqa
        learning_rate = 1e-5,  # type: ignore  # noqa
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
        os.path.join(config.DATA_PATH, "fine_tuned",
                     model_name.replace("/", "_")[:6])
    )

    tokenizer.save_pretrained(
        os.path.join(config.DATA_PATH, "fine_tuned",
                     model_name.replace("/", "_")[:6])
    )

    print(
        "Saved:" + config.DATA_PATH + "/fine_tuned"
        f"/{model_name.replace("/", "_")[:6]}"
    )
