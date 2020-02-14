package com.example.adprojectcx.clerk.download;

import android.os.AsyncTask;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class DownloadAsyncTask extends AsyncTask<Command,Void , AsyncResponse> {

    private ICallback Callback;

    public DownloadAsyncTask(ICallback Callback) {
        this.Callback = Callback;
    }

    @Override
    protected void onPreExecute() {

    }

    @Override
    protected AsyncResponse doInBackground(Command... cmds) {
        Command cmd = cmds[0];
        this.Callback = cmd.callback;
        AsyncResponse asyncResponse = new AsyncResponse();
        asyncResponse.setNext_activity(cmd.next_activity);

        //Get Json from server and pass back
        Log.i("DownloadAsynTask", "doInBackground invoked");
        JSONArray jsonArray = null;
        JSONObject jsonObj = null;
        String stringJson = "";
        StringBuilder response = new StringBuilder();

        try {
            URL url = new URL(cmd.endPt);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //send data
            if(cmd.method.equals("Put")){
              //  conn.setDoOutput(true);
                conn.setRequestMethod("PUT");
           //     conn.setRequestProperty("Content-TYpe","application/json; charset=utf-8");
                DataOutputStream outstream = new DataOutputStream(conn.getOutputStream());
              //  outstream.writeBytes(cmd.data.toString());
                outstream.flush();
                Log.i("DownloadAsynTask1", "in Put");
                outstream.close();
            }
            if(cmd.method.equals("Post")){
                //  conn.setDoOutput(true);
                conn.setRequestMethod("POST");
                //     conn.setRequestProperty("Content-TYpe","application/json; charset=utf-8");
                DataOutputStream outstream = new DataOutputStream(conn.getOutputStream());
                //  outstream.writeBytes(cmd.data.toString());
                outstream.flush();
                Log.i("DownloadAsynTask1", "in Post");
                outstream.close();
            }
            // receive response
                InputStream input = new BufferedInputStream(conn.getInputStream());
                Log.i("DownloadAsynTask1", "after Inputstream");
                BufferedReader r = new BufferedReader(new InputStreamReader(input));
                for (String line; (line = r.readLine()) != null; ) {
                    response.append(line);
                }
                try {
                    asyncResponse.setStringJson(response.toString());
                } catch (Exception e) {
                    Log.i("DownloadAsynTask2", "catch exception 2 invoked");
                    e.printStackTrace();
                }
         //   }


        } catch (IOException e) {
            Log.i("DownloadAsynTask3", "catch exception 1 invoked");
            e.printStackTrace();
        }

        return asyncResponse;
    }


    public interface ICallback {
        void onServerResponse(String stringJson,String next_activity);
    }

    @Override
    protected void onPostExecute(AsyncResponse asyncResponse) {
        if(asyncResponse.getStringJson()!= null)
            this.Callback.onServerResponse(asyncResponse.getStringJson(),asyncResponse.getNext_activity());
    }

}

