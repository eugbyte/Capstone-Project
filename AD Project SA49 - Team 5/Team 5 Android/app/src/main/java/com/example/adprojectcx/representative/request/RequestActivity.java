package com.example.adprojectcx.representative.request;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.representative.sharedClasses.Container;
import com.example.adprojectcx.representative.sharedClasses.HelperMethods;
import com.example.adprojectcx.representative.sharedClasses.OptionMenuActivity;
import com.example.adprojectcx.R;

import java.util.ArrayList;
import java.util.List;

public class RequestActivity extends OptionMenuActivity implements DownloadRequestTask.ICallback {
    private List<Container> containers = new ArrayList<Container>();
    private RequestListAdapter requestListAdapter;
    private int employeeId = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_request);

        employeeId = HelperMethods.getEmployeeId(getApplicationContext());

        final ListView listView = findViewById(R.id.list_view);
        LayoutInflater inflater = getLayoutInflater();
        ViewGroup header = (ViewGroup)inflater.inflate(R.layout.listview_header_request, listView, false);
        listView.addHeaderView(header);

        requestListAdapter  = new RequestListAdapter(RequestActivity.this, R.layout.listview_row_request, containers);
        listView.setAdapter(requestListAdapter);

        String downloadUrl = UrlStorage.GET_REQUESTS;
        DownloadRequestTask downloadTask = new DownloadRequestTask(RequestActivity.this);
        downloadTask.execute(downloadUrl);

    }

    //Enforced interface methods
    @Override
    public void createToastOnDownload() {
        Toast msg = Toast.makeText(RequestActivity.this, "beginning download", Toast.LENGTH_LONG);
        msg.show();
    }
    @Override
    public ArrayAdapter<Container> getAdapter() {
        return requestListAdapter;
    }

}
