package com.example.adprojectcx.representative.collectItems;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.representative.sharedClasses.BaseClassListAdapter;
import com.example.adprojectcx.representative.sharedClasses.Container;
import com.example.adprojectcx.representative.sharedClasses.UploadTask;
import com.example.adprojectcx.R;
import com.google.gson.Gson;

import java.util.List;

public class CollectItemsListAdapter extends BaseClassListAdapter implements UploadTask.ICallback {

    public CollectItemsListAdapter(Context context, int chosenRowId, List<Container> containers) {
        super(context, chosenRowId, containers);
    }

    //View lookup cache
    private static class ViewHolder {
        TextView requestDate;
        TextView itemDes;
        TextView location;
        TextView quantity;
        Button button;
    }

    @Override
    public View getView(int position, View rowConvertView, ViewGroup parent) {
        Container container = getItem(position);
        ViewHolder viewHolder;
        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);

        //If there are no existing rows to reuse, inflate the view
        if (rowConvertView == null) {
            viewHolder = new ViewHolder();
            rowConvertView = inflater.inflate(R.layout.listview_row_collect_items, parent, false);
            viewHolder.requestDate = (TextView)rowConvertView.findViewById(R.id.requestId_collect_items);
            viewHolder.itemDes = (TextView)rowConvertView.findViewById(R.id.itemDes_collect_items);
            viewHolder.quantity = (TextView)rowConvertView.findViewById(R.id.quantity_collect_items);
            viewHolder.location = (TextView)rowConvertView.findViewById(R.id.location_collect_items);
            viewHolder.button = (Button)rowConvertView.findViewById(R.id.button_collect_items);

            //Tags are used to store data related to views in the views themselves rather than by putting them in a separate structure.
            //store the ViewHolder object inside the fresh view
            rowConvertView.setTag(viewHolder);
        } else {
            //both ViewHolder and rowConvertView references the same tag object
            viewHolder = (ViewHolder) rowConvertView.getTag();
        }

        //populate the viewHolder object, which is referenced by rowConvertView
        String date = "";
        if (container.RequestDate != null) {
            date = container.RequestDate.split(" ")[0];
        }
        viewHolder.requestDate.setText(date);
        viewHolder.itemDes.setText(container.ItemDes);
        viewHolder.quantity.setText(String.valueOf(container.DisburseQuantity));
        viewHolder.location.setText(container.Location);
        viewHolder.button.setText("Accept");

        viewHolder.button.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                //upload json object
                try {
                    Gson gson = new Gson();
                    String jsonString = gson.toJson(container);
                    String url = UrlStorage.UPDATE_COLLECT_ITEMS;
                    String restMethod = "PATCH";

                    UploadTask uploadTask = new UploadTask(CollectItemsListAdapter.this);
                    uploadTask.execute(url, jsonString, restMethod);
                } catch (Exception exception) {
                    exception.printStackTrace();
                }
            }
        });

        return rowConvertView;
    }

    //Enforced interface methods
    public void redirect(String s) {
        Toast toast = Toast.makeText(mContext, s, Toast.LENGTH_SHORT);
        toast.show();
        Intent intent = new Intent(mContext, CollectItemsActivity.class);
        mContext.startActivity(intent);
    }


}
