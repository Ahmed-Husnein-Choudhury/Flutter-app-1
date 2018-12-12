package com.bholdhealth.medicaid.Utils;

import android.content.Context;
import android.util.Log;

import net.idrnd.voicesdk.antispoof2.AntispoofEngine;
import net.idrnd.voicesdk.verify.VoiceVerifyEngine;

import static android.content.ContentValues.TAG;

public class EngineManager {
    public VoiceVerifyEngine verifyEngine;
    public AntispoofEngine antispoofEngine;

    private static EngineManager instance;

    private EngineManager() {}

    public static EngineManager getInstance() {
        if (instance == null) {
            instance = new EngineManager();
        }

        return instance;
    }

    public void init(Context context) {
        if (context!=null) {
            String externalDir = context.getExternalFilesDir(null).getAbsolutePath();
            String verifyInitDataPath = externalDir
                    + "/extra/verify_init_data/";
            Log.d(TAG,"folder path: "+verifyInitDataPath);
            verifyEngine = new VoiceVerifyEngine(
                    verifyInitDataPath,
                    VoiceVerifyEngine.M_STATIC | VoiceVerifyEngine.M_CREATE_TEMPLATE | VoiceVerifyEngine.M_MATCH_TEMPLATE,
                    VoiceVerifyEngine.M_MAP | VoiceVerifyEngine.M_TI_X);
            String spoofInitDataPath = externalDir + "/extra/spoof_init_data/";
            antispoofEngine = new AntispoofEngine(spoofInitDataPath);
        }
    }
}
