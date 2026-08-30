import json
import pandas as pd
from pathlib import Path

def load_json(path: str) -> dict:
    with open(path, 'r') as file:
        return json.load(file)

def save_json(data: dict, path: str) -> None:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)

    with open(path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False, indent=4)

    return path

def read_csv(path):
    return pd.read_csv(
    "tasks.csv",
    sep= ";",
    encoding="utf-8"
)