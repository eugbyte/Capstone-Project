package com.example.adprojectcx.representative;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.example.adprojectcx.R;
import com.example.adprojectcx.representative.collectItems.CollectItemsActivity;
import com.example.adprojectcx.representative.collectionPoint.ChangeCollectionPointActivity;
import com.example.adprojectcx.representative.request.RequestActivity;
import com.example.adprojectcx.representative.sharedClasses.HelperMethods;

public class RepresentativeMainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_representative);
        Button requestButton = findViewById(R.id.request_activity_button);
        requestButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(RepresentativeMainActivity.this, RequestActivity.class);
                startActivity(intent);
            }
        });

        Button collectItemsButton = findViewById(R.id.collect_activity_button);
        collectItemsButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(RepresentativeMainActivity.this, CollectItemsActivity.class);
                startActivity(intent);
            }
        });

        Button collectionPointButton = findViewById(R.id.collectionPoint_activity_button);
        collectionPointButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(RepresentativeMainActivity.this, ChangeCollectionPointActivity.class);
                startActivity(intent);
            }
        });

        Button logoutButton = findViewById(R.id.logout_activity_button);
        logoutButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick (View btn) {
                HelperMethods.logout(getApplicationContext());
            }
        });

    }



}
