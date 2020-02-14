package com.example.adprojectcx.clerk.Retrieval;


import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.example.adprojectcx.R;

import java.util.HashMap;
import java.util.List;

public class RetrievalListAdapter extends ArrayAdapter<HashMap> {
    private Context mContext;
    private List<HashMap> mitems;

    public RetrievalListAdapter(Context context, int chosenRowId, List<HashMap> items) {
        super(context, chosenRowId, items);
        this.mContext = context;
        this.mitems = items;
    }

    @Override
    public int getCount() {
        return mitems.size();
    }
    @Override
    public HashMap getItem(int position) {
        return mitems.get(position);
    }


    private static class RowItem{
        TextView No;
        TextView itemDes;
        TextView location;
        TextView reqty;

    }

    @Override
    public View getView(int position, View view, ViewGroup parent) {
        RowItem row = null;
        HashMap map = getItem(position);
        Log.i("RetrievalListAdapter", "inside GetView");
        //Get reusable view
        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);

        if (view == null) {
            view = inflater.inflate(R.layout.retrieval_row_listview,null);
            row = new RowItem();
            row.No = (TextView)view.findViewById(R.id.Re_itemNo);
            row.itemDes = (TextView)view.findViewById(R.id.Re_itemDes);
            row.location = (TextView)view.findViewById(R.id.Re_location);
            row.reqty = (TextView)view.findViewById(R.id.Re_req_qty);

            view.setTag(row);
        } else {

            row = (RowItem) view.getTag();
        }

        row.No.setText(map.get("No").toString());
        row.itemDes.setText(map.get("Desc").toString());
        row.location.setText(map.get("Location").toString());
        row.reqty.setText(map.get("ReqQty").toString());

        return view;
    }

}

