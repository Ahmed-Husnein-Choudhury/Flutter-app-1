package com.bholdhealth.medicaid.activities;

import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.bholdhealth.medicaid.MainActivity;
import com.bholdhealth.medicaid.Models.AudioRecord;
import com.bholdhealth.medicaid.R;
import com.bholdhealth.medicaid.Utils.Prefs;
import com.bumptech.glide.Glide;

import net.idrnd.voicesdk.antispoof2.AntispoofResult;
import net.idrnd.voicesdk.verify.VerifyResult;
import net.idrnd.voicesdk.verify.VoiceTemplate;

import io.flutter.app.FlutterActivity;

public class VoiceLoginActivity extends FlutterActivity {

    com.bholdhealth.medicaid.database.UsersDao usersDao;
    LinearLayout loaderView;
    ImageView logo;
    com.bholdhealth.medicaid.Utils.Folders folder;
    Prefs prefs;
    //String userName="jordiwaters";
    String userName;
    String phrase = "Golden State Warriors";

    // String TAG=getApplicationContext().getClass().getSimpleName();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_voice_login);
        if (getActionBar() != null) getActionBar().hide();
        usersDao = new com.bholdhealth.medicaid.database.UsersDao(getApplicationContext());

        userName = usersDao.all().get(0).getName();
        phrase = usersDao.all().get(0).getPhrase();
        folder = new com.bholdhealth.medicaid.Utils.Folders(VoiceLoginActivity.this);
        initViews();

        initEngine();

        initVerification();
    }

    private void initEngine() {
        com.bholdhealth.medicaid.Utils.EngineManager.getInstance().init(this);
        com.bholdhealth.medicaid.Utils.Prefs.getInstance().init(getPreferences(MODE_PRIVATE));
        prefs = com.bholdhealth.medicaid.Utils.Prefs.getInstance();
    }

    private void initViews() {
        loaderView = findViewById(R.id.loader);
        logo = findViewById(R.id.logo);
        Glide.with(this).load(R.drawable.logo).into(logo);
    }

    private void initVerification() {
//        verify.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {

        com.bholdhealth.medicaid.Models.Users user = usersDao.findByName(userName);
        com.bholdhealth.medicaid.dialogs.RecordDialog dialog = com.bholdhealth.medicaid.dialogs.RecordDialog.newInstance(phrase, userName);
        dialog.setOnStopListener(new com.bholdhealth.medicaid.Utils.OnStopRecording() {

            @Override
            public void onStop(final AudioRecord recordObject) {

                loaderView.setVisibility(View.VISIBLE);


                AsyncTask.execute(new Runnable() {
                    @Override
                    public void run() {
                        com.bholdhealth.medicaid.Utils.EngineManager engineManager = com.bholdhealth.medicaid.Utils.EngineManager.getInstance();
                        final Bundle bundle = new Bundle();
                        com.bholdhealth.medicaid.Utils.Prefs prefs = com.bholdhealth.medicaid.Utils.Prefs.getInstance();

                        VoiceTemplate record = engineManager.verifyEngine.createVoiceTemplate(recordObject.data, recordObject.sampleRate);
                        VoiceTemplate template = VoiceTemplate.loadFromFile(folder.getTemplate(userName));
                        //  Log.d(TAG,"name: "+userName);
                        VerifyResult verificationResult = engineManager.verifyEngine.verify(record, template);
                        bundle.putFloat("VERIFICATION_SCORE", verificationResult.probability);

                        if (prefs.getAntispoofingEnabledFlag()) {
                            AntispoofResult antispoofingResult = engineManager.antispoofEngine.isSpoof(recordObject.data, recordObject.sampleRate);
                            bundle.putFloat("ANTISPOOFING_SCORE", antispoofingResult.score);
                        }


                        if (verificationResult.probability > 0.8) {
                            MainActivity.stopNative();
                            VoiceLoginActivity.this.finish();
                        } else {
                            com.bholdhealth.medicaid.dialogs.StatisticsDialog dialog = com.bholdhealth.medicaid.dialogs.StatisticsDialog.newInstance(bundle, loaderView);
                            dialog.show(getFragmentManager(), "STATISTICS");

                        }
                    }

                });
            }
        });

        dialog.show(getFragmentManager(), "DIALOG");
    }
//        });


    @Override
    public void onBackPressed() {
        super.onBackPressed();
        VoiceLoginActivity.this.finish();
    }
}
