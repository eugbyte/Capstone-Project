package com.example.adprojectcx.clerk.Inventory;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ListView;

import com.example.adprojectcx.R;
import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.clerk.download.Command;
import com.example.adprojectcx.clerk.download.DownloadAsyncTask;
import com.example.adprojectcx.representative.sharedClasses.ClerkOptionMenuActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class StockTaking extends ClerkOptionMenuActivity implements DownloadAsyncTask.ICallback {
    JSONArray inventoryArray;
    JSONArray dataArray;
    JSONObject holder;
    DownloadAsyncTask downloadAsyncTaskObject;
    List<HashMap> Listdata = new ArrayList<>();
    InventoryListAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_stock_taking);

        final ListView InventorylistView = findViewById(R.id.Inventory);
        LayoutInflater inflater = getLayoutInflater();
        ViewGroup header = (ViewGroup)inflater.inflate(R.layout.inventory_listview_header, InventorylistView, false);
        InventorylistView.addHeaderView(header);
         adapter = new InventoryListAdapter(this,R.layout.inventory_row_listview,Listdata);
        InventorylistView.setAdapter(adapter);
        dowloadInventory();

        Intent callerIntent = getIntent();
        if(callerIntent != null){

        }
    }

    public void dowloadInventory(){
        String inventoryUrl = UrlStorage.BASE_URL + "api/inventory?search=&StockStatus=";
        Command com = new Command(this,"get",inventoryUrl,null,"Inventory","Get");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);
    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {

        try {
            dataArray = new JSONArray(stringJson);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        Listdata.clear();
        for(int i =0; i<dataArray.length();i++){
            HashMap<String, String> data = new HashMap<String, String>();
            try {

                // Convert JSON array into hashmap list
                holder = dataArray.getJSONObject(i);
                data.put("Desc",holder.getString("description"));
                data.put("Location",holder.getString("location"));
                data.put("Unit",holder.getString("unit"));
                data.put("Qty",Integer.toString(holder.getInt("quantity")));
                data.put("ID",Integer.toString(holder.getInt("itemId")));
                Listdata.add(data);

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        adapter.notifyDataSetChanged();
    }
}
