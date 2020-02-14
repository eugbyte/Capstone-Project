# Capstone-Project
Content Management System. Communication of data through web application, android app and machine learning flask application.

# Contribution Report

This is a group project. My contributions are:
1. Developed .Net MVC application for clerk, department head, representative. Developed controllers, Views and related service classes and ViewModels for Requests, Store Retrieval, Disbursement, Delegate Authority, Collect Items and Authorization and Authentication Filters.
2. Developed .Net Web API controller for department representative to communicate with Android application. Developed RequestRestController and DisbursementRestController in the APIs folder.
3. Developed Android mobile applications for department representative.
4. Developed Flask API to communicate linear regression results with .Net MVC application.

# How to run

Readme

Visual Studio
1. To run the visual studio solution, please use the SQL script provided to create the database in your SQL server.
2. Next, open the ASP application. Under the StringsStorage folder, go to the UrlStorage.cs class and change the MSSQL_NAME variable to match your own sql server name 
3. After that, the application will be able to connect with the database.

Android
1. To run the android application, please run it in the  android studio.
2. Go to the UrlStorage.java class and change the BASE_URL variable to match that of your visual studio. For example, if the visual studio address is 127.0.0.1:44351, then the BASE_URL variable should be changed to "http://10.0.2.2:44351/"

Python Flask
1. To run the python flask, please run python app.py in your terminal.
2. Go the the ASP application, locate the UrlStroage.cs class, and change the FLASK_BASE_URL to match your flask address 
