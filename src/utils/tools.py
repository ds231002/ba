from typing import List, Optional
from utils.data_access import load_energy_data
import pandas as pd

# ==== Basisdaten ====

def get_participation_factor(metering_point_id: str, date: str) -> float:
    return 0.7

def get_current_power_consumption(metering_point_id: str) -> dict:
    return {
        "value": 3.21,
        "unit": "kW"
    }

def get_current_power_generation(metering_point_id: str) -> dict:
    return {
        "value": 9.87,
        "unit": "kW"
    }

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
    )[["timestamp", "value_kwh"]]

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
    )[["timestamp", "value_kwh"]]

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
    )[["timestamp", "value_kwh"]]

# ==== Operationen ====

def calculate_timeseries(operation: str, timeseries: list[list[dict]]):
    # community_coverage (Eigenabdeckung) = community_generation x participation_factor
    # 
    # surplus (Überschuss) = generation - consumption (>0)
    # get_weighted_measured_consumption()
    pass

# +/- mit timeseries: list[list[dict]]
# */: mit timeseries: list[dict] und float (Teinahmefaktor)

# ==== Plot ====

def create_energy_plot(energy_data: list[pd.DataFrame]):
    # Vergleichsgrafiken (Verbrauch, Erzeugung) auf einmal?
    # Nur ausführen wenn explizit verlangt (Laufzeit und unklar wie bewerten wenn hilfreich aber nicht notwendig)
    # autmatisch dem Chat zuordnen oder auch llm machen lassen?
    pass

# ==== Analyse ====

def get_statistical_value(statistic_type: str, time_series: pd.DataFrame) -> Optional[float]:
    allowed_statistics = ["max", "min", "avg", "sum"]

    if statistic_type not in allowed_statistics:
        raise ValueError(f"Ungültiger Statistiktyp. Erlaubt sind: {allowed_statistics}")

    # einfach alle statistischen Werte zurückgeben? - mit allowed_statistics eindeutig für potentielle Übergabe (vlt für weitere Analyse?)
    pass

# ==== Antwort ====

def generate_answer(results: list, message: str | None = None) -> str:
    return "Beispielantwort"

# ==== Abgeleitete Daten für Methode 1 ====

def get_community_potential(metering_point_id, start, end):
    pass

def get_community_coverage(start, end):
    pass

def get_weighted_measured_consumption(start, end):
    pass

def get_weighted_measured_generation(start, end):
    pass

# ==== Aussortierte Tools ====

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

# def analyse_energy_data(energy_data: list, prompt: str):
#     # vl-time
#     # Qwen2.5-VL/Llama 3.2 Vision/Gemma 3 (Vision)/MiniCPM-V
#     pass

# def merge_timeseries(timeseries1, timeseries2):
#     # no overlap!
#     # Reihenfolge egal oder erste muss vorher sein?
#     # muss direkt anschließen oder auch Lücken mögliche?
#     # primär gedacht um forecast anzuknüpfen (sinnvoll?)
#     pass