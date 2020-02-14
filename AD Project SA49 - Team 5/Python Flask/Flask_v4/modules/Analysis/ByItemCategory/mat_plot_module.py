import pandas as pd    
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import base64
from matplotlib.font_manager import FontProperties

def get_graph(df, date_to_predict, predicted_quantity, gradient, intercept):
    #a Figure object can contain multiple Axes, i.e. graphs
    fig, ax = plt.subplots() 

    #plot() plots the best fit line, i.e. y = mx + c
    max_x = df['Quantity'].max()
    x = np.linspace(0, max_x, 100)
    y = gradient * x + intercept
    plt.plot(x, y, '-g', label='best fit line')

    #scatter() plots individual scatter point
    ax.scatter(df["Date"], df["Quantity"], c = 'red', label='Past requests')
    ax.set(xlabel='Date(Days)', ylabel='Quantity')

    #plot the predicted value
    ax.scatter(date_to_predict, predicted_quantity, c ='yellow', label='Predicted quantity' )

    #show grid lines
    ax.grid()

    #display the legend
    fontP = FontProperties()
    fontP.set_size('small')
    plt.legend(loc='upper left', prop=fontP)
    
    #save the image
    fig.savefig('plot.png')
 
    with open("plot.png", "rb") as imageFile:
        bytes_base64 = base64.b64encode(imageFile.read())
    return bytes_base64

def plotdemand(requests):
    #Convert the requests list into df
    df_request = pd.DataFrame(requests, columns = ['ItemId' , 'Description', 'Predicted Demand','Stock Level'])
    #Sum them up by Id and description
    df_grouped = df_request.groupby(['ItemId','Description','Stock Level'])[['Predicted Demand']].sum().reset_index()
    df_plot = df_grouped.set_index('Description')
    ax = df_plot[['Predicted Demand','Stock Level']].plot(kind='bar', title ="Predicted Demand Vs Stock level", figsize=(15, 10), legend=True, fontsize=12,rot =0)
    ax.set_xlabel("Item", fontsize=12)
    ax.set_ylabel("Quantity", fontsize=12)
    ax.figure.savefig('demandgraph.png')

    with open("demandgraph.png", "rb") as imageFile:
        bytes_base64 = base64.b64encode(imageFile.read())
    #Need to decode again as Json cannot take in byte sequences
    Img_Str = bytes_base64.decode('utf-8')
    # Put result back in a list
    analyticsList: list =[]
    for index, row in df_grouped.iterrows():
        analytics ={ 
            "ItemId": row['ItemId'],
            "ItemDescription": row['Description'],
            "PredictedDemand": row['Predicted Demand'],
            "Stock Level": row['Stock Level']
        }
        analyticsList.append(analytics)

    result = {        
        "AnalyticsResult": analyticsList,
        "img": Img_Str
    }
    return result
