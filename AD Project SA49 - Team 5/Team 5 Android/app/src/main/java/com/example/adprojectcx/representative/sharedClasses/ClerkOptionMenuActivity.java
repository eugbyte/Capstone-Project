package com.example.adprojectcx.representative.sharedClasses;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.Toast;

import com.example.adprojectcx.clerk.Disbursement.DisbursementActivity;
import com.example.adprojectcx.clerk.Inventory.StockTaking;
import com.example.adprojectcx.Login.LoginActivity;
import com.example.adprojectcx.R;
import com.example.adprojectcx.clerk.Retrieval.RetrievalActivity;

public class ClerkOptionMenuActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.project_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch (id){
            case R.id.Inventory:
                Toast.makeText(getApplicationContext(),"Inventory selected",Toast.LENGTH_LONG).show();
                Intent intent = new Intent(ClerkOptionMenuActivity.this, StockTaking.class);
                startActivity(intent);
                return true;
            case R.id.Disbursement:
                Toast.makeText(getApplicationContext(),"Disbursement Selected",Toast.LENGTH_LONG).show();
                intent = new Intent(ClerkOptionMenuActivity.this, DisbursementActivity.class);
                startActivity(intent);

                return true;
            case R.id.Retrieval:
                Toast.makeText(getApplicationContext(),"Retrieval Selected",Toast.LENGTH_LONG).show();
                intent = new Intent(ClerkOptionMenuActivity.this, RetrievalActivity.class);
                startActivity(intent);
                return true;
            case R.id.Logut:
                Toast.makeText(getApplicationContext(),"LogOut Selected",Toast.LENGTH_LONG).show();
                SharedPreferences pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
                SharedPreferences.Editor editor = pref.edit();
                editor.clear();
                editor.commit();
                intent = new Intent(ClerkOptionMenuActivity.this, LoginActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
