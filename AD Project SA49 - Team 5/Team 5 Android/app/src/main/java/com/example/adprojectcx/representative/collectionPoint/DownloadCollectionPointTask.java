package com.example.adprojectcx.representative.collectionPoint;

import android.os.AsyncTask;

import com.example.adprojectcx.representative.sharedClasses.Container;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class DownloadCollectionPointTask extends AsyncTask <String, Void, Object[] > {

    //Dependency injection
    public interface ICallback {
        //Enforced interface methods...
        void updateSelectList(List<Container> containers);
        void setCurrentLocation(String location);
    }
    private ICallback callback;
    public DownloadCollectionPointTask(ICallback callback) {
        this.callback = callback;
    }


    @Override
    protected Object[] doInBackground(String...params) {
        List<Container> containers = new ArrayList<Container>();
        String location = null;

        try {
            URL url = new URL(params[0]);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.connect();
            InputStream is = conn.getInputStream();

            //Write the stream
            byte[] b = new byte[1024];
            ByteArrayOutputStream byteResponse = new ByteArrayOutputStream();
            while (is.read(b) != -1) {
                byteResponse.write(b);
            }
            //Convert the bytes to string
            String JSONResponse = new String(byteResponse.toByteArray());

            JSONObject jsonObj = new JSONObject(JSONResponse);

            location = jsonObj.getString("currentLocation");
            JSONArray jsonArray = jsonObj.getJSONArray("allCollectionPoints");

            //Convert the JsonArray to List<Container>
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                Container container = new Container(jsonObject);
                containers.add(container);

            }
        }catch (Exception exception) {
            exception.printStackTrace();
        }

        Object[] objects = new Object[] {location, containers};

        return objects;

    }

    @Override
    protected void onPostExecute(Object[] objects) {
        super.onPostExecute(objects);

        String location = (String)objects[0];
        callback.setCurrentLocation(location);

        List<Container> containers = (List<Container>)objects[1];
        callback.updateSelectList(containers);
    }
}
