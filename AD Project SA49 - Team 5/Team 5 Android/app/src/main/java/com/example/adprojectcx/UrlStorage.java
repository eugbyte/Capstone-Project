package com.example.adprojectcx;

public class UrlStorage {

    //Change your base url here
    public static String BASE_URL = "http://10.0.2.2:44351/";

    //Urls for employee
    public static String GET_COLLECTION_POINT = BASE_URL + "api/representative/changeCollectionPoint";
    public static String UPDATE_COLLECTION_POINT = BASE_URL + "api/representative/changeCollectionPoint";
    public static String GET_COLLECT_ITEMS = BASE_URL + "api/representative/collectItems";
    public static String UPDATE_COLLECT_ITEMS = BASE_URL + "api/representative/collectItems";
    public static String GET_REQUESTS = BASE_URL + "api/request";

    //Urls for clerk
    public static String GET_DISBURSEMENTS = BASE_URL + "api/disbursement?collectionPointId=0&departmentId=0&disbursementStatusId=0";
    public static String GET_RETRIEVAL = BASE_URL + "api/retrieval";

}
