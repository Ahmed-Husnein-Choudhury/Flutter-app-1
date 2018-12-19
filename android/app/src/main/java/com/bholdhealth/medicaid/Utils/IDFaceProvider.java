package com.bholdhealth.medicaid.Utils;

import android.content.Context;
import android.content.SharedPreferences;


import net.idrnd.idsdk.IDEngine;
import net.idrnd.idsdk.conf.FaceEngineConf;
import net.idrnd.idsdk.conf.IDEngineConf;

public class IDFaceProvider {
    private static IDFaceProvider instance;
    public IDEngine idEngine;
    private static String INIT_DATA_PATH_KEY = "INIT_DATA_PATH";

    private IDFaceProvider() {}

    public static IDFaceProvider getInstance() {
        if (instance == null) {
            instance = new IDFaceProvider();
        }

        return instance;
    }

    public void init(Context context) {
        // 1) Check if init data was already extracted from APKs assets to the external dir
        SharedPreferences sharedPreferences = context.getSharedPreferences("prefs", Context.MODE_PRIVATE);
        String initDataPath = sharedPreferences.getString(INIT_DATA_PATH_KEY, null);

        if (initDataPath == null) {
            // 2) If it was not, extract it and save the path
            AssetsExtractor assetsExtractor = new AssetsExtractor(context);
            initDataPath = assetsExtractor.extract(AssetsExtractor.IDSDK_INIT_DATA_PATH);
            sharedPreferences.edit().putString(INIT_DATA_PATH_KEY, initDataPath).apply();
        }

        // 3) Init IDEngine
        IDEngineConf conf = new IDEngineConf();

        FaceEngineConf faceConf = new FaceEngineConf();
        faceConf.dataPath = initDataPath;
        conf.faceEngineConf = faceConf;

        idEngine = new IDEngine(conf);
        System.out.println("ID SDK build info: " + idEngine.getBuildInfo());
    }
}

