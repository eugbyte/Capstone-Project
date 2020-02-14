package com.example.adprojectcx.representative.sharedClasses;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;

import java.util.List;

public class BaseClassListAdapter extends ArrayAdapter<Container> {
    protected Context mContext;
    protected int mChosenRowId = -1;
    protected List<Container> mContainers;

    public BaseClassListAdapter(Context context, int chosenRowId, List<Container> containers) {
        super(context, chosenRowId, containers);
        this.mContext = context;
        this.mChosenRowId = chosenRowId;
        this.mContainers = containers;
    }

    public void setContainers(List<Container> containers) {
        this.mContainers = containers;
    }

    @Override
    public int getCount() {
        return mContainers.size();
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    public Container getItem(int position) {
        return mContainers.get(position);
    }

    @Override
    public View getView(int position, View rowConvertView, ViewGroup parent) {
        return rowConvertView;
    }

}
