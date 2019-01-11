package com.bholdhealth.medicaid.activities;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;

import com.bholdhealth.medicaid.MainActivity;
import com.bholdhealth.medicaid.Utils.AssetsExtractor;
import com.bholdhealth.medicaid.Utils.FileUtils;

import net.idrnd.idsdk.IDEngine;
import net.idrnd.idsdk.conf.FaceEngineConf;
import net.idrnd.idsdk.conf.IDEngineConf;
import net.idrnd.idsdk.event.FaceEvent;
import net.idrnd.idsdk.event.MultiEvent;
import net.idrnd.idsdk.event.VerifySettings;
import net.idrnd.idsdk.result.EnrollResultContainer;
import net.idrnd.idsdk.result.VerifyResult;

import es.dmoral.toasty.Toasty;
import io.flutter.app.FlutterActivity;

public class FaceLoginActivity extends FlutterActivity {


    String TAG = FaceSDKActivity.class.getSimpleName();
    String dataRootDir, filePath;
    byte[] savedFaceArray;
    SharedPreferences storedFaceData;
    byte[] profile;;
    IDEngine idEngine;
    EnrollResultContainer enrollResultContainer;
    MultiEvent multiEvent;
    VerifyResult verifyResult;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        filePath = getIntent().getStringExtra("file path");
        Log.d(TAG, "face activity called: " + filePath);

        storedFaceData = getApplicationContext().getSharedPreferences("store face", MODE_PRIVATE);

        AssetsExtractor assetsExtractor = new AssetsExtractor(getApplicationContext());
        dataRootDir = assetsExtractor.extract(AssetsExtractor.IDSDK_INIT_DATA_PATH);

        Log.d(TAG, "face SDK data directory: " + dataRootDir);

        IDEngineConf conf = new IDEngineConf();

        FaceEngineConf faceConf = new FaceEngineConf();
        faceConf.dataPath = dataRootDir;
        conf.faceEngineConf = faceConf;
        multiEvent = new MultiEvent();
        idEngine = new IDEngine(conf);
        System.out.println("ID SDK build info: " + idEngine.getBuildInfo());

        verifyFace(multiEvent);
    }

    private void verifyFace(MultiEvent multiEvent) {

        multiEvent.faceEvent = new FaceEvent();

        multiEvent.faceEvent.image = FileUtils.loadImageAndRotate(filePath,-90);
        Log.d(TAG, "byte array: " + multiEvent);

        if (storedFaceData.getString("face data", null) != null) {
            Log.d(TAG, "size of byte array shared preference not null");
            savedFaceArray = Base64.decode(storedFaceData.getString("face data", null), Base64.NO_WRAP);
            Log.d(TAG, "size of byte array3: " + savedFaceArray.length);


            verifyResult = idEngine.verify(multiEvent,new VerifySettings(), savedFaceArray);

            if (verifyResult.getResultCode() == IDEngine.ResultCode.OK) {
                Toasty.success(getApplicationContext(),"Verification score: " + Double.toString(verifyResult.getScore())).show();
                finishPlatformChannelVerified(true);
            } else {
                Toasty.error(getApplicationContext(),"Face not found! Try again please").show();
                finishPlatformChannelVerified(false);
            }
        }

        }

    private void finishPlatformChannelVerified(boolean verified) {

        MainActivity.stopNativeFacialRecognition(verified);
        FaceLoginActivity.this.finish();

    }

    }


