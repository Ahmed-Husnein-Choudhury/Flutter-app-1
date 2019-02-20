package com.bholdhealth.medicaid.activities;

import android.app.ActionBar;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bholdhealth.medicaid.MainActivity;
import com.bholdhealth.medicaid.R;
import com.bholdhealth.medicaid.Utils.AssetsUtils;
import com.bholdhealth.medicaid.Utils.EngineManager;
import com.bholdhealth.medicaid.Utils.Folders;
import com.bholdhealth.medicaid.Utils.Logger;
import com.bholdhealth.medicaid.Utils.OnStopRecording;
import com.bholdhealth.medicaid.Utils.Prefs;
import com.bholdhealth.medicaid.Utils.WavRecorder;
import com.bholdhealth.medicaid.Models.AudioRecord;
import com.bholdhealth.medicaid.Models.Users;


import com.bholdhealth.medicaid.database.UsersDao;
import com.bholdhealth.medicaid.dialogs.RecordDialog;
import com.bumptech.glide.Glide;

import com.skyfishjy.library.RippleBackground;

import net.idrnd.voicesdk.antispoof2.AntispoofResult;
import net.idrnd.voicesdk.media.SpeechProcessor;
import net.idrnd.voicesdk.verify.VerifyResult;
import net.idrnd.voicesdk.verify.VoiceTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.atomic.AtomicBoolean;

//timport es.dmoral.toasty.Toasty;
import androidx.cardview.widget.CardView;
import androidx.constraintlayout.widget.ConstraintLayout;
import es.dmoral.toasty.Toasty;
import io.flutter.app.FlutterActivity;
import me.srodrigo.androidhintspinner.HintAdapter;
import me.srodrigo.androidhintspinner.HintSpinner;
import pl.droidsonroids.gif.GifImageView;

import static android.content.ContentValues.TAG;
import static android.view.View.GONE;

public class VoiceSDKActivity extends FlutterActivity {

    AsyncTask task;

    RippleBackground rippleBackground;

    Button startRecordButton, continueButton,resetButton;

    Spinner voiceRegSpinner;
    ArrayList<String> voiceRegPhrases;

    CardView continueCardView;

    public static final int PERMISSION_REQUEST = 44;
    public static final String S_ALREADY_EXISTS_PLEASE_USE_ANOTHER_USERNAME = "%s already exists! Please use another Username.";

    SpeechProcessor speechProcessor;

    int counter = 0;
    float score = 0;

    com.bholdhealth.medicaid.Utils.Folders folder;

    ImageView logo;
    GifImageView gif;
    String name="CasandraPagac";
    String phoneNumber="123456789";
    TextView record, phrase, registrationCompleteTv1, registrationCompleteTv2, stepsTv;
    LinearLayout linearLayoutCounter,regCompleteLinearLayout;
    ConstraintLayout constraintLayoutRegistration;
    Spinner spinner;
    private String[] strings;
    private List<ImageView> images;
    private TextView error;
    private LinearLayout loaderView;
    private Timer timer;
    private VoiceTemplate[] voices = new VoiceTemplate[3];
    private UsersDao dao;
    String phraseString = "Golden State Warriors";
    // private OnStopRecording listener,listener2;
    private WavRecorder recorder;
    Context context;
    private AtomicBoolean isStop = new AtomicBoolean(false);


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_voice_sdk);
        getActionBar().hide();

        initData();

        saveVoice();

        resetVoice();

        initSpinner();

        initAssets();



    }

    private void resetVoice() {
        resetButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                counter=0;
                saveVoice();
                phrase.setVisibility(GONE);
                spinner.setVisibility(View.VISIBLE);
            }
        });
    }

    private void initSpinner() {
        voiceRegPhrases = new ArrayList<>();
        spinner = findViewById(R.id.spinner);

        voiceRegPhrases.addAll(Arrays.asList(getResources().getStringArray(R.array.phrases)));
        voiceRegPhrases.add(phoneNumber);

       final HintSpinner<String> hintSpinner = new HintSpinner<>(
                spinner,
                new HintAdapter<>(this, "Select Security Phrase", voiceRegPhrases),
                new HintSpinner.Callback<String>() {
                    @Override
                    public void onItemSelected(int position, String itemAtPosition) {
                        phraseString = itemAtPosition;
                phrase.setText(itemAtPosition);
                Log.d(TAG, "phrase string: " + phraseString);
                    }
                });



        hintSpinner.init();



    }

    private void initData() {

        name = getIntent().getStringExtra("name");

        phoneNumber = getIntent().getStringExtra("phone number");

        context = VoiceSDKActivity.this;
        dao = new UsersDao(context);
        phrase = findViewById(R.id.phrase);
        startRecordButton = findViewById(R.id.start_record_btn);
        continueButton = findViewById(R.id.continue_btn);
        resetButton=findViewById(R.id.reset_btn);
        error = findViewById(R.id.errorUsername);
        registrationCompleteTv1 = findViewById(R.id.registration_complete_tv1);
        registrationCompleteTv2 = findViewById(R.id.registration_complete_tv2);
        logo = findViewById(R.id.logo);
        constraintLayoutRegistration = findViewById(R.id.constraint_layout_voice_registration);
        gif = findViewById(R.id.gif_imageView);
        loaderView = findViewById(R.id.voice_registration_loader);
        continueCardView = findViewById(R.id.continue_card);
        Glide.with(this).load(R.drawable.logo).into(logo);
        folder = new com.bholdhealth.medicaid.Utils.Folders(VoiceSDKActivity.this);
        regCompleteLinearLayout=findViewById(R.id.reg_complete_linearLayout);

    }

    private void initAssets() {
        Prefs.getInstance().init(getPreferences(MODE_PRIVATE));
        Logger.init(this);

        if (!Prefs.getInstance().getAssetsCopiedFlag()) {
            Log.d(TAG, "instance acquired");
            String copyTo = this.getExternalFilesDir("").getPath();
            AssetsUtils assetsUtils = new AssetsUtils(this.getAssets());
            assetsUtils.copyAssetFolder("extra", copyTo);
            Prefs.getInstance().setAssetsCopiedFlag(true);
        }

        EngineManager.getInstance().init(this);

    }


    private void saveVoice() {

        startRecordButton.setText("Start Recording (Step 1)");

        startRecordButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                //  startRecordButton.setEnabled(false);

                if (counter < Folders.MAX_REPEAT) {


                    final String username = name;
                    final EngineManager engineManager = EngineManager.getInstance();
                    final Folders folders = new Folders(VoiceSDKActivity.this);
                   // Users users = dao.findByName(name);

//                    if (users != null) {
//                        String string = String.format(S_ALREADY_EXISTS_PLEASE_USE_ANOTHER_USERNAME, username);
//                        error.setText(string);
//                        error.setVisibility(View.VISIBLE);
//                        return;
//                    }

                    Log.d(TAG, "before setOnStopListener: " + counter);

                    openDialog(engineManager, username);

                } else {
                    Toast.makeText(VoiceSDKActivity.this, "Enrollment Complete", Toast.LENGTH_SHORT).show();
                }

            }

        });

    }

    private void openDialog(final EngineManager engineManager, final String username) {

        RecordDialog dialog = RecordDialog.newInstance(phraseString, username);

        dialog.setOnStopListener(new OnStopRecording() {

            @Override
            public void onStop(final AudioRecord recordObject) {
                Log.d(TAG, "size of data: " + recordObject.data.length);
                showLoader();
                task = new AsyncTask() {
                    @Override
                    protected Object doInBackground(Object[] objects) {
                        //Looper.prepare();
                        voices[counter] = engineManager.verifyEngine.createVoiceTemplate(recordObject.data, recordObject.sampleRate);
                        if (counter == 0) {

                            //  startRecordButton.setEnabled(true);
                            // hideLoader();
                            VoiceSDKActivity.this.runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    String message = String.format("Recording #%d successfully complete!", counter + 1);
                                    Toasty.success(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
                                    startRecordButton.setText("Start Recording (Step 2)");
                                    changeCounter(counter + 1);
                                    spinner.setVisibility(GONE);
                                    phrase.setVisibility(View.VISIBLE);
                                    hideLoader();

                                }
                            });
                            //   task.cancel(true);

                            // hideLoader();
                        } else if (counter == 1) {

                            //showLoader()
                            if (checkVoiceMatch(recordObject, voices[0], engineManager) > 0.7) {
                                VoiceSDKActivity.this.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.d(TAG, "score is: " + checkVoiceMatch(recordObject, voices[0], engineManager));
                                        String message = String.format("Recording #%d successful!", counter + 1);
                                        Toasty.success(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
                                        hideLoader();
                                        startRecordButton.setText("Start Recording (Step 3)");
                                        changeCounter(counter + 1);
                                    }
                                });


                            } else {

                                VoiceSDKActivity.this.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.d(TAG, "score is: " + checkVoiceMatch(recordObject, voices[0], engineManager));
                                        String message = String.format("Failed to match voice with the previous one");
                                        Toasty.error(getApplicationContext(), message, Toast.LENGTH_SHORT).show();

                                        hideLoader();
                                    }
                                });

                            }
                        } else {
                            counter = 2;


                            if (checkVoiceMatch(recordObject, voices[1], engineManager) > 0.7) {

                                VoiceSDKActivity.this.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.d(TAG, "score is: " + checkVoiceMatch(recordObject, voices[1], engineManager));
                                        Toasty.success(getApplicationContext(), "Enrollment successfully completed", Toast.LENGTH_SHORT).show();
                                        hideLoader();
                                        showRegistrationCompleteTextViews(username);
                                    }
                                });
                            } else {

                                VoiceSDKActivity.this.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.d(TAG, "score is: " + checkVoiceMatch(recordObject, voices[1], engineManager));
                                        String message = String.format("Failed to match voice with the previous one");
                                        Toasty.error(getApplicationContext(), message, Toast.LENGTH_SHORT).show();

                                        hideLoader();
                                    }
                                });
                            }


                        }

                        task.cancel(true);
                        return null;
                    }
                };
                task.execute();

            }
        });
        dialog.show(getFragmentManager(), "DIALOG");
    }

    float checkVoiceMatch(final AudioRecord recordObject, final VoiceTemplate voices, final EngineManager engineManager) {

        VoiceTemplate record = engineManager.verifyEngine.createVoiceTemplate(recordObject.data, recordObject.sampleRate);
        VoiceTemplate template = voices;
        VerifyResult verificationResult = engineManager.verifyEngine.verify(record, template);
        score = verificationResult.probability;

        return score;
    }

    private void showRegistrationCompleteTextViews(String username) {
        constraintLayoutRegistration.setVisibility(GONE);

        // loaderView.setVisibility(View.GONE);
//        registrationCompleteTv1.setVisibility(View.VISIBLE);
//        registrationCompleteTv2.setVisibility(View.VISIBLE);
//        continueCardView.setVisibility(View.VISIBLE);

        regCompleteLinearLayout.setVisibility(View.VISIBLE);

        continuetoNextPage(continueButton,username);
    }

    private void showLoader() {
        constraintLayoutRegistration.setVisibility(GONE);
        logo.setVisibility(GONE);
        loaderView.setVisibility(View.VISIBLE);
    }

    private void hideLoader() {
        constraintLayoutRegistration.setVisibility(View.VISIBLE);
        logo.setVisibility(View.VISIBLE);
        loaderView.setVisibility(GONE);
    }

    private void continuetoNextPage(Button continueBtn,final String username) {
        continueBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "continue button clicked!!");
                saveUser(username);
                MainActivity.stopNative();
                VoiceSDKActivity.this.finish();
            }
        });
    }


    private void saveUser(String username) {
        Folders folders = new Folders(context);
        VoiceTemplate templateMerged = EngineManager.getInstance().verifyEngine.mergeVoiceTemplates(voices);
        String path = folders.createFile(username);
        templateMerged.saveToFile(path);
        Users users = new Users();
        users.setTime(new Date().getTime());
        users.setPath(path);
        users.setName(username);
        users.setPhrase(phraseString);
        dao.insert(users);
        Log.d(TAG, "user saved: " + username + path);
        timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                if (context != null) {

                }
            }
        }, 4000);
    }

    private void changeCounter(int newCounter) {
        int min = Math.min(counter, newCounter);
        int max = Math.max(counter, newCounter);
        for (int pos = min; pos < max; pos++) {
            if (newCounter > counter) {
                //      images.get(pos).setImageResource(R.mipmap.ok_on);
            } else if (counter > newCounter) {
                //     images.get(pos).setImageResource(R.mipmap.ok_off);
            }
        }
        counter = newCounter;
    }

    @Override
    protected void onStart() {
        super.onStart();

    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
//        dao.deleteUser();
//        Log.d(TAG,"user deleted!!");
        VoiceSDKActivity.this.finish();
    }
}
