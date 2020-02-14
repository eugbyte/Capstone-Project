package com.example.adprojectcx.representative.sharedClasses;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import androidx.appcompat.app.AppCompatActivity;

import com.example.adprojectcx.representative.RepresentativeMainActivity;
import com.example.adprojectcx.representative.collectItems.CollectItemsActivity;
import com.example.adprojectcx.representative.collectionPoint.ChangeCollectionPointActivity;
import com.example.adprojectcx.representative.request.RequestActivity;
import com.example.adprojectcx.R;

public class OptionMenuActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        Intent intent = null;
        switch(item.getItemId()) {
            case R.id.options_home: {
                intent = new Intent (OptionMenuActivity.this, RepresentativeMainActivity.class);
                break;
            }
            case R.id.options_menu_request: {
                intent = new Intent(OptionMenuActivity.this, RequestActivity.class);
                break;
            }
            case R.id.options_menu_collect_items: {
                intent = new Intent(OptionMenuActivity.this, CollectItemsActivity.class);
                break;
            }
            case R.id.options_menu_change_collection_point: {
                intent = new Intent(OptionMenuActivity.this, ChangeCollectionPointActivity.class);
                break;
            }
            case R.id.options_menu_logout: {
                HelperMethods.logout(getApplicationContext());
                break;
            }
        }
        if (intent != null)
            startActivity(intent);
        return super.onOptionsItemSelected(item);
    }
}
