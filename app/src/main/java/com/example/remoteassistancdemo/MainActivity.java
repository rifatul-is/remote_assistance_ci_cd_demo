package com.example.remoteassistancdemo;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    //Integrated Git
    Button btnAuto;
    Button btnManual;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnAuto = findViewById(R.id.btnAuto);
        btnManual = findViewById(R.id.btnManual);

        if (!isAccessibilitySettingsOn(getApplicationContext())) {
            showAccessibilityPermissionDialog();
        }
        else {
            Log.d("TAG", "onCreate: Problem");
        }
        btnAuto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d("AUTO", "onClick: Clicked Button");
            }
        });
    }

    private boolean isAccessibilitySettingsOn(Context context) {
        int accessibilityEnabled = 0;
        final String service = context.getPackageName() + "/" + GlobalActionBarService.class.getCanonicalName();
        try {
            accessibilityEnabled = Settings.Secure.getInt(context.getContentResolver(), Settings.Secure.ACCESSIBILITY_ENABLED);
        } catch (Settings.SettingNotFoundException e) {
            // Log the error
        }

        TextUtils.SimpleStringSplitter colonSplitter = new TextUtils.SimpleStringSplitter(':');
        if (accessibilityEnabled == 1) {
            String settingsValue = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES);
            if (settingsValue != null) {
                colonSplitter.setString(settingsValue);
                while (colonSplitter.hasNext()) {
                    String accessibilityService = colonSplitter.next();
                    if (accessibilityService.equalsIgnoreCase(service)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private void showAccessibilityPermissionDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Accessibility Permission Required")
                .setMessage("For the app to function properly, it needs accessibility permissions. Please enable it in the settings.")
                .setPositiveButton("Go to Settings", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
                        startActivity(intent);
                    }
                })
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // Optionally handle the cancel button action here
                    }
                })
                .show();
    }
}
