from typing import List, Optional
from utils.data_access import load_energy_data
import pandas as pd

# ==== Basic Data ====

def get_participation_factor(metering_point_id: str) -> float:
    return 0.7

def get_current_power_consumption(metering_point_id: str) -> float:
    return 3.21 # kw

def get_current_power_generation(metering_point_id: str) -> float:
    return 9.87 # kw

def get_community_consumption(start: str | None = None, end: str | None = None) -> pd.DataFrame:
    """
    Return community consumption for the requested period.
    If start and end are omitted, the complete time series is returned.
    """

    return load_energy_data(
        user_id="community",
        metering_point_id="community_consumption",
        start=start,
        end=end
    )

def get_community_generation(start: str | None = None, end: str | None = None) -> pd.DataFrame:
    """
    Return community generation for the requested period.
    If start and end are omitted, the complete time series is returned.
    """

    return load_energy_data(
        user_id="community",
        metering_point_id="community_generation",
        start=start,
        end=end
    )

def get_measured_energy(metering_point_id: str, start: str | None = None, end: str | None = None):
    """
    Return measured energy for the requested metering point and period.
    If start and end are omitted, the complete time series is returned.
    """

    return load_energy_data(
        user_id="user",
        metering_point_id=metering_point_id,
        start=start,
        end=end
    )

# ==== Operations ====

def get_statistical_value(statistic_type: str, energy_data: pd.DataFrame) -> Optional[float]:
    """
    Calculate a statistical value from an energy time series.
    """

    allowed_statistics = ["sum", "avg", "min", "max"]

    if statistic_type not in allowed_statistics:
        raise ValueError(
            f"Invalid statistic type. Allowed: {allowed_statistics}"
        )

    if energy_data.empty:
        return None

    values = energy_data["kwh"]

    if statistic_type == "sum":
        return float(values.sum())

    if statistic_type == "avg":
        return float(values.mean())

    if statistic_type == "min":
        return float(values.min())

    if statistic_type == "max":
        return float(values.max())

    return None

def add_timeseries(timeseries: list[pd.DataFrame]) -> pd.DataFrame:
    """
    Add multiple energy time series element-wise.
    """

    if len(timeseries) < 2:
        raise ValueError("At least two time series are required.")

    result = timeseries[0].copy()

    for ts in timeseries[1:]:
        result = result.add(ts)

    if result["kwh"].isna().any():
        raise ValueError(
            "Time series do not cover the same timestamps."
        )

    return result

def subtract_timeseries(minuend: pd.DataFrame, subtrahend: pd.DataFrame) -> pd.DataFrame:
    """
    Subtract one energy time series from another element-wise.
    """

    result = minuend.subtract(subtrahend)

    if result["kwh"].isna().any():
        raise ValueError(
            "Time series do not cover the same timestamps."
        )

    return result

def multiply_timeseries(timeseries: pd.DataFrame, factor: float) -> pd.DataFrame:
    """
    Multiply an energy time series by a scalar factor.
    """

    result = timeseries.copy()
    result["kwh"] = result["kwh"] * factor

    return result

def divide_timeseries(timeseries: pd.DataFrame,divisor: float) -> pd.DataFrame:
    """
    Divide an energy time series by a scalar.
    """

    if divisor == 0:
        raise ValueError("Division by zero is not allowed.")

    result = timeseries.copy()
    result["kwh"] = result["kwh"] / divisor

    return result

def min_timeseries(timeseries: list[pd.DataFrame]) -> pd.DataFrame:
    """
    Return the minimum value of multiple time series for each timestamp.
    """

    if len(timeseries) < 2:
        raise ValueError("At least two time series are required.")

    result = pd.concat(
        [ts["kwh"] for ts in timeseries],
        axis=1,
    )

    if result.isna().any().any():
        raise ValueError(
            "Time series do not cover the same timestamps."
        )

    return pd.DataFrame(
        {"kwh": result.min(axis=1)},
        index=result.index,
    )

def max_timeseries(
    timeseries: list[pd.DataFrame],
) -> pd.DataFrame:
    """
    Return the maximum value of multiple time series for each timestamp.
    """

    if len(timeseries) < 2:
        raise ValueError("At least two time series are required.")

    result = pd.concat(
        [ts["kwh"] for ts in timeseries],
        axis=1,
    )

    if result.isna().any().any():
        raise ValueError(
            "Time series do not cover the same timestamps."
        )

    return pd.DataFrame(
        {"kwh": result.max(axis=1)},
        index=result.index,
    )

def analyse_energy_data(energy_data: list[pd.DataFrame], prompt: str):
    # nur bei komplizierteren Anfragen die nicht durch Tools abgedeckt sind
    # vl-time
    # Qwen2.5-VL/Llama 3.2 Vision/Gemma 3 (Vision)/MiniCPM-V
    pass

# ==== Plot ====

def create_energy_plot(label: str, x: str, y: str, energy_data: list[pd.DataFrame]) -> None:
    # Vergleichsgrafiken (Verbrauch, Erzeugung) auf einmal?
    # Nur ausführen wenn explizit verlangt (Laufzeit und unklar wie bewerten wenn hilfreich aber nicht notwendig)
    # autmatisch dem Chat zuordnen oder auch llm machen lassen?
    # Legende mit vom llm genereirten Namen?
    return None # or plot?

# ==== Answer ====

def generate_answer(results: list, message: str | None = None) -> str:
    return "Beispielantwort"

# ==== Diviated Data ====

def calculate_weighted_measured_energy(metering_point_id: str, start: str, end: str) -> pd.DataFrame:
    # consumption und generation hängt vom Zählpunkt ab
    participation_factor = get_participation_factor(metering_point_id)
    measured_consumption = get_measured_energy(metering_point_id, start, end)
    return multiply_timeseries(measured_consumption, participation_factor)

def calculate_community_potential(metering_point_id: str, start: str, end: str) -> pd.DataFrame:
    participation_factor = get_participation_factor(metering_point_id)
    community_generation = get_community_generation(start, end)
    return multiply_timeseries(community_generation, participation_factor)

def calculate_community_coverage(metering_point_id: str, start: str, end: str) -> pd.DataFrame:
    # metering_point_id muss consumption sein, Verantwortung an LLM geben und einfach als falsch bewerten wenn falsch übergeben?
    community_potential = calculate_community_potential(metering_point_id, start, end)
    weighted_measured_consumption = calculate_weighted_measured_energy(metering_point_id, start, end)
    return min_timeseries(community_potential, weighted_measured_consumption)

# ==== Rejected Tools ====

# def get_astronomical_sun_hours(start, end):
#     # bool per h
#     pass

# def get_spot_market(start, end):
#     # awattar.at/tariffs/hourly
#     pass

# def search_knowledge_for(word: str):
#     pass

# def get_predicted_community_consumption():
#     # from yesterday 00:00 - tomorrow 23:59
#     # per h
#     # how merge on plot? - auto merge, no separat function?
#     pass

# def get_predicted_community_generation():
#     # like consumption
#     pass

# def get_weighted_surplus_generation(start, end):
#     # from cp, from location, all?
#     # delete?
#     pass

# def calculate_spotmarket_energy_consumption(energy_data, spotmarket):
#     # spotmarket Preisberechnung, Ersparnis?
#     pass

# def analyze_plots(plots: list, prompt):
#     pass

# def create_spotmarket_plot(spot_market):
#     pass

# def create_sun_hours_plot(sun_hours):
#     pass

# def get_k_next_knowledge(phrase: str, catrgories: list[str], k) -> list[str]:
#     # keine echte Funktion - nur Parameterauswahl bewerten
#     # feste Kategorieauswahl definieren
#     return []

# def get_energy_pattern(energy_data):
#     # generation, consumption
#     # sample result
#     pass

# def merge_timeseries(timeseries1, timeseries2):
#     # no overlap!
#     # Reihenfolge egal oder erste muss vorher sein?
#     # muss direkt anschließen oder auch Lücken mögliche?
#     # primär gedacht um forecast anzuknüpfen (sinnvoll?)
#     pass