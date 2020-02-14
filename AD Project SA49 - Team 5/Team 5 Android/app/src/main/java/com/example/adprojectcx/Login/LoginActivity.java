package com.example.adprojectcx.Login;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.adprojectcx.UrlStorage;
import com.example.adprojectcx.representative.RepresentativeMainActivity;
import com.example.adprojectcx.R;
import com.example.adprojectcx.clerk.download.Command;
import com.example.adprojectcx.clerk.download.DownloadAsyncTask;
import com.example.adprojectcx.clerk.ui.ClerkMainActivity;

import org.json.JSONException;
import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity implements DownloadAsyncTask.ICallback {
    DownloadAsyncTask downloadAsyncTaskObject;
    EditText Username;
    EditText Password;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        Username = findViewById(R.id.username);
        Password = findViewById(R.id.password);
        SharedPreferences pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
        if (pref.contains("username") && pref.contains("password")){

            Log.i("Login", "Try to sign in with Shared Pref's credential");
            verify(pref.getString("username",""),pref.getString("password",""));
        }


        Button submitBtn = findViewById(R.id.login);
        if (submitBtn != null)
            submitBtn.setOnClickListener(new View.OnClickListener(){
                public void onClick(View v){
                    Log.i("Login", "sign in btn click");
                    if(Username.getText().toString().length() == 0){
                        Username.setError("Username cannot be empty");
                        return;
                    }
                    if(Password.getText().toString().length() == 0){
                        Password.setError("Password cannot be empty");
                        return;
                    }
                    String username = Username.getText().toString();
                    String password = Password.getText().toString();
                    //To clear entries
                    Username.setText("");
                    Password.setText("");
                    verify(username,password);
                }
            });

    }

    @Override
    public void onServerResponse(String stringJson, String next_activity) {

        try {
            JSONObject authResponse = new JSONObject(stringJson);
           if( authResponse.getString("authenticationStatus").equals("Authenticated")){
                SharedPreferences pref = getSharedPreferences("user_credentials", MODE_PRIVATE);
                SharedPreferences.Editor editor = pref.edit();
                editor.putString("username", authResponse.getString("username"));
                editor.putString("password", authResponse.getString("password"));
                editor.putInt("employeeId", Integer.parseInt(authResponse.getString("empId")));
                String role = authResponse.getString("role");
                editor.putString("role", role);
                editor.commit();
                Toast.makeText(getApplicationContext(),"Login as "
                              + role,Toast.LENGTH_SHORT).show();
               startProtectedAcvitity(role);
            }else {
               Toast.makeText(getApplicationContext(),"Login failed ",Toast.LENGTH_SHORT).show();
           }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public void verify(String username, String password){

        String loginUrl = UrlStorage.BASE_URL + "api/authentication?username=%s&password=%s";
        loginUrl = String.format(loginUrl, username,password);
        Command com = new Command(this,"get",loginUrl,null,"Disbursement","Get");
        downloadAsyncTaskObject = new DownloadAsyncTask(this);
        downloadAsyncTaskObject.execute(com);
    }

    public void startProtectedAcvitity(String role){
        // Select the next activity to go to based on role
        if (role.equals("STORE_CLERK")){
            Intent intent = new Intent(LoginActivity.this, ClerkMainActivity.class);
            startActivity(intent);
        }
        if (role.equals("DEPARTMENT_REP")){
            Intent intent = new Intent(LoginActivity.this, RepresentativeMainActivity.class);
            startActivity(intent);
        }
    };
}
