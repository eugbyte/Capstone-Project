package com.example.adprojectcx.representative.collectItems;

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

public class CollectItemsActivity extends OptionMenuActivity implements DownloadCollectItemsTask.ICallback {

    private List<Container> containers = new ArrayList<Container>();
    private CollectItemsListAdapter collectItemsListAdapter;
    int employeeId = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_collect_items);

        employeeId = HelperMethods.getEmployeeId(getApplicationContext());

        final ListView listView = findViewById(R.id.list_view_collect_items);
        LayoutInflater inflater = getLayoutInflater();
        ViewGroup header = (ViewGroup)inflater.inflate(R.layout.listview_header_collect_items, listView, false);
        listView.addHeaderView(header);

        collectItemsListAdapter  = new CollectItemsListAdapter(CollectItemsActivity.this, R.layout.listview_row_request, containers);
        listView.setAdapter(collectItemsListAdapter);

        String downloadUrl = UrlStorage.GET_COLLECT_ITEMS + "/" + employeeId;
        DownloadCollectItemsTask downloadCollectItemsTask = new DownloadCollectItemsTask(CollectItemsActivity.this);
        downloadCollectItemsTask.execute(downloadUrl);
    }

    //Enforced interface methods
    @Override
    public void createToastOnDownload() {
        Toast msg = Toast.makeText(CollectItemsActivity.this, "beginning download", Toast.LENGTH_SHORT);
        msg.show();
    }
    @Override
    public ArrayAdapter<Container> getAdapter() {
        return collectItemsListAdapter;
    }

}
