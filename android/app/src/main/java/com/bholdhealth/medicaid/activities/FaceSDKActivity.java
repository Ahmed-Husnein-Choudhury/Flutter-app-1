package com.bholdhealth.medicaid.activities;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import com.bholdhealth.medicaid.MainActivity;
import com.bholdhealth.medicaid.Utils.AssetsExtractor;
import com.bholdhealth.medicaid.Utils.FileUtils;
import com.google.gson.Gson;

import net.idrnd.idsdk.IDEngine;
import net.idrnd.idsdk.conf.FaceEngineConf;
import net.idrnd.idsdk.conf.IDEngineConf;
import net.idrnd.idsdk.event.FaceEvent;
import net.idrnd.idsdk.event.MultiEvent;
import net.idrnd.idsdk.result.EnrollResultContainer;


import java.util.ArrayList;

import es.dmoral.toasty.Toasty;
import io.flutter.app.FlutterActivity;

public class FaceSDKActivity extends FlutterActivity {


    String TAG = FaceSDKActivity.class.getSimpleName();
    String dataRootDir, filePath;
    byte[] savedFaceArray;
    ArrayList<Byte> bla;
    SharedPreferences storedFaceData;
    SharedPreferences.Editor editor;
    byte[] profile;
    Gson gson;
    String json;
    IDEngine idEngine;
    EnrollResultContainer enrollResultContainer;
    MultiEvent multiEvent;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        filePath = getIntent().getStringExtra("file path");
        Log.d(TAG, "face activity called: " + filePath);

        // MainActivity.stopNative();
        // gson = new Gson();
        //  dataRootDir = getExternalFilesDir("").getAbsolutePath();


        storedFaceData = getApplicationContext().getSharedPreferences("store face", MODE_PRIVATE);
        editor = storedFaceData.edit();

        editor.apply();

        // 2) Copy assets to the data dir

        //FileUtils.copyAssetFolder(getAssets(), "data", dataRootDir);
        AssetsExtractor assetsExtractor = new AssetsExtractor(getApplicationContext());
        dataRootDir = assetsExtractor.extract(AssetsExtractor.IDSDK_INIT_DATA_PATH);

        Log.d(TAG, "face SDK data directory: " + dataRootDir);

//        if (storedFaceData.getString("id engine instance", null) != null) {
//            json = storedFaceData.getString("id engine instance", null);
//            idEngine = gson.fromJson(json, IDEngine.class);
//            Log.d(TAG,"stored idEngine instance is found");
//
//        } else {
        IDEngineConf conf = new IDEngineConf();

        FaceEngineConf faceConf = new FaceEngineConf();
        faceConf.dataPath = dataRootDir;
        conf.faceEngineConf = faceConf;
        multiEvent = new MultiEvent();
        idEngine = new IDEngine(conf);
        System.out.println("ID SDK build info: " + idEngine.getBuildInfo());

//            json = gson.toJson(idEngine);
//            editor.putString("id engine instance", json);
//            editor.apply();
//            Log.d(TAG,"idEngine instance is stored");
//        }


//        multiEvent.faceEvent.image = FileUtils.loadImageAndRotate(filePath,-90);

        enrollFace(multiEvent);

        checkResult();



//        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());
//
//        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo2.jpg",-90);
//
//        enrollResultContainer = idEngine.enroll(multiEvent, profile);
//
//        profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);
//
//        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());
//
//
//        float verificationThreshold = 0.9f;
//
//        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/mel.jpg");
//
//        VerifyResult verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);
//
//        System.out.println("Face result: " + verifyResult.getFaceResult());
//        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));
//
//
//        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo3.jpg");
//
//        verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);
//
//        System.out.println("Face result: " + verifyResult.getFaceResult());
//        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));
    }

    private void checkResult() {

        if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.OK) {

            //   profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);

//            if (storedFaceData.getString("face data", null) != null) {
//                Log.d(TAG,"size of byte array shared preference not null");
//                savedFaceArray = Base64.decode(storedFaceData.getString("face data", null), Base64.NO_WRAP);
//                Log.d(TAG,"size of byte array3: "+savedFaceArray.length);
//            }

            savedFaceArray = enrollResultContainer.serializedProfile;
            saveFace(savedFaceArray);
            Log.d(TAG, "finished profile: " + savedFaceArray);

            Toasty.success(getApplicationContext(), "Enrollment Successful", Toast.LENGTH_LONG).show();

            finishPlatformChannelEnrolled(true);


        } else {

            //reEnrollFace();

            Toasty.error(getApplicationContext(), "Enrollment Failed", Toast.LENGTH_LONG).show();
            finishPlatformChannelEnrolled(false);
        }
    }

    private void reEnrollFace() {

        multiEvent.faceEvent.image=FileUtils.loadFile(filePath);

        Log.d(TAG, "byte array: " + multiEvent);

        if (storedFaceData.getString("face data", null) != null) {
            Log.d(TAG, "size of byte array shared preference not null");
            savedFaceArray = Base64.decode(storedFaceData.getString("face data", null), Base64.NO_WRAP);
            Log.d(TAG, "size of byte array3: " + savedFaceArray.length);
        }

        Log.d(TAG, "logging before checking");
        Log.d(TAG, "logging before checking" + multiEvent.toString());

        enrollResultContainer = idEngine.enroll(multiEvent, savedFaceArray);

        Log.d(TAG, "profile: " + savedFaceArray);


        if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.OK) {

            savedFaceArray = enrollResultContainer.serializedProfile;
            saveFace(savedFaceArray);
            Log.d(TAG, "finished profile: " + savedFaceArray);

            Toasty.success(getApplicationContext(), "Enrollment Successful", Toast.LENGTH_LONG).show();

            finishPlatformChannelEnrolled(true);
        }

        else{
            Toasty.error(getApplicationContext(), "Enrollment Failed", Toast.LENGTH_LONG).show();
            finishPlatformChannelEnrolled(false);
        }


    }

    private void enrollFace(MultiEvent multiEvent) {

        multiEvent.faceEvent = new FaceEvent();

        multiEvent.faceEvent.image = FileUtils.loadImageAndRotate(filePath,-90);
        Log.d(TAG, "byte array: " + multiEvent);

        if (storedFaceData.getString("face data", null) != null) {
            Log.d(TAG, "size of byte array shared preference not null");
            savedFaceArray = Base64.decode(storedFaceData.getString("face data", null), Base64.NO_WRAP);
            Log.d(TAG, "size of byte array3: " + savedFaceArray.length);
        }

        Log.d(TAG, "logging before checking");
        Log.d(TAG, "logging before checking" + multiEvent.toString());

        enrollResultContainer = idEngine.enroll(multiEvent, savedFaceArray);

        Log.d(TAG, "profile: " + savedFaceArray);
    }

    private void finishPlatformChannelEnrolled(boolean enrolled) {

        MainActivity.stopNativeFacialRecognition(enrolled);
        FaceSDKActivity.this.finish();

    }


    private void saveFace(byte[] profile) {

        String tempString = Base64.encodeToString(profile, Base64.NO_WRAP);
        byte[] tempArray, tempArray2;

        if (storedFaceData.getString("face data", null) != null) {

            tempString = Base64.encodeToString(profile, Base64.NO_WRAP);

            editor.putString("face data", tempString);

            editor.commit();
            Log.d(TAG, "size of byte array2: " + profile.length);


        } else {
            Log.d(TAG, "face is being saved: " + profile.length);

            editor.putString("face data", tempString);
            editor.commit();
        }
    }

}
