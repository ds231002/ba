from utils.files import load_json
import pandas as pd

def load_result_json(
    task_id: str,
    task_type: str,
    method: str,
    model: str
):
    path = f"output/results/{task_type}/{task_id}/{method}_{model.replace(':', '_')}.json"
    return load_json(path)

def adapt_evaluation_df(df: pd.DataFrame) -> pd.DataFrame:
    # fill NaN from combined cells
    df[["task_id", "task_type", "method"]] = (
        df[["task_id", "task_type", "method"]].ffill()
    )

    # convert float to int
    for column in ["task_id", "tools_correct", "arguments_correct", "tools_efficient", "answer_efficient"]:
        df[column] = df[column].astype(int)

    return df