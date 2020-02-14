import pandas as pd    
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
import copy
import modules.data_preprocessing_module as DataEncodingModule
import modules.Analysis.ByItemCategory.mat_plot_module as PlotModule

def get_df(dates: list, quantities: list):
    df = pd.DataFrame ({
    "Date": dates,
    "Quantity" : quantities
    })
    df['Date'] = pd.to_datetime(df['Date'])
    print(df.head())
    return df

def linear_regression(dates: list, quantities: list, date_to_predict: str = '2020-02-03'):
    date_to_predict : int = DataEncodingModule.encode_str_date_to_days(date_to_predict)    
    date_to_predict : np.array = ( np.array(date_to_predict) ).reshape(-1, 1)

    df = get_df(dates, quantities)
    df_before_encoding = copy.copy(df)

    #convert date to number of days. Day 1 is 1st Jan 2020
    df["Date"] = df["Date"].apply(lambda date : DataEncodingModule.encode_df_date_to_days(date))
    #print(df.head())
    #     Date  Quantity
    # 0    58        17
    # 1    57         7   

    #need to reshape to 2d array because the model expects 2d rows, not a 1d list
    x = df['Date']
    x = (x.to_numpy()).reshape(-1, 1)
    #print(x.shape) #(17, 1)
    y = df["Quantity"]
    #print(y.shape) #(17, )
    x_train, x_test, y_train, y_test = train_test_split(x, y, random_state = 1)

    linReg = LinearRegression()
    linReg.fit(x_train, y_train)

    intercept = linReg.intercept_.sum() #convert the length 1 [] into a number
    gradient = linReg.coef_.sum() #convert the length 1 [] into a number

    y_pred : list = linReg.predict(x_test)

    #predict what the user requested
    predicted_quantity = linReg.predict(date_to_predict)
    predicted_quantity = predicted_quantity.sum()
    
    mean_squared_err  = mean_squared_error(y_test, y_pred)
    rsquare  = r2_score(y_test, y_pred)

    #logic to generate image
    img : bytes = PlotModule.get_graph(df, date_to_predict, predicted_quantity, gradient, intercept)
    #Need to decode again as Json cannot take in byte sequences
    Img_Str : str = img.decode('utf-8')
    #return the json result
    result = {        
        "requested_pred_quantity": predicted_quantity,
        "y_pred_quantity": y_pred.tolist(),
        "y_test_quantity": y_test.tolist(),
        "mean_squared_err": mean_squared_err,
        "rsquare": rsquare,
        "intercept": intercept,
        "gradient": gradient,
        "img": Img_Str
    }
    print(result["requested_pred_quantity"])
    print(result["rsquare"])
    return result