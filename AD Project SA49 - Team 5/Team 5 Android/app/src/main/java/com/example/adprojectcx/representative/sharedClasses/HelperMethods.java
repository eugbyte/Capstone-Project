package com.example.adprojectcx.representative.sharedClasses;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import com.example.adprojectcx.Login.LoginActivity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;

import static android.content.Context.MODE_PRIVATE;

public class HelperMethods {

    //Use this static method  only if the JSON body is small, otherwise there will be data loss
    public static List<Container> convertJsonStringToContainers(HttpURLConnection conn) {

        List<Container> containers = new ArrayList<Container>();

        try {
            conn.connect();
            InputStream is = conn.getInputStream();

            //Write the stream
            byte[] b = new byte[1024];
            ByteArrayOutputStream byteResponse = new ByteArrayOutputStream();
            while(is.read(b) != -1) {
                byteResponse.write(b);
            }
            //Convert the bytes to string
            String JSONResponse =  new String(byteResponse.toByteArray());
            //Convert the string to json
            JSONArray jsonArr = new JSONArray(JSONResponse);

            //Convert the JsonArray to List<Container>
            for (int i = 0; i < jsonArr.length(); i++) {
                JSONObject jsonObject = jsonArr.getJSONObject(i);
                Container container = new Container(jsonObject);
                containers.add(container);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return containers;

    }

    public static int getEmployeeId (Context context) {
            SharedPreferences sharedPreferences = context.getSharedPreferences("user_credentials", Context.MODE_PRIVATE);
            int employeeId = sharedPreferences.getInt("employeeId", 0);
            Log.v("employeeId:", String.valueOf(employeeId));
            return employeeId;
    }

    public static void logout(Context context) {
        SharedPreferences pref = context.getSharedPreferences("user_credentials", MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.clear();
        editor.commit();
        Intent intent = new Intent(context, LoginActivity.class);
        intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }
}
