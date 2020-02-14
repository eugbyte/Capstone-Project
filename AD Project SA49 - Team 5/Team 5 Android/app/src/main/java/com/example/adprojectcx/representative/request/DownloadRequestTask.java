package com.example.adprojectcx.representative.request;

import android.os.AsyncTask;
import android.widget.ArrayAdapter;

import com.example.adprojectcx.representative.sharedClasses.BaseClassListAdapter;
import com.example.adprojectcx.representative.sharedClasses.Container;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class DownloadRequestTask extends AsyncTask <String, Void, List<Container>> {

    //Dependency injection
    public interface ICallback {
        //Enforced interface methods...
        void createToastOnDownload();
        ArrayAdapter getAdapter();
    }
    private ICallback callback;
    public DownloadRequestTask(ICallback callback) {
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
            conn.connect();
            InputStream is = conn.getInputStream();

            //Write the stream
            byte[] b = new byte[1024];
            ByteArrayOutputStream byteResponse = new ByteArrayOutputStream();
            while(is.read(b) != -1) {
                byteResponse.write(b);
            }
            //Convert the bytes to string
            String JSONResponse =  new String(byteResponse.toByteArray());
            //Convert the string to json
            JSONArray jsonArr = new JSONArray(JSONResponse);

            //Convert the JsonArray to List<Container>
            for (int i = 0; i < jsonArr.length(); i++) {
                JSONObject jsonObject = jsonArr.getJSONObject(i);
                Container container = new Container(jsonObject);
                containers.add(container);
            }

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
