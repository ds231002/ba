def get_metering_points():
    return ["cp1", "cp2", "cp3"]

def get_participation_factor(metering_point):
    pass


def get_astronomical_sun_hours(start, end): # h
    pass

def get_community_coverage(start, end): # kWh
    pass

def get_community_potential(start, end): # kWh
    pass

def get_current_power_consumption(): # kW
    pass

def get_current_power_generation(): # kW
    pass

def get_epex_spot_day_ahead_price_1h_at(): # ct/kWh
    pass

def get_measured_consumption(start, end): # kWh
    pass

def get_measured_generation(start, end): # kWh
    pass

def get_predicted_consumption(timestamp): # kWh
    pass

def get_predicted_generation(timestamp): # kWh
    pass

def get_surplus_generation(start, end): # kWh
    pass

# weighted

def get_weighted_measured_consumption(start, end): # kWh
    pass

def get_weighted_measured_generation(start, end): # kWh
    pass

def get_weighted_predicted_consumption(start, end): # kWh
    pass

def get_weighted_predicted_generation(start, end): # kWh
    pass

def get_weighted_surplus_generation(start, end): # kWh
    pass