from utils.tools import (
    # basic data
    get_participation_factor as get_pf,
    get_current_energy as get_ce,
    get_community_consumption as get_mc_eg,
    get_community_generation as get_mg_eg,
    get_measured_energy as get_me,
    # operations
    get_statistical_value,
    add_timeseries as add_ts,
    subtract_timeseries as subtract_ts,
    multiply_timeseries as multiply_ts,
    divide_timeseries as divide_ts,
    min_timeseries as min_ts,
    max_timeseries as max_ts, 
    # plot
    create_energy_plot,
    save_plot,
    # answer
    generate_answer
)
import matplotlib.pyplot as plt
import pandas as pd

# ==== Plot ====

def _create_plot(energy_data: pd.DataFrame) -> plt.Figure: # Hilfsfunktion, soll nicht in Toolbeschreibung
    return create_energy_plot("Title", "Lable", energy_data)

# ==== Basic Data ====

def get_participation_factor(metering_point_id: str) -> str: # consumption und generation hängt vom Zählpunkt ab
    participation_factor = get_pf(metering_point_id)
    return generate_answer("", participation_factor)

def get_current_energy(metering_point_id: str) -> str: # consumption und generation hängt vom Zählpunkt ab
    current_energy = get_ce(metering_point_id)
    return generate_answer("", current_energy)

def get_community_consumption(
    start: str,
    end: str,
) -> str:
    mc_eg = get_mg_eg(start, end)
    plot = _create_plot(mc_eg)
    return generate_answer("", mc_eg, plot)

def get_community_generation(
    start: str,
    end: str,
) -> str:
    mg_eg = get_mg_eg(start, end)
    plot = _create_plot(mg_eg)
    return generate_answer("", mg_eg, plot)

def get_measured_energy(
    metering_point_id: str,
    start: str,
    end: str,
) -> str:
    me = get_me(start, end)
    plot = _create_plot(me)
    return generate_answer("", me, plot)

# ==== Operations ====

def calc_statistical_value(
    metering_point_id: str,
    start: str,
    end: str,
    statistic_type: str
) -> str:
    """
    Calculate a statistical value from an energy time series.
    """

    allowed_statistics = ["sum", "avg", "min", "max"]

    if statistic_type not in allowed_statistics:
        raise ValueError(
            f"Invalid statistic type. Allowed: {allowed_statistics}"
        )

    me = get_me(metering_point_id, start, end)
    statistical_value = get_statistical_value(statistic_type, me)
    return generate_answer("", statistical_value)

def add_timeseries(
    metering_point_id_1: str,
    metering_point_id_2: str,
    start: str,
    end: str
) -> str:
    me_1 = get_me(metering_point_id_1, start, end)
    me_2 = get_me(metering_point_id_2, start, end)
    me_added = add_ts([me_1, me_2])
    plot = _create_plot(me_added)
    return generate_answer("", plot)

def subtract_timeseries(
    metering_point_id_minuend: str,
    metering_point_id_subtrahend: str,
    start: str,
    end: str
) -> str:
    me_1 = get_me(metering_point_id_minuend, start, end)
    me_2 = get_me(metering_point_id_subtrahend, start, end)
    me_subtracted = subtract_ts([me_1, me_2])
    plot = _create_plot(me_subtracted)
    return generate_answer("", plot)

def multiply_timeseries(
    metering_point_id: str,
    start: str,
    end: str,
    factor: float
) -> str:
    me = get_me(metering_point_id, start, end)
    me_multiplied = multiply_ts(me, factor)
    plot = _create_plot(me_multiplied)
    return generate_answer("", plot)

def divide_timeseries(
    metering_point_id: str,
    start: str,
    end: str,
    divisor: float
) -> str:
    me = get_me(metering_point_id, start, end)
    me_divided = divide_ts(me, divisor)
    plot = _create_plot(me_divided)
    return generate_answer("", plot)

# ==== Derivated Data ====

def calculate_weighted_measured_energy(
    metering_point_id: str, # consumption und generation hängt vom Zählpunkt ab
    start: str, end: str,
) -> str:
    pf = get_pf(metering_point_id)
    me = get_me(metering_point_id, start, end)
    wme = multiply_ts(me, pf)
    plot = _create_plot(wme)
    return generate_answer("", wme, plot)

def calculate_community_potential(
    metering_point_id: str,
    start: str,
    end: str
) -> str:
    pf = get_pf(metering_point_id)
    mg_eg = get_mg_eg(start, end)
    cp = multiply_ts(mg_eg, pf)
    plot = _create_plot(cp)

def calculate_community_coverage(
    metering_point_id: str,
    start: str,
    end: str,
) -> str:
    # metering_point_id muss consumption sein, Verantwortung an LLM geben und einfach als falsch bewerten wenn falsch übergeben?
    pf = get_pf(metering_point_id)
    mg_eg = get_mg_eg(start, end)
    cp = multiply_ts(mg_eg, pf)

    mc = get_me(metering_point_id, start, end)
    wmc = multiply_ts(mc, pf)
    
    cc = min_ts(cp, wmc)

    plot = _create_plot(cc)
    return generate_answer("", cc, plot)

# ==== Not Supported ====

def request_not_supported(message: str) -> str:
    return generate_answer(message)