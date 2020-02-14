package com.example.adprojectcx.representative.collectionPoint;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.representative.sharedClasses.Container;
import com.example.adprojectcx.representative.sharedClasses.HelperMethods;
import com.example.adprojectcx.representative.sharedClasses.OptionMenuActivity;
import com.example.adprojectcx.representative.sharedClasses.UploadTask;
import com.example.adprojectcx.R;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ChangeCollectionPointActivity extends OptionMenuActivity implements AdapterView.OnItemSelectedListener, DownloadCollectionPointTask.ICallback, UploadTask.ICallback  {

    private ArrayAdapter<String> adapter;
    private List<Container> selectListContainerLocations = new ArrayList<Container>();

    TextView currentLocationTextView;
    private String currentLocation = "";

    private Container containerToSubmit;    //containerToSubmit to be PUT and saved

    //assume for now, as authentication is not yet implemented
    int employeeId = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_change_collection_point);

        employeeId = HelperMethods.getEmployeeId(getApplicationContext());

        containerToSubmit = new Container();
        containerToSubmit.EmployeeId = employeeId;

        currentLocationTextView = (TextView)findViewById(R.id.current_collection_point);

        Spinner dropdown = createSpinner();
        downloadLocations();

        Button button = findViewById(R.id.button_change_collection_point);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View btn) {
                submitChange();
            }
        });


    }

    public Spinner createSpinner() {
        Spinner spinner = findViewById(R.id.spinner_change_collection_point);

        adapter = new ArrayAdapter<String>(ChangeCollectionPointActivity.this, android.R.layout.simple_spinner_item, new ArrayList<String>());
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(this);
        return spinner;
    }

    public void downloadLocations() {
        String downloadUrl = UrlStorage.GET_COLLECTION_POINT + "/" + employeeId;
        DownloadCollectionPointTask task = new DownloadCollectionPointTask(ChangeCollectionPointActivity.this);
        task.execute(downloadUrl);
    }

    public void updateTargetContainer(int pos) {
        containerToSubmit.CollectionPointId = selectListContainerLocations.get(pos).CollectionPointId;
        containerToSubmit.Location = selectListContainerLocations.get(pos).Location;
    }

    public void submitChange() {
        Gson gson = new Gson();
        String jsonString = gson.toJson(containerToSubmit);
        String queryString = "/" + employeeId;
        String url = UrlStorage.UPDATE_COLLECTION_POINT + queryString;
        String restMethod = "PATCH";

        UploadTask uploadTask = new UploadTask(ChangeCollectionPointActivity.this);
        uploadTask.execute(url, jsonString, restMethod);
    }

    //Enforced interface methods
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
        // An item was selected. You can retrieve the selected item using parent.getItemAtPosition(pos)
        Toast toast = Toast.makeText(parent.getContext(),parent.getItemAtPosition(pos).toString() + " " + pos, Toast.LENGTH_SHORT);
        toast.show();
        updateTargetContainer(pos);
    }
    @Override
    public void onNothingSelected(AdapterView<?> parent) {
        // Do nothing
    }

    @Override
    public void setCurrentLocation(String location) {
        this.currentLocation = location;
        currentLocationTextView.setText(location);
    }

    @Override
    public void updateSelectList(List<Container> containers) {
        selectListContainerLocations = containers;
        List<String> selectListLocations = containers.stream()
                .map(ce -> ce.Location)
                .collect(Collectors.toList());
        adapter.addAll(selectListLocations);
        adapter.notifyDataSetChanged();
    }
    @Override
    public void redirect(String s) {
        Toast toast = Toast.makeText(ChangeCollectionPointActivity.this, s, Toast.LENGTH_SHORT);
        toast.show();
        Intent intent = new Intent(ChangeCollectionPointActivity.this, ChangeCollectionPointActivity.class);
        startActivity(intent);
    }

}
