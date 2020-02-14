def get_date_list(json_object : object):
    department_requests = json_object['DepartmentRequests']
    dates : list = []
    for department_request in department_requests:
        date : str = department_request['RequestDate']
        date = date.split("T")[0]
        dates.append(date)
    return dates;

def get_quantity_list(json_object : object):
    department_requests = json_object['DepartmentRequests']
    quantity : list = []
    for department_request in department_requests:
        quantity.append(department_request['Quantity'])
    return quantity

def date_to_predict(json_object: object):
    date_to_predict : str = json_object['DateToPredict']
    return date_to_predict

def get_category_list(json_object: object):
    department_requests = json_object['DepartmentRequests']
    categories = []
    for department_request in department_requests:
        categories.append(department_request['CategoryDescription'])
    return categories

# CX's addition

def get_request_list(json_object: object):
    department_requests = json_object['DepartmentRequests']
    requests : list = []
    for department_request in department_requests:
        itemId : int = department_request['ItemId']
        itemDescription : str = department_request['ItemDescription']
        quantity : int = department_request['Quantity']
        stocklevel : int = department_request['StockLevel']
        request : list =[itemId,itemDescription,quantity,stocklevel ]
        requests.append(request)
    return requests
