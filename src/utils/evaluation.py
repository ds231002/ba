import pandas as pd
from utils.files import load_json

def create_result_path(
    task_id: str,
    task_type: str,
    method: str,
    model: str
) -> str:
    if model == "gpt-5.4-mini":
        model = "gpt-5.4-mini-2026-03-17"
    
    return f"output/results/{task_type}/{task_id}/{method}_{model.replace(':', '_')}.json"

def create_result_path_list():
    methods = ["deterministic", "plan-based", "iterative"]
    models = ["qwen3:8b", "qwen3:30b", "gpt-5.4-mini-2026-03-17"]

    path_list = []

    for task_id in range(1, 91):
        if 1 <= task_id <= 30:
            task_type = "Direkte Datenabfrage"
        elif 31 <= task_id <= 60:
            task_type = "Einzelquellenverarbeitung"
        elif 61 <= task_id <= 90:
            task_type = "Mehrquellenverarbeitung"

        for method in methods:
            for model in models:
                path_list.append(create_result_path(task_id, task_type, method, model))

    return path_list

def adapt_evaluation_df(df: pd.DataFrame) -> pd.DataFrame:
    # fill NaN from combined cells
    df[["task_id", "task_type", "method"]] = (
        df[["task_id", "task_type", "method"]].ffill()
    )

    # convert float to int
    for column in ["task_id", "tools_correct", "arguments_correct", "tools_efficient", "arguments_efficient"]:
        df[column] = df[column].astype(int)

    return df

def add_usage_to_evaluation(df: pd.DataFrame) -> pd.DataFrame:
    methods = ["deterministic", "plan-based", "iterative"]
    models = ["qwen3:8b", "qwen3:30b", "gpt-5.4-mini"]

    for task_id in range(1, 91):
        if 1 <= task_id <= 30:
            task_type = "Direkte Datenabfrage"
        elif 31 <= task_id <= 60:
            task_type = "Einzelquellenverarbeitung"
        elif 61 <= task_id <= 90:
            task_type = "Mehrquellenverarbeitung"

        for method in methods:
            for model in models:
                path = create_result_path(task_id, task_type, method, model)
                result = load_json(path)

                mask = (
                    (df["task_id"] == task_id) &
                    (df["method"] == method) &
                    (df["task_type"] == task_type) &
                    (df["model"] == model)
                )

                if pd.notna(df.loc[mask, "error"]).any():
                    df.loc[
                        mask,
                        ["runtime_seconds", "input_tokens", "output_tokens", "total_tokens"]
                    ] = pd.NA
                    continue

                usage = result.get("usage")

                if usage is None:
                    usage = result.get("total_usage")

                df.loc[
                    mask,
                    ["runtime_seconds", "input_tokens", "output_tokens", "total_tokens"]
                ] = [
                    usage["runtime_seconds"],
                    usage["input_tokens"],
                    usage["output_tokens"],
                    usage["total_tokens"]
                ]

    token_columns = [
        "input_tokens",
        "output_tokens",
        "total_tokens"
    ]

    df[token_columns] = df[token_columns].astype("Int64")

    return df

def group_by(df: pd.DataFrame, columns: list[str]) -> pd.DataFrame:
    df = df.groupby(columns, as_index=True).agg(
        correct=("correct", "mean"),
        efficient=("efficient", "mean"),
        runtime_seconds=("runtime_seconds", "mean"),
        total_tokens=("total_tokens", "mean"),
        error_ratio=("error", lambda x: x.notna().mean()),
    )

    columns_float = ["correct", "efficient", "runtime_seconds", "error_ratio"]
    df[columns_float] = df[columns_float].round(2)
    df["total_tokens"] = df["total_tokens"].round(0)

    return df