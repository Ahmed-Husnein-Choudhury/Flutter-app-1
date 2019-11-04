package com.bholdhealth.medicaid.activities;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import com.bholdhealth.medicaid.MainActivity;
import com.bholdhealth.medicaid.Utils.FileUtils;

import net.idrnd.idsdk.IDEngine;
import net.idrnd.idsdk.conf.FaceEngineConf;
import net.idrnd.idsdk.conf.IDEngineConf;
import net.idrnd.idsdk.event.FaceEvent;
import net.idrnd.idsdk.event.MultiEvent;
import net.idrnd.idsdk.event.VerifySettings;
import net.idrnd.idsdk.result.EnrollResultContainer;
import net.idrnd.idsdk.result.VerifyResult;

import java.util.ArrayList;
import java.util.Arrays;

import es.dmoral.toasty.Toasty;
import io.flutter.app.FlutterActivity;

public class FaceSDKActivity extends FlutterActivity {

    String TAG = FaceSDKActivity.class.getSimpleName();
    String dataRootDir, filePath;
    byte[] saveFaceArray;
    ArrayList<Byte> bla;
    SharedPreferences storedFaceData;
    SharedPreferences.Editor editor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        filePath = getIntent().getStringExtra("file path");
        Log.d(TAG, "face activity called: " + filePath);

        // MainActivity.stopNative();

        dataRootDir = getExternalFilesDir("").getAbsolutePath();


        storedFaceData = getApplicationContext().getSharedPreferences("store face", MODE_PRIVATE);
        editor = storedFaceData.edit();

        // 2) Copy assets to the data dir

        FileUtils.copyAssetFolder(getAssets(), "data", dataRootDir);


        IDEngineConf conf = new IDEngineConf();

        FaceEngineConf faceConf = new FaceEngineConf();
        faceConf.dataPath = dataRootDir + "/face";
        conf.faceEngineConf = faceConf;

        Log.d(TAG, "face activity called (2): " + dataRootDir);

        IDEngine idEngine = new IDEngine(conf);
        System.out.println("ID SDK build info: " + idEngine.getBuildInfo());


        MultiEvent multiEvent = new MultiEvent();

        multiEvent.faceEvent = new FaceEvent();

//        try {
//            FileOutputStream out = new FileOutputStream(filePath);
//            .compress(Bitmap.CompressFormat.JPEG, 100, out); //100-best quality
//            out.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        multiEvent.faceEvent.image = FileUtils.loadFile(filePath);
        Log.d(TAG, "byte array: " + multiEvent);


        if (storedFaceData.getString("face data", null) != null) {
            Log.d(TAG,"size of byte array shared preference not null");
            saveFaceArray = Base64.decode(storedFaceData.getString("face data", null), Base64.NO_WRAP);
            Log.d(TAG,"size of byte array3: "+saveFaceArray.length);
        }

        EnrollResultContainer enrollResultContainer = idEngine.enroll(multiEvent, saveFaceArray);

        Log.d(TAG, "profile: " + saveFaceArray);

        byte[] profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);


        if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.OK) {

            Toasty.success(getApplicationContext(), "Enrollment Successful", Toast.LENGTH_LONG).show();

            saveFaceArray = enrollResultContainer.serializedProfile;
            saveFace(saveFaceArray);
            Log.d(TAG, "finished profile: " + saveFaceArray);

            finishPlatformChannelEnrolled(true);
        } else if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.EMPTY_PROFILE)
            Toast.makeText(getApplicationContext(), "empty profile", Toast.LENGTH_LONG).show();
        else if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.INTERNAL_ERROR)
            Toast.makeText(getApplicationContext(), "internal error", Toast.LENGTH_LONG).show();
        else if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.INVALID_INPUT)
            Toast.makeText(getApplicationContext(), "invalid input", Toast.LENGTH_LONG).show();
        else if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.UNDEFINED) {

            Toasty.error(getApplicationContext(), "Enrollment failed", Toast.LENGTH_LONG).show();
            finishPlatformChannelEnrolled(false);
        } else if (enrollResultContainer.enrollResult.getResultCode() == IDEngine.ResultCode.NOT_SCORED)
            Toast.makeText(getApplicationContext(), "not scored", Toast.LENGTH_LONG).show();


        else {
            Toasty.error(getApplicationContext(), "Enrollment Failed", Toast.LENGTH_LONG).show();
            finishPlatformChannelEnrolled(false);
        }

        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());

        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo2.jpg");

        enrollResultContainer = idEngine.enroll(multiEvent, profile);

        profile = Arrays.copyOf(enrollResultContainer.serializedProfile, enrollResultContainer.serializedProfile.length);

        System.out.println(enrollResultContainer.enrollResult.getProfileMaturity());


        float verificationThreshold = 0.9f;

        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/mel.jpg");

        VerifyResult verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);

        System.out.println("Face result: " + verifyResult.getFaceResult());
        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));


        multiEvent.faceEvent.image = FileUtils.loadFile(dataRootDir + "/test/leo3.jpg");

        verifyResult = idEngine.verify(multiEvent, new VerifySettings(), profile);

        System.out.println("Face result: " + verifyResult.getFaceResult());
        System.out.println("Verification result: " + (verifyResult.getScore() > verificationThreshold ? "SUCCESSFUL" : "FAILED"));
    }


    private void finishPlatformChannelEnrolled(boolean enrolled) {

        MainActivity.stopNativeEnrolled(enrolled);
        FaceSDKActivity.this.finish();

    }


    private void saveFace(byte[] profile) {

        String tempString = Base64.encodeToString(profile, Base64.NO_WRAP);
        byte[] tempArray, tempArray2;

        if (storedFaceData.getString("face data", null) != null) {
//            tempString = storedFaceData.getString("face data", null);
//            tempArray = Base64.decode(tempString, Base64.NO_WRAP);
//            Log.d(TAG, "size of byte array: " + tempArray.length);
//            tempArray2 = tempArray = profile;
       //     tempString = Base64.encodeToString(tempArray2, Base64.NO_WRAP);
            tempString = Base64.encodeToString(profile, Base64.NO_WRAP);

            editor.putString("face data", tempString);

            editor.commit();
            Log.d(TAG, "size of byte array2: " + profile.length);


        } else {
            Log.d(TAG, "face is being saved: "+profile.length);

            editor.putString("face data", tempString);
            editor.commit();
        }
    }

}
