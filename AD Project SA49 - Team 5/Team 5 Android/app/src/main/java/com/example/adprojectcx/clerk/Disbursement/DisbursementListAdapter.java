package com.example.adprojectcx.clerk.Disbursement;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;

import com.example.adprojectcx.R;
import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.clerk.download.Command;
import com.example.adprojectcx.clerk.download.DownloadAsyncTask;

import java.util.HashMap;
import java.util.List;

public class DisbursementListAdapter extends ArrayAdapter<HashMap> implements DownloadAsyncTask.ICallback {
    DownloadAsyncTask downloadAsyncTaskObject;
    private Context mContext;

    public DisbursementListAdapter(Context context, int chosenRowId, List<HashMap> items) {
        super(context, chosenRowId, items);
        this.mContext = context;
    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {
        Intent intent = new Intent(mContext, DisbursementActivity.class);
        mContext.startActivity(intent);
    }

    private static class RowItem{
        TextView no;
        TextView itemDes;
        TextView requestQty;
        TextView actualQty;
        TextView unit;
        Button setStatus;
    }

    @Override
    public View getView(final int position, View view, ViewGroup parent) {
        RowItem row = null;
        HashMap map = getItem(position);

        //Get reusable view
        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
        Log.i("DisbursementlListAdapter", "inside GetView");
        if (view == null) {

            view = inflater.inflate(R.layout.disbursement_row_listview,null);
            row = new RowItem();
            row.no = (TextView)view.findViewById(R.id.dis_No);
            row.itemDes = (TextView)view.findViewById(R.id.dis_itemDes);
            row.requestQty = (TextView)view.findViewById(R.id.dis_reqQty);
            row.actualQty = (TextView)view.findViewById(R.id.dis_actQty);
            row.unit = (TextView)view.findViewById(R.id.dis_unit);
            row.setStatus = view.findViewById((R.id.dis_Delivered));

            view.setTag(row);
        } else {

            row = (RowItem) view.getTag();
        }

        row.no.setText(map.get("No").toString());
        row.itemDes.setText(map.get("Desc").toString());
        row.requestQty.setText(map.get("ReqQty").toString());
        row.actualQty.setText(map.get("ActQty").toString());
        row.unit.setText(map.get("Unit").toString());
        row.setStatus.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                //call put task
                int disbursementDetailId =Integer.parseInt(getItem(position).get("DDid").toString());
                String putStatusUrl = UrlStorage.BASE_URL + "api/disbursement?disbursementStatusId=3&disbursementDetailId=%s";
                putStatusUrl = String.format(putStatusUrl,disbursementDetailId);
                Command com = new Command(DisbursementListAdapter.this,"get",putStatusUrl,null,"submit adjustment","Put");
                downloadAsyncTaskObject = new DownloadAsyncTask(DisbursementListAdapter.this);
                downloadAsyncTaskObject.execute(com);
            }
        });

        return view;
    }

}
