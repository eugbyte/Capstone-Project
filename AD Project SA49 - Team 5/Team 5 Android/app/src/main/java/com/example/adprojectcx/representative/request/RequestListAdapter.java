package com.example.adprojectcx.representative.request;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.adprojectcx.representative.sharedClasses.BaseClassListAdapter;
import com.example.adprojectcx.representative.sharedClasses.Container;
import com.example.adprojectcx.R;

import java.util.List;

public class RequestListAdapter extends BaseClassListAdapter {

    public RequestListAdapter(Context context, int chosenRowId, List<Container> containers) {
        super(context, chosenRowId, containers);
    }

    //View lookup cache
    private static class ViewHolder {
        TextView requestDate;
        TextView itemDes;
        TextView requestStatusDescription;
        TextView quantity;
    }

    @Override
    public View getView(int position, View rowConvertView, ViewGroup parent) {
        Container container = getItem(position);
        ViewHolder viewHolder;
        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);

        //If there are no existing rows to reuse, inflate the view
        if (rowConvertView == null) {
            viewHolder = new ViewHolder();
            rowConvertView = inflater.inflate(R.layout.listview_row_request, parent, false);
            viewHolder.itemDes = (TextView)rowConvertView.findViewById(R.id.itemDes);
            viewHolder.requestDate = (TextView)rowConvertView.findViewById(R.id.requestId);
            viewHolder.quantity = (TextView)rowConvertView.findViewById(R.id.quantity);
            viewHolder.requestStatusDescription = (TextView)rowConvertView.findViewById(R.id.requestStatus);

            //Tags are used to store data related to views in the views themselves rather than by putting them in a separate structure.
            //store the ViewHolder object inside the fresh view
            rowConvertView.setTag(viewHolder);
        } else {
            //both ViewHolder and rowConvertView references the same tag object
            viewHolder = (ViewHolder) rowConvertView.getTag();
        }

        //populate the viewHolder object, which is referenced by rowConvertView
        viewHolder.itemDes.setText(container.ItemDes);
        viewHolder.quantity.setText(String.valueOf(container.Quantity));
        viewHolder.requestStatusDescription.setText(container.RequestStatusDescription);
        String date = "";
        if (container.RequestDate != null)
            date = container.RequestDate.split(" ")[0];
        viewHolder.requestDate.setText(date);

        return rowConvertView;
    }
}
