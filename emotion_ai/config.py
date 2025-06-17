import os

# Re-AizuHack2025へのpath
EMOTION_AI_PATH = os.path.dirname(os.path.abspath(__file__))


# dataディレクトリへのpath
DATA_PATH = os.path.join(EMOTION_AI_PATH, "data")


# finetunedディレクトリへのpath
FINETRAIN_PATH = os.path.join(DATA_PATH, "finetrain")


# 学習用データのpath
TRAIN_DATA_PATH = os.path.join(DATA_PATH, "emotion_dataset_10000.xlsx")


# ファインチューニングするモデルのlist
MODELS_LIST = [
    "LoneWolfgang/bert-for-japanese-twitter-sentiment",
    "koheiduck/bert-japanese-finetuned-sentiment",
    "lxyuan/distilbert-base-multilingual-cased-sentiments-student"
]


# ファインチューニングしたモデル
FINETRAIN_MODEL_LIST = [
    "LoneWo",
    "koheid",
    "lxyuan"
]

# デフォルトのカテゴリー
DEFAULT_CATEGORY = ["negative", "neutral", "positive"]


# 実際に感情を分析するファイルのpath
TEST_DATA_PATH = os.path.join(DATA_PATH, "test.csv")


# dataディレクトリがなければ作成する
def check_data_dir():
    os.makedirs(DATA_PATH, exist_ok=True)
