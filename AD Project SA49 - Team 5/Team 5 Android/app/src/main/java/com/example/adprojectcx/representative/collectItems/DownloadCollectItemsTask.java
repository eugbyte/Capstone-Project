package com.example.adprojectcx.representative.collectItems;

import android.os.AsyncTask;
import android.widget.ArrayAdapter;

import com.example.adprojectcx.representative.sharedClasses.BaseClassListAdapter;
import com.example.adprojectcx.representative.sharedClasses.Container;
import com.example.adprojectcx.representative.sharedClasses.HelperMethods;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class DownloadCollectItemsTask extends AsyncTask <String, Void, List<Container>> {

    //Dependency injection
    public interface ICallback {
        //Enforced interface methods...
        void createToastOnDownload();
        ArrayAdapter getAdapter();
    }
    private ICallback callback;
    public DownloadCollectItemsTask(ICallback callback) {
        this.callback = callback;
    }


    @Override
    protected void onPreExecute() {
        super.onPreExecute();
        callback.createToastOnDownload();
    }

    @Override
    protected List<Container> doInBackground(String...params) {
        List<Container> containers = new ArrayList<Container>();

        try {
            URL url = new URL(params[0]);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            containers = HelperMethods.convertJsonStringToContainers(conn);

        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return containers;

    }

    @Override
    protected void onPostExecute(List<Container> containers) {
        super.onPostExecute(containers);
        ArrayAdapter adapter = callback.getAdapter();

        ((BaseClassListAdapter)adapter).setContainers(containers);
        adapter.notifyDataSetChanged();
    }
}
