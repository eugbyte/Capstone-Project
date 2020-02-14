using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace ADProject
{
    public class UrlStorage
    {
        //Change your mssql base url here
        public static string MSSQL_NAME = "DESKTOP-" + "150K9PH";

        //Change your flask base url here
        public static string FLASK_BASE_URL = "http://127.0.0.1:5000/"; 


        public static string FLASK_LINEAR_REGRESSION_URL = FLASK_BASE_URL + "request";
        public static string FLASK_BAR_CHART = FLASK_BASE_URL + "barchart";


    }
    
}