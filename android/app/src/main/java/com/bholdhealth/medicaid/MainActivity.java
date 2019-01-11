package com.bholdhealth.medicaid;

import android.content.Context;
import android.content.Intent;
import android.media.Image;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.util.Log;
import android.widget.Toast;

import com.bholdhealth.medicaid.activities.FaceLoginActivity;
import com.bholdhealth.medicaid.activities.FaceSDKActivity;
import com.bholdhealth.medicaid.activities.VoiceLoginActivity;
import com.bholdhealth.medicaid.activities.VoiceSDKActivity;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    static Context context;
    Image image;
    String name, pictureFilePath, phoneNumber;
    public static String CHANNEL = "biometric authentication";
    static MethodChannel.Result methodResult;
    static String TAG = MainActivity.class.getSimpleName();

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        Log.d("TAG", "native part working");
        context = getApplicationContext();
        initCustomToast();
        initPlatformChannel();
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void initCustomToast() {
    }

    private void initPlatformChannel() {

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                methodResult = result;
                if (methodCall.method.equals("register voice")) {
                    Log.d("audio record", "bla");
                    name = methodCall.argument("name");
                    phoneNumber = methodCall.argument("phone number");
                    recordAudioInNative(result);

                    Log.d("audio record", "bla");
                    // result.success("ok");
                } else if (methodCall.method.equals("login using voice")) {
                    Log.d(TAG, "Voice login platform channel working");
                    startVoiceLogin();
                }


                // The part below is used for Facial registration


                else if (methodCall.method.equals("register face")) {
                    pictureFilePath = methodCall.argument("file path");
                    Intent in = new Intent(MainActivity.this, FaceSDKActivity.class);
                    in.putExtra("file path", pictureFilePath);
                    startActivity(in);

                } else if (methodCall.method.equals("verify face")) {

                    Intent in = new Intent(MainActivity.this, FaceLoginActivity.class);
                    in.putExtra("file path", pictureFilePath);
                    startActivity(in);
                }

            }

        });


    }

    private void startVoiceLogin() {
        Intent in = new Intent(MainActivity.this, VoiceLoginActivity.class);
        startActivity(in);
    }

    private void recordAudioInNative(MethodChannel.Result result) {
        Intent in = new Intent(MainActivity.this, VoiceSDKActivity.class);
        in.putExtra("name", name);
        in.putExtra("phone number", phoneNumber);

        startActivity(in);

    }

    public static void stopNative() {
        methodResult.success(true);
    }

    public static void stopNativeFacialRecognition(boolean enrolled) {
        methodResult.success(enrolled);
    }
}
