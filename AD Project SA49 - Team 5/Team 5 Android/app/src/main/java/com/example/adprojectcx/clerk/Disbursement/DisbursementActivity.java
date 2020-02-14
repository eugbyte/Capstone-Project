package com.example.adprojectcx.clerk.Disbursement;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Spinner;
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
import java.util.HashMap;
import java.util.List;

public class DisbursementActivity extends ClerkOptionMenuActivity implements AdapterView.OnItemSelectedListener, DownloadAsyncTask.ICallback{

    JSONArray disJArray;
    JSONObject holder;
    List<HashMap> Listdata = new ArrayList<>() ;
    Spinner dep_spinner;
    Spinner cp_spinner;
    DownloadAsyncTask downloadAsyncTaskObject;
    Command com;
    ListView DisbursementlistView;
    DisbursementListAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_disbursement);

        dep_spinner = (Spinner) findViewById(R.id.DepSpinner);
        ArrayAdapter<CharSequence> dep_adapter = ArrayAdapter.createFromResource(this,
                R.array.Departments, android.R.layout.simple_spinner_item);
        dep_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        dep_spinner.setAdapter(dep_adapter);
        dep_spinner.setSelection(0,false);
        dep_spinner.setOnItemSelectedListener(this);

        cp_spinner = (Spinner) findViewById(R.id.CPSpinner);
        ArrayAdapter<CharSequence> cp_adapter = ArrayAdapter.createFromResource(this,
                R.array.CollectionPts, android.R.layout.simple_spinner_item);
        cp_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        cp_spinner.setAdapter(cp_adapter);
        cp_spinner.setSelection(0,false);
        cp_spinner.setOnItemSelectedListener(this);

        DisbursementlistView = findViewById(R.id.Disbursement);
        LayoutInflater inflater = getLayoutInflater();
        ViewGroup header = (ViewGroup)inflater.inflate(R.layout.disbursement_listview_header, DisbursementlistView, false);
        DisbursementlistView.addHeaderView(header);
        adapter = new DisbursementListAdapter(this,R.layout.disbursement_row_listview,Listdata);
        DisbursementlistView.setAdapter(adapter);
        dowloadDisbursements();

    }

    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
        String cp = cp_spinner.getSelectedItem().toString();
        String dep = dep_spinner.getSelectedItem().toString();
        Toast.makeText(adapterView.getContext(),cp+" "+ dep,Toast.LENGTH_SHORT).show();
        int cpId = cp_spinner.getSelectedItemPosition();
        int depId = dep_spinner.getSelectedItemPosition();
        // Add a download task here to get the string json
        String DisbursementUrl = UrlStorage.BASE_URL + "api/disbursement?collectionPointId=%s&departmentId=%s&disbursementStatusId=0";
        DisbursementUrl = String.format(DisbursementUrl,cpId,depId);
        com = new Command(this,"get",DisbursementUrl,null,"Inventory","Get");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);


    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {

        try {
            disJArray = new JSONObject(stringJson).getJSONArray("disbursementInfos");

        } catch (JSONException e) {
            e.printStackTrace();
        }
        Listdata.clear();
        for(int i =0; i< disJArray.length();i++){
            HashMap<String, String> data = new HashMap<String, String>();
            try {

                // Convert JSON array into hashmap list
                holder = disJArray.getJSONObject(i);
                data.put("No",Integer.toString(i+1));
                data.put("Desc",holder.getString("itemDesc"));
                data.put("ReqQty",Integer.toString(holder.getInt("requestQty")));
                data.put("ActQty",Integer.toString(holder.getInt("disbursementQty")));
                data.put("Unit",holder.getString("unitOfMeasurement"));
                data.put("DDid",holder.getString("disbursementdetailId"));
                Listdata.add(data);

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        adapter.notifyDataSetChanged();

    }

    public void dowloadDisbursements(){
        String DisbursementUrl = UrlStorage.GET_DISBURSEMENTS;
        com = new Command(this,"get",DisbursementUrl,null,"Inventory","Get");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);
    }
}
