package com.example.adprojectcx.clerk.ui;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.adprojectcx.clerk.Disbursement.DisbursementActivity;
import com.example.adprojectcx.clerk.Inventory.StockTaking;
import com.example.adprojectcx.Login.LoginActivity;
import com.example.adprojectcx.R;
import com.example.adprojectcx.clerk.Retrieval.RetrievalActivity;
import com.example.adprojectcx.clerk.download.Command;
import com.example.adprojectcx.clerk.download.DownloadAsyncTask;

public class ClerkMainActivity extends AppCompatActivity{

    DownloadAsyncTask downloadAsyncTaskObject;
    Command com;
    SharedPreferences pref;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_clerk_main);
        pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
        TextView Welcome = findViewById(R.id.clerk_welcome);
        Welcome.setText("Welcome "+ pref.getString("username","Clerk"));

        Button InventoryButton = findViewById(R.id.inventory_activity_button);
        InventoryButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(ClerkMainActivity.this, StockTaking.class);
                startActivity(intent);
            }
        });

        Button DisbursementButton = findViewById(R.id.disbursement_activity_button);
        DisbursementButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(ClerkMainActivity.this, DisbursementActivity.class);
                startActivity(intent);
            }
        });

        Button RetrievalButton = findViewById(R.id.retrieval_activity_button);
        RetrievalButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                Intent intent = new Intent(ClerkMainActivity.this, RetrievalActivity.class);
                startActivity(intent);
            }
        });

        Button LogOutButton = findViewById(R.id.logout_button);
        LogOutButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View btn) {
                SharedPreferences pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
                SharedPreferences.Editor editor = pref.edit();
                editor.clear();
                editor.commit();
                Intent intent = new Intent(ClerkMainActivity.this, LoginActivity.class);
                startActivity(intent);
            }
        });
    }

}
