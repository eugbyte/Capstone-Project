package com.example.adprojectcx.clerk.Inventory;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.adprojectcx.R;
import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.clerk.download.Command;
import com.example.adprojectcx.clerk.download.DownloadAsyncTask;
import com.example.adprojectcx.representative.sharedClasses.ClerkOptionMenuActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class AdjustmentEntryActivity extends ClerkOptionMenuActivity implements AdapterView.OnItemSelectedListener, DownloadAsyncTask.ICallback {
    DownloadAsyncTask downloadAsyncTaskObject;
    TextView itemIdField;
    TextView itemDescField;
    EditText adjQtyField;
    EditText adjReasonField;
    Spinner voucherlist;
    int selectedVoucherId;
    int itemId;
    int empId;

    ArrayList<Integer> voucherIdList = new ArrayList<>();
    ArrayAdapter<Integer> spinnerArrayAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_adjustment_entry);
        SharedPreferences pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
        empId = pref.getInt("employeeId",1);

        itemIdField = findViewById(R.id.Adj_item_id);
        itemDescField = findViewById(R.id.Adj_itemDesc);
        adjQtyField = findViewById(R.id.Adj_qty);
        adjReasonField = findViewById(R.id.Adj_reason);
        Button sub_btn = findViewById(R.id.Adj_sub_btn);
        Button create_new = findViewById(R.id.Adj_create_new_voucher);

        voucherlist = findViewById(R.id.vouchers_spinner);
        // Initializing an ArrayAdapter

        spinnerArrayAdapter = new ArrayAdapter<Integer>(
                this,android.R.layout.simple_spinner_item ,voucherIdList);
        spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        voucherlist.setAdapter(spinnerArrayAdapter);
        voucherlist.setSelection(0,false);
        voucherlist.setOnItemSelectedListener(this);

        Intent callerIntent = getIntent();
        itemId = callerIntent.getIntExtra("itemId",0);

        // If itemId is not 0, call download
        download(itemId,empId);

        sub_btn.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                // send reqest to server
                int adjustQty = Integer.parseInt(adjQtyField.getText().toString());
                String reason = adjReasonField.getText().toString();
                submit(adjustQty,reason,selectedVoucherId,itemId);
                Log.i("AdjustmentEntryActivity", "Submit to server"  );

            }
        });

        create_new.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                // send reqest to server
                createNewVoucher(empId);
                Log.i("AdjustmentEntryActivity", "create new voucher"  );

            }
        });

    }

    public void download(int itemId, int empId){
        if(itemId != 0){
            String AdjUrl = UrlStorage.BASE_URL + "api/inventory?itemId=%s&empId=%s";
            AdjUrl = String.format(AdjUrl, itemId,empId);
            Command com = new Command(this,"get",AdjUrl,null,"show adjustment detail","Get");
            downloadAsyncTaskObject = new DownloadAsyncTask(this);
            downloadAsyncTaskObject.execute(com);
        }
    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {
        if(next_activity.equals("show adjustment detail"))
        {
            try {
                JSONObject response = new JSONObject(stringJson);
                itemIdField.setText(String.valueOf(response.getInt("itemId")));
                itemDescField.setText(response.getString("itemDesc"));
                JSONArray idArray = response.getJSONArray("voucherId");
                voucherIdList.clear();
                for(int i =0; i<idArray.length();i++ ){
                    voucherIdList.add(idArray.getInt(i));
                }
                spinnerArrayAdapter.notifyDataSetChanged();
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if(next_activity.equals("submit adjustment"))
        {
            Toast.makeText(getApplicationContext(),"Adjustment Submitted",Toast.LENGTH_SHORT).show();
            return;
        }
        if(next_activity.equals("refresh"))
        {
            //Refresh page
            download(itemId,empId);
            spinnerArrayAdapter.notifyDataSetChanged();
            return;
        }


    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        selectedVoucherId = (Integer) parent.getItemAtPosition(position);

    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    public void submit(int adjusQty, String VoucherReason, int VoucherId, int ItemId){

            String putAdjUrl = UrlStorage.BASE_URL + "api/inventory?adjusQty=%s&VoucherReason=%s&VoucherId=%s&ItemId=%s";
            putAdjUrl = String.format(putAdjUrl,adjusQty,VoucherReason,VoucherId,ItemId);
            Command com = new Command(this,"put",putAdjUrl,null,"submit adjustment","Put");
            downloadAsyncTaskObject = new DownloadAsyncTask(this);
            downloadAsyncTaskObject.execute(com);

    }

    public void createNewVoucher(int empId){

        String postAdjUrl = UrlStorage.BASE_URL + "api/inventory?empId=%s";
        postAdjUrl = String.format(postAdjUrl,empId);
        Command com = new Command(this,"post",postAdjUrl,null,"refresh","Post");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);

    }
}
