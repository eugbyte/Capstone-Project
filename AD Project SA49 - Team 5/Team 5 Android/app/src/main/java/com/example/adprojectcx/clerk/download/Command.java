package com.example.adprojectcx.clerk.download;

import com.example.adprojectcx.clerk.download.DownloadAsyncTask;

import org.json.JSONObject;

public class Command {
    public DownloadAsyncTask.ICallback callback;
    public String context;
    public String endPt;
    public JSONObject data;
    public String next_activity;
    public String method;

    public Command(DownloadAsyncTask.ICallback callback, String context, String endPt, JSONObject data, String next_activity, String method)

    {this.callback = callback;this.context = context;this.endPt = endPt;this.data = data; this.next_activity = next_activity;this.method = method; }
}
