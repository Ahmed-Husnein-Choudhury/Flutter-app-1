package com.bholdhealth.medicaid.Utils;

import android.content.SharedPreferences;

public class Prefs {

    private static final String ASSETS_COPIED = "ASSETS_COPIED";
    private static final String VERIFY_THRESHOLD = "VERIFY_THRESHOLD";
    private static final String ANTISPOOFING_THRESHOLD = "ANTISPOOFING_THRESHOLD";
    private static final String ANTISPOOFING_ENABLED = "ANTISPOOFING_ENABLED";

    private SharedPreferences preferenceManager;

    private static Prefs instance;

    private Prefs() {}

    public static Prefs getInstance() {
        if (instance == null) {
            instance = new Prefs();
        }

        return instance;
    }

    public void init(SharedPreferences preferenceManager) {
        this.preferenceManager = preferenceManager;
    }

    public Prefs(SharedPreferences manager) {
        preferenceManager = manager;
    }

    public boolean getAssetsCopiedFlag() {
        return preferenceManager.getBoolean(ASSETS_COPIED, false);
    }

    public void setAssetsCopiedFlag(boolean copy) {
        preferenceManager.edit().putBoolean(ASSETS_COPIED, copy).apply();
    }

    public int getVerifyThreshold() {
        return preferenceManager.getInt(VERIFY_THRESHOLD, 75);
    }

    public void setVerifyThreshold(int threshold) {
        preferenceManager.edit().putInt(VERIFY_THRESHOLD, threshold).apply();
    }

    public int getAntispoofingThreshold() {
        return preferenceManager.getInt(ANTISPOOFING_THRESHOLD, 75);
    }

    public void setAntispoofingThreshold(int threshold) {
        preferenceManager.edit().putInt(ANTISPOOFING_THRESHOLD, threshold).apply();
    }

    public boolean getAntispoofingEnabledFlag() {
        return preferenceManager.getBoolean(ANTISPOOFING_ENABLED, true);
    }

    public void setAntispoofingEnabledFlag(boolean antispoofingCheck) {
        preferenceManager.edit().putBoolean(ANTISPOOFING_ENABLED, antispoofingCheck).apply();
    }
}
