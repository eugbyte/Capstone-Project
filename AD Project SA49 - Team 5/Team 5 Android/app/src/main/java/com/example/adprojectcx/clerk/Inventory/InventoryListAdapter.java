package com.example.adprojectcx.clerk.Inventory;

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

import java.util.HashMap;
import java.util.List;

public class InventoryListAdapter extends ArrayAdapter<HashMap>{
    private Context mContext;

    public InventoryListAdapter(Context context, int chosenRowId, List<HashMap> items) {
        super(context, chosenRowId, items);
        this.mContext = context;
    }

    private static class RowItem{
        TextView itemId;
        TextView itemDes;
        TextView location;
        TextView quantity;
        TextView unit;
        Button adjust_btn;
    }

    @Override
    public View getView(final int position, View view, ViewGroup parent) {
        RowItem row = null;
        HashMap map = getItem(position);
        Log.i("InventoryListAdapter", "inside GetView");
        //Get reusable view
        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);

        if (view == null) {

            view = inflater.inflate(R.layout.inventory_row_listview,null);
            row = new RowItem();
           // row.itemId = (TextView)view.findViewById(R.id.itemId);
            row.itemDes = (TextView)view.findViewById(R.id.itemDes);
            row.location = (TextView)view.findViewById(R.id.location);
            row.quantity = (TextView)view.findViewById(R.id.quantity);
            row.unit = (TextView)view.findViewById(R.id.unit);
            row.adjust_btn = (Button)view.findViewById(R.id.Adj_btn);

            view.setTag(row);
        } else {

            row = (RowItem) view.getTag();
        }

   //     row.itemId.setText(map.get("ID").toString());
        row.itemDes.setText(map.get("Desc").toString());
        row.location.setText(map.get("Location").toString());
        row.quantity.setText(map.get("Qty").toString());
        row.unit.setText(map.get("Unit").toString());
        row.adjust_btn.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                // send id to next activity
                adjustment(Integer.parseInt(getItem(position).get("ID").toString()));
                String id = getItem(position).get("ID").toString();
                Log.i("InventoryListAdapter", "inside GetView" +"adjust item "+ id );

            }
        });

        return view;
    }

    public void adjustment(int itemId){

        Intent intent = new Intent(mContext, AdjustmentEntryActivity.class);
        intent.putExtra("itemId", itemId);
        mContext.startActivity(intent);


    }

}

