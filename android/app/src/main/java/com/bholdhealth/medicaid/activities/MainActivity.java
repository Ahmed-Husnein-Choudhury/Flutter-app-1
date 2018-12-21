package com.bholdhealth.medicaid.activities;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.util.Log;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  static Context context;
  String name,pictureFilePath;
  public static String CHANNEL = "biometric authentication";
  public static String FACE_CHANNEL = "register face";
  static MethodChannel.Result methodResult;
  static String TAG=MainActivity.class.getSimpleName();

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
   // Toasty.Config.getInstance().setSuccessColor(getColor(R.color.themeBlue));
  }

  private void initPlatformChannel() {

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

        methodResult = result;
        if (methodCall.method.equals("register voice")) {
          Toast.makeText(getApplicationContext(), "platform channel working", Toast.LENGTH_SHORT).show();
          Log.d("audio record", "bla");
          name=methodCall.argument("name");
          recordAudioInNative(result);

          Log.d("audio record", "bla");
          // result.success("ok");
        }

        else if(methodCall.method.equals("login using voice")){
          Log.d(TAG,"Voice login platform channel working");
          startVoiceLogin();
        }

        else if(methodCall.method.equals("register face")){
          pictureFilePath=methodCall.argument("file path");
          Toast.makeText(getApplicationContext(),"platform channel successful: "+pictureFilePath,Toast.LENGTH_SHORT).show();
          Intent in=new Intent(MainActivity.this,FaceSDKActivity.class);
          in.putExtra("file path",pictureFilePath);
          startActivity(in);
        }

      }

    });


  }

  private void startVoiceLogin() {
    Intent in=new Intent(MainActivity.this,VoiceLogin.class);
    startActivity(in);
  }

  private void recordAudioInNative(MethodChannel.Result result) {
      name="CasandraPagac";
    Intent in = new Intent(MainActivity.this, VoiceSDKActivity.class);
    in.putExtra("name",name);

    startActivity(in);

  }

  public static void stopNative() {
    //  Toast.makeText(context,"stopNative called",Toast.LENGTH_SHORT).show();
    methodResult.success(true);
  }
}
