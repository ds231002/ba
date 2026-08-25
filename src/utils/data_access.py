from pathlib import Path
import csv
import pandas as pd

def get_metering_point_ids_for_user_id(
    user_id: str,
    data_dir: str = "energy_data",
) -> list[dict]:
    """
    Return all available metering points and their energy types
    for a given user.
    """

    file_path = Path(data_dir) / f"{user_id}.csv"

    if not file_path.exists():
        raise FileNotFoundError(
            f"No energy data found for user '{user_id}'."
        )

    metering_points = set()

    with file_path.open(
        mode="r",
        newline="",
        encoding="utf-8",
    ) as file:

        reader = csv.DictReader(file)

        for row in reader:
            metering_points.add(
                (
                    row["metering_point_id"],
                    row["energy_type"],
                )
            )

    return [
        {
            "metering_point_id": metering_point_id,
            "energy_type": energy_type,
        }
        for metering_point_id, energy_type in sorted(metering_points)
    ]

def load_energy_data(
    user_id: str,
    metering_point_id: str,
    start: str | None = None,
    end: str | None = None,
    data_dir: str = "energy_data",
) -> pd.DataFrame:
    """
    Load energy data for a metering point within a given time range.

    If start or end is None, no corresponding time boundary is applied.

    Returns a DataFrame with timestamp as index and kwh as
    the only column.
    """

    file_path = Path(data_dir) / f"{user_id}.csv"

    if not file_path.exists():
        raise FileNotFoundError(
            f"No energy data found for user '{user_id}'."
        )

    df = pd.read_csv(file_path)

    df["timestamp"] = pd.to_datetime(df["timestamp"])

    df = df[df["metering_point_id"] == metering_point_id]

    if start is not None:
        start_dt = pd.to_datetime(start)
        df = df[df["timestamp"] >= start_dt]

    if end is not None:
        end_dt = pd.to_datetime(end)
        df = df[df["timestamp"] < end_dt]

    df = df[["timestamp", "kwh"]]

    return df.set_index("timestamp")