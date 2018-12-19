package com.bholdhealth.medicaid.activities;

import android.os.Bundle;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;

import com.bholdhealth.medicaid.Utils.FileUtils;

import net.idrnd.idsdk.IDEngine;
import net.idrnd.idsdk.conf.FaceEngineConf;
import net.idrnd.idsdk.conf.IDEngineConf;
import net.idrnd.idsdk.event.FaceEvent;
import net.idrnd.idsdk.event.MultiEvent;
import net.idrnd.idsdk.event.VerifySettings;
import net.idrnd.idsdk.result.EnrollResultContainer;
import net.idrnd.idsdk.result.VerifyResult;

import java.io.File;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.Arrays;

import io.flutter.app.FlutterActivity;

public class FaceSDKActivity extends FlutterActivity {

    String TAG = FaceSDKActivity.class.getSimpleName();
    String dataRootDir, filePath;
    byte[] initial;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        filePath = getIntent().getStringExtra("file path");
        Log.d(TAG, "face activity called: " + filePath);

        // MainActivity.stopNative();

        dataRootDir = getExternalFilesDir("").getAbsolutePath();

        // 2) Copy assets to the data dir

        FileUtils.copyAssetFolder(getAssets(), "data", dataRootDir);

        // 3) Create IDEngine config

        IDEngineConf conf = new IDEngineConf();

        FaceEngineConf faceConf = new FaceEngineConf();
        faceConf.dataPath = dataRootDir + "/face";
        conf.faceEngineConf = faceConf;

        Log.d(TAG, "face activity called (2): " + dataRootDir);
        // 4) Create and init ID Engine

        IDEngine idEngine = new IDEngine(conf);
        System.out.println("ID SDK build info: " + idEngine.getBuildInfo());

        // 5) Create event

        MultiEvent multiEvent = new MultiEvent();

        multiEvent.faceEvent = new FaceEvent();

        //  multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo1.jpg");
        multiEvent.faceEvent.image = FileUtils.loadFile(filePath);
        Log.d(TAG,"byte array: "+multiEvent);

        // 6) Enroll with some images (however it can be only image)


        EnrollResultContainer enrollResultContainer = idEngine.enroll(multiEvent, initial);

        Log.d(TAG,"profile: "+initial);

        byte[] profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);


        if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.OK) {
//           showToast("Enrolled! Face images in profile: " +
//                    Integer.toString(enrollResultContainer.enrollResult.getProfileMaturity().facePictures));
            //serializedProfile = enrollResultContainer.serializedProfile;
            Toast.makeText(getApplicationContext(),"enrolled",Toast.LENGTH_LONG).show();
            initial=enrollResultContainer.serializedProfile;
            finishPlatformChannel();
        }

        else if(enrollResultContainer.enrollResult.getResultCode()==IDEngine.ResultCode.EMPTY_PROFILE) Toast.makeText(getApplicationContext(),"empty profile",Toast.LENGTH_LONG).show();
        else if(enrollResultContainer.enrollResult.getResultCode()==IDEngine.ResultCode.INTERNAL_ERROR) Toast.makeText(getApplicationContext(),"internal error",Toast.LENGTH_LONG).show();
        else if(enrollResultContainer.enrollResult.getResultCode()==IDEngine.ResultCode.INVALID_INPUT) Toast.makeText(getApplicationContext(),"invalid input",Toast.LENGTH_LONG).show();
        else if(enrollResultContainer.enrollResult.getResultCode()==IDEngine.ResultCode.UNDEFINED) {

            Toast.makeText(getApplicationContext(), "undefined", Toast.LENGTH_LONG).show();
            initial=enrollResultContainer.serializedProfile;
            finishPlatformChannel();
        }
        else if(enrollResultContainer.enrollResult.getResultCode()==IDEngine.ResultCode.NOT_SCORED) Toast.makeText(getApplicationContext(),"not scored",Toast.LENGTH_LONG).show();


        else {
            //showToast("Face not found! Try again please");
            Toast.makeText(getApplicationContext(),"not enrolled",Toast.LENGTH_LONG).show();
            finishPlatformChannel();
        }
        //finishPlatformChannel();

        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());

        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo2.jpg");

        enrollResultContainer = idEngine.enroll(multiEvent, profile);

        profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);

        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());

        // 7) Try to verify with imposter's photo

        // Set the verification threshold (it can be from 0 to 1)
        float verificationThreshold = 0.9f;

        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/mel.jpg");

        VerifyResult verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);

        System.out.println("Face result: " + verifyResult.getFaceResult());
        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));

        // 8) Verify with target's photo

        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo3.jpg");

        verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);

        System.out.println("Face result: " + verifyResult.getFaceResult());
        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));
    }

    private void finishPlatformChannel() {

        MainActivity.stopNative();
        FaceSDKActivity.this.finish();

    }


    public static void copyFile(File sourceFile, File destFile) throws IOException {
        if (!destFile.getParentFile().exists())
            destFile.getParentFile().mkdirs();

        if (!destFile.exists()) {
            destFile.createNewFile();
        }

        FileChannel source = null;
        FileChannel destination = null;
    }

}
