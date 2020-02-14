package com.example.adprojectcx.representative.sharedClasses;

import org.json.JSONObject;

import java.io.Serializable;

public class Container implements Serializable {
    public int CategoryId;
    public String CategoryDescription;

    public int CollectionPointId;
    public String Location;

    public int DepartmentId;

    public int ItemCatalogueId;
    public String ItemDes;

    public int RequestDetailId;
    public int Quantity;

    public int RequestId;
    public String RequestDate;

    public int RequestStatusId;
    public String RequestStatusDescription;

    public int DisbursementId;
    public int DisburseQuantity;

    public int EmployeeId;
    public String DepName;

    public Container() {
        super();
    }

    public Container(int requestId, int quantity, String itemDes) {
        this.RequestId = requestId;
        this.Quantity = quantity;
        this.ItemDes = itemDes;
    }

    public Container(JSONObject jsonObject) {
        try {
            if (jsonObject.has("CategoryId"))
                this.CategoryId = jsonObject.getInt("CategoryId");

            if (jsonObject.has("CategoryDescription"))
                this.CategoryDescription = jsonObject.getString("CategoryDescription");

            if (jsonObject.has("CollectionPointId"))
                this.CollectionPointId = jsonObject.getInt("CollectionPointId");

            if (jsonObject.has("Location"))
                this.Location = jsonObject.getString("Location");

            if (jsonObject.has("DepartmentId"))
                this.DepartmentId = jsonObject.getInt("DepartmentId");

            if (jsonObject.has("ItemCatalogueId"))
                this.ItemCatalogueId = jsonObject.getInt("ItemCatalogueId");

            if (jsonObject.has("ItemDes"))
                this.ItemDes = jsonObject.getString("ItemDes");

            if (jsonObject.has("RequestDetailId"))
                this.RequestDetailId = jsonObject.getInt("RequestDetailId");

            if (jsonObject.has("RequestDate"))
                this.RequestDate = jsonObject.getString("RequestDate");

            if (jsonObject.has("Quantity"))
                this.Quantity = jsonObject.getInt("Quantity");

            if (jsonObject.has("RequestId"))
                this.RequestId = jsonObject.getInt("RequestId");

            if (jsonObject.has("RequestStatusDescription"))
                this.RequestStatusDescription = jsonObject.getString("RequestStatusDescription");

            if (jsonObject.has("RequestStatusId"))
                this.RequestStatusId = jsonObject.getInt("RequestStatusId");

            if (jsonObject.has("DisbursementId"))
                this.DisbursementId = jsonObject.getInt("DisbursementId");

            if (jsonObject.has("DisburseQuantity"))
                this.DisburseQuantity = jsonObject.getInt("DisburseQuantity");

            if (jsonObject.has("EmployeeId"))
                this.EmployeeId = jsonObject.getInt("EmployeeId");

            if (jsonObject.has("DepName"))
                this.DepName = jsonObject.getString("DepName");



        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }
}
