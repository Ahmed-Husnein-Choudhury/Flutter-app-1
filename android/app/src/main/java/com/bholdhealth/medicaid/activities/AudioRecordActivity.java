package com.bholdhealth.medicaid.activities;

import android.content.Context;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.os.Environment;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.bholdhealth.medicaid.R;

import java.io.IOException;

import io.flutter.app.FlutterActivity;

public class AudioRecordActivity extends FlutterActivity {

    private Button play, stop, record;
    private MediaRecorder myAudioRecorder;
    private String outputFile;
    Context context;
    int YOUR_REQUEST_CODE = 200;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_audio_record);
        outputFile = Environment.getExternalStorageDirectory().getAbsolutePath() + "/recording.3gp";
        play = (Button) findViewById(R.id.play);
        stop = (Button) findViewById(R.id.stop);
        record = (Button) findViewById(R.id.record);

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) //check if permission request is necessary
//        {
//                .requestPermissions(this, new String[] {android.Manifest.permission.RECORD_AUDIO, android.Manifest.permission.WRITE_EXTERNAL_STORAGE}, YOUR_REQUEST_CODE});
//    }

        myAudioRecorder=new MediaRecorder();
        myAudioRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        myAudioRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
        myAudioRecorder.setAudioEncoder(MediaRecorder.OutputFormat.AMR_NB);


        myAudioRecorder.setOutputFile(outputFile);

        record.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    myAudioRecorder.prepare();
                    myAudioRecorder.start();
                } catch (IllegalStateException ise) {
                    // make something ...
                } catch (IOException ioe) {
                    // make something
                }
                record.setEnabled(false);
                stop.setEnabled(true);
                Log.d("audio record", "bla");
                Toast.makeText(getApplicationContext(), "Recording started", Toast.LENGTH_LONG).show();
            }
        });

        stop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAudioRecorder.stop();
                myAudioRecorder.release();
                myAudioRecorder = null;
                record.setEnabled(true);
                stop.setEnabled(false);
                play.setEnabled(true);
                Toast.makeText(getApplicationContext(), "Audio Recorded successfully", Toast.LENGTH_LONG).show();
            }
        });

        play.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MediaPlayer mediaPlayer = new MediaPlayer();
                try {
                    mediaPlayer.setDataSource(outputFile);
                    mediaPlayer.prepare();
                    mediaPlayer.start();
                    Toast.makeText(getApplicationContext(), "Playing Audio", Toast.LENGTH_LONG).show();
                } catch (Exception e) {
                    // make something
                }
            }
        });
    }
}
