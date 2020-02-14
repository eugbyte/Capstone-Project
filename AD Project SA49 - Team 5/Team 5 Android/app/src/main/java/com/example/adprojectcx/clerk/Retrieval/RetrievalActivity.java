package com.example.adprojectcx.clerk.Retrieval;

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

public class RetrievalActivity extends ClerkOptionMenuActivity implements DownloadAsyncTask.ICallback {
    JSONObject RetrievalJObj;
    JSONArray Group;
    JSONObject holder;
    List<HashMap> Groupdata = new ArrayList<>();
    DownloadAsyncTask downloadAsyncTaskObject;
    RetrievalListAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_retrieval);

        final ListView RetrievallistView = findViewById(R.id.Retrieval);
        LayoutInflater inflater = getLayoutInflater();
        ViewGroup header = (ViewGroup)inflater.inflate(R.layout.retrieval_listview_header, RetrievallistView, false);
        RetrievallistView.addHeaderView(header);
        adapter = new RetrievalListAdapter(this,R.layout.retrieval_row_listview,Groupdata);
        RetrievallistView.setAdapter(adapter);
        dowloadRetrieval();
    }

    public void dowloadRetrieval(){
        String retrievalUrl = UrlStorage.GET_RETRIEVAL;
        Command com = new Command(this,"get",retrievalUrl,null,"Retrieval","Get");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);
    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {
        try {
            RetrievalJObj = new JSONObject(stringJson);
            Group = RetrievalJObj.getJSONArray("groupInfos");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        Groupdata.clear();
        for(int i =0; i<Group.length();i++){
            HashMap<String, String> data = new HashMap<String, String>();
            try {
                // Convert JSON array into hashmap list
                holder = Group.getJSONObject(i);
                data.put("No",Integer.toString(i+1));
                data.put("Desc",holder.getString("itemdes"));
                data.put("Location",holder.getString("itemlocation"));
                data.put("ReqQty",Integer.toString(holder.getInt("totalReqQty")));
                Groupdata.add(data);

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        adapter.notifyDataSetChanged();

    }
}
