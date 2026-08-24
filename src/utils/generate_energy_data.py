from datetime import datetime, timedelta
from typing import Literal
from pathlib import Path
import math
import random
import csv

EnergyType = Literal["consumption", "generation"]

def generate_consumption_profile(
    timestamp: datetime,
    rng: random.Random,
    scale_factor: float = 1.0
) -> float:
    """
    Generate a synthetic consumption value for a given timestamp.

    The profile consists of:
    - a base load
    - a typical daily pattern
    - random fluctuations
    """

    hour = timestamp.hour + timestamp.minute / 60

    # Base consumption during the night
    base_load = 0.2

    # Typical daily consumption pattern
    morning_peak = 0.8 * math.exp(-((hour - 7.5) ** 2) / 4)
    evening_peak = 1.2 * math.exp(-((hour - 19.0) ** 2) / 6)

    # Random fluctuation
    noise = rng.uniform(-0.1, 0.1)

    consumption = base_load + morning_peak + evening_peak + noise

    # Consumption cannot be negative
    return max(0.0, round(consumption*scale_factor, 3))

def generate_generation_profile(
    timestamp: datetime,
    rng: random.Random,
    scale_factor: float = 1.0
) -> float:
    """
    Generate a synthetic PV generation value for a given timestamp.

    No generation is produced during the night.
    """

    hour = timestamp.hour + timestamp.minute / 60

    # Approximate sunrise and sunset
    sunrise = 6.0
    sunset = 20.0

    if hour < sunrise or hour > sunset:
        return 0.0

    # Normalize time between sunrise and sunset
    daylight_progress = (hour - sunrise) / (sunset - sunrise)

    # Simple bell-shaped PV curve
    generation = 3.0 * math.sin(math.pi * daylight_progress)

    # Random fluctuation
    noise_factor = rng.uniform(0.9, 1.1)
    generation *= noise_factor

    return round(max(0.0, generation*scale_factor), 3)

def generate_timeseries(
    metering_point_id: str,
    metering_point_type: EnergyType,
    start: str,
    end: str,
    seed: int | None = None,
    scale_factor: float = 1.0
) -> list[dict]:
    """
    Generate a synthetic 15-minute energy time series.
    """

    start = datetime.fromisoformat(start)
    end = datetime.fromisoformat(end)

    if start >= end:
        raise ValueError("start must be before end")

    rng = random.Random(seed)

    data = []
    current = start

    while current < end:

        if metering_point_type == "consumption":
            value = generate_consumption_profile(
                current,
                rng,
                scale_factor
            )

        elif metering_point_type == "generation":
            value = generate_generation_profile(
                current,
                rng,
                scale_factor
            )

        else:
            raise ValueError(
                f"Unknown metering point type: {metering_point_type}"
            )

        data.append({
            "metering_point_id": metering_point_id,
            "energy_type": metering_point_type,
            "timestamp": current,
            "value_kwh": value,
        })

        current += timedelta(minutes=15)

    return data

def create_energy_data_csv(
    user_id: str,
    data: list[dict],
    output_dir: str = "energy_data",
) -> Path:
    """
    Save energy data of a user to a CSV file.

    The file is named after the user_id.
    """

    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    file_path = output_path / f"{user_id}.csv"

    fieldnames = [
        "metering_point_id",
        "energy_type",
        "timestamp",
        "value_kwh",
    ]

    with file_path.open(
        mode="w",
        newline="",
        encoding="utf-8",
    ) as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames,
        )

        writer.writeheader()

        for row in data:
            writer.writerow({
                **row,
                "timestamp": row["timestamp"].isoformat(),
            })

    return file_path