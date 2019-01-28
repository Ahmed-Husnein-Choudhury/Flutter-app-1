package com.bholdhealth.medicaid.dialogs;

import android.app.DialogFragment;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.bholdhealth.medicaid.R;
import com.bholdhealth.medicaid.Utils.OnStopRecording;
import com.bholdhealth.medicaid.Utils.WavRecorder;
import com.bholdhealth.medicaid.Models.AudioRecord;
import com.bholdhealth.medicaid.Utils.Logger;

import com.skyfishjy.library.RippleBackground;

import java.util.concurrent.atomic.AtomicBoolean;

import static android.view.View.GONE;

public class RecordDialog extends DialogFragment {

    public static final String PHRASE = "PHRASE";
    public static final String NAME = "NAME";
    public String TAG=getClass().getSimpleName();
    private String userPhrase;
    TextView phraseTv,plsTv;
    private String userName;
    private WavRecorder recorder;
    private OnStopRecording listener;
    private RippleBackground rippleBackground;
    private AtomicBoolean isStop = new AtomicBoolean(false);

    public static RecordDialog newInstance(String phrase, String name) {

        RecordDialog recordDialog = new RecordDialog();
        Bundle bundle = new Bundle();
        bundle.putString(NAME, name);
        bundle.putString(PHRASE, phrase);
        recordDialog.setArguments(bundle);
        return recordDialog;
    }


    public void setOnStopListener(OnStopRecording listener) {
        this.listener = listener;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.dialog_record, container, false);
        userName = getArguments().getString(NAME);
        userPhrase = getArguments().getString(PHRASE);
        recorder = new WavRecorder();
        recorder.setOnStopRecoding(new OnStopRecording() {
            @Override
            public void onStop(AudioRecord recordObject) {
                onStopRecord(recordObject);
                Logger.writeLog(recordObject, userName, userPhrase);
            }

        });
        rippleBackground = rootView.findViewById(R.id.img);
        //loader=rootView.findViewById(R.id.dialog_loader);
        phraseTv=rootView.findViewById(R.id.phrase);
        plsTv=rootView.findViewById(R.id.pls);

        phraseTv.setText(getArguments().getString(PHRASE));
//        rootView.findViewById(R.id.stop_record_btn).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                AudioRecord recordObject = recorder.stopRecording();
//                onStopRecord(recordObject);
//                Logger.writeLog(recordObject, userName, userPhrase);
//            }
//
//        });
        return rootView;
    }

    private void onStopRecord(final AudioRecord recordObject) {

        if (getActivity() == null) return;
        if (!isStop.getAndSet(true)) {
            getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if (getDialog() != null) {
                        getDialog().dismiss();
                    }
                    if (listener != null) {
                        listener.onStop(recordObject);
                    }
                }
            });
        }
    }

    @Override
    public void onStart() {
        super.onStart();
        getDialog().getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        rippleBackground.startRippleAnimation();
        recorder.startRecording();
    }

    @Override
    public void onStop() {
        super.onStop();
        AudioRecord recordObject = recorder.stopRecording();
        if (recordObject != null) {
            onStopRecord(recordObject);
            Logger.writeLog(recordObject, userName, userPhrase);
        }
    }

}
