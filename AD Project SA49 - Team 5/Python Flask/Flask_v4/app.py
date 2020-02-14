from flask import Flask, request, jsonify

#modules with helper methods
import modules.parse_json_module as ParseJsonModule
import modules.Analysis.ByItemCategory.linear_regression_module as LinRegModule
import modules.Analysis.ByItemCategory.mat_plot_module as PlotModule

app = Flask(__name__)

@app.route("/", methods=["GET"])
def helloWorld(): 
    return "Hello World"

@app.route("/request", methods=["POST"])
def receiveRequests():
    json_object : list[object] = request.json
    print(json_object)
    #right now, assume you only receive items of the same category
    #so you are just concerned with date against time
    dates : list = ParseJsonModule.get_date_list(json_object)
    quantities : list = ParseJsonModule.get_quantity_list(json_object)
    date_to_predict : str = ParseJsonModule.date_to_predict(json_object)
    print(date_to_predict)

    #json result to return
    result: object = LinRegModule.linear_regression(dates, quantities, date_to_predict)
    jsonResult = jsonify(result)
    return jsonResult

@app.route("/demandAnalysis", methods=["POST"])
def demandAnalysis():
    json_object : list[object] = request.json

    requests : list = ParseJsonModule.get_request_list(json_object)

    #json result to return
    result: object = PlotModule.plotdemand(requests)
    jsonResult = jsonify(result)
    return jsonResult


if __name__ == '__main__':
    app.run(debug=True)





    
