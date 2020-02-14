package com.example.adprojectcx.representative.sharedClasses;

import android.os.AsyncTask;

import org.json.JSONObject;

import java.io.DataOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class UploadTask extends AsyncTask <String, Void, String> {

    //Dependency injection
    public interface ICallback {
        void redirect(String s);
    }
    private ICallback callback;
    public UploadTask(ICallback callback) {
        this.callback = callback;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected String doInBackground(String...params) {
        int statusCode = 0;

        try {
            URL url = new URL(params[0]);
            String jsonString = params[1];
            String restMethod = params[2].toUpperCase();
            //For debugging purpose
            JSONObject jsonObject = new JSONObject(jsonString);

            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod(restMethod);  //this should be PUT, but is POST to test against FireBase
            conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            DataOutputStream outstream = new DataOutputStream(conn.getOutputStream());
            outstream.writeBytes(jsonString);
            outstream.flush();
            outstream.close();

            statusCode = conn.getResponseCode();

        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return String.valueOf(statusCode);
    }

    @Override
    protected void onPostExecute(String s) {
        callback.redirect(s);
    }



}
