package com.bholdhealth.medicaid.activities;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.bholdhealth.medicaid.Models.AudioRecord;
import com.bholdhealth.medicaid.R;
import com.bumptech.glide.Glide;

import net.idrnd.voicesdk.antispoof2.AntispoofResult;
import net.idrnd.voicesdk.verify.VerifyResult;
import net.idrnd.voicesdk.verify.VoiceTemplate;

import io.flutter.app.FlutterActivity;

public class VoiceLogin extends FlutterActivity {

    com.bholdhealth.medicaid.database.UsersDao usersDao;
    LinearLayout loaderView;
    ImageView logo;
    TextView loginText;
    com.bholdhealth.medicaid.Utils.Folders folder;
    Button verify;
    String userName="CasandraPagac";
    String phrase="Golden State Warriors";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_voice_login);
        usersDao=new com.bholdhealth.medicaid.database.UsersDao(getApplicationContext());
        folder=new com.bholdhealth.medicaid.Utils.Folders(VoiceLogin.this);

        initViews();
        com.bholdhealth.medicaid.Utils.EngineManager.getInstance().init(this);
        com.bholdhealth.medicaid.Utils.Prefs.getInstance().init(getPreferences(MODE_PRIVATE));

        initVerification();
    }

    private void initViews() {
        loaderView=findViewById(R.id.loader);
        verify=findViewById(R.id.verifyBtn);
        loginText =findViewById(R.id.login_text);
        logo=findViewById(R.id.logo);
        Glide.with(this).load(R.drawable.bhold_logo_final__1_).into(logo);
    }

    private void initVerification() {
        verify.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                com.bholdhealth.medicaid.Models.Users user=usersDao.findByName(userName);
                com.bholdhealth.medicaid.dialogs.RecordDialog dialog= com.bholdhealth.medicaid.dialogs.RecordDialog.newInstance(phrase,userName);
                dialog.setOnStopListener(new com.bholdhealth.medicaid.Utils.OnStopRecording() {

                    @Override
                    public void onStop(final AudioRecord recordObject) {
                        loginText.setVisibility(View.GONE);
                        verify.setVisibility(View.GONE);
                        loaderView.setVisibility(View.VISIBLE);


                        AsyncTask.execute(new Runnable() {
                            @Override
                            public void run() {
                                com.bholdhealth.medicaid.Utils.EngineManager engineManager = com.bholdhealth.medicaid.Utils.EngineManager.getInstance();
                                final Bundle bundle = new Bundle();
                                com.bholdhealth.medicaid.Utils.Prefs prefs = com.bholdhealth.medicaid.Utils.Prefs.getInstance();

                                VoiceTemplate record = engineManager.verifyEngine.createVoiceTemplate(recordObject.data, recordObject.sampleRate);
                                VoiceTemplate template = VoiceTemplate.loadFromFile(folder.getTemplate(userName));
                                VerifyResult verificationResult = engineManager.verifyEngine.verify(record, template);
                                bundle.putFloat("VERIFICATION_SCORE", verificationResult.probability);

                                if (prefs.getAntispoofingEnabledFlag()) {
                                    AntispoofResult antispoofingResult = engineManager.antispoofEngine.isSpoof(recordObject.data, recordObject.sampleRate);
                                    bundle.putFloat("ANTISPOOFING_SCORE", antispoofingResult.score);
                                }

                                        com.bholdhealth.medicaid.dialogs.StatisticsDialog dialog = com.bholdhealth.medicaid.dialogs.StatisticsDialog.newInstance(bundle, loginText,verify,loaderView);
                                        dialog.show(getFragmentManager(), "STATISTICS");

                            }

                        });
                    }
                });

                dialog.show(getFragmentManager(), "DIALOG");
            }
        });
    }
}