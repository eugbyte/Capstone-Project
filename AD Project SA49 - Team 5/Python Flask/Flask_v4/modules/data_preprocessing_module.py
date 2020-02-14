import pandas as pd    
import numpy as np

def encode_df_date_to_days(date_cell : str):
    month = date_cell.month
    year = date_cell.year
    day = date_cell.day

    #convert all dates into days
    starting_year = 2020
    year_to_days = (year - starting_year) * 365 
    month_to_days = 30 * (month -1)   #just a rough estimate
    return abs(day + month_to_days + year_to_days)

def encode_str_date_to_days(date_to_predict : str):
    date_to_predict = pd.DatetimeIndex([date_to_predict])

    month = date_to_predict[0].month
    year = date_to_predict[0].year
    day = date_to_predict[0].day
    
    #convert all dates into days
    starting_year = 2020
    year_to_days = (year - starting_year) * 365 
    month_to_days = 30 * (month - 1)   #just a rough estimate
    return abs(day + month_to_days + year_to_days)