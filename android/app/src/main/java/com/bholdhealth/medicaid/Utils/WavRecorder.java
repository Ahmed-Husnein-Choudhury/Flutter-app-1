package com.bholdhealth.medicaid.Utils;

import android.media.AudioFormat;
import android.media.MediaRecorder;
import android.util.Log;

import com.bholdhealth.medicaid.Models.AudioRecord;

import net.idrnd.voicesdk.media.SpeechProcessor;

import java.nio.ByteBuffer;
import java.nio.ShortBuffer;
import java.util.ArrayList;
import java.util.List;

import static android.content.ContentValues.TAG;

public class WavRecorder {
    private enum Status {
        IDLE,
        WORKING
    }
    private static final int RECORDER_SAMPLERATE = 16000;
    private static final int RECORDER_CHANNELS = AudioFormat.CHANNEL_IN_MONO;
    private static final int RECORDER_AUDIO_ENCODING = AudioFormat.ENCODING_DEFAULT;
    private final SpeechProcessor processor;
    private android.media.AudioRecord recorder;
    private int bufferSize;
    private Thread recordingThread;
    private List<Float> audioData;
    private Status status = Status.IDLE;
    private OnStopRecording onStopRecording;
    private String recorderParams;
    private long startRecordingTime;

    public WavRecorder() {
        processor = new SpeechProcessor(RECORDER_SAMPLERATE);

        bufferSize = android.media.AudioRecord.getMinBufferSize(RECORDER_SAMPLERATE, RECORDER_CHANNELS, RECORDER_AUDIO_ENCODING) * 3;
        if (bufferSize < 0)
            bufferSize = 4000;

        recorder = new android.media.AudioRecord(
                MediaRecorder.AudioSource.DEFAULT,
                RECORDER_SAMPLERATE, RECORDER_CHANNELS,
                RECORDER_AUDIO_ENCODING, bufferSize);

        recorderParams = "sample rate = " + String.valueOf(RECORDER_SAMPLERATE) + ", mono, encode PCM_16";
        Log.d(TAG,recorderParams);

        audioData = new ArrayList<>();
    }

    public void startRecording() {
        if (status == Status.IDLE) {
            recorder.startRecording();

            status = Status.WORKING;

            recordingThread = new Thread(new Runnable() {
                @Override
                public void run() {
                    bufferCallback();
                }
            }, "AudioRecorder Thread");

            startRecordingTime = System.currentTimeMillis();

            processor.startStream();
            recordingThread.start();
        }
    }

    private void bufferCallback() {
        byte data[] = new byte[bufferSize];

        int read;

        while (status == Status.WORKING) {
            read = recorder.read(data, 0, bufferSize);

            if (read != android.media.AudioRecord.ERROR_INVALID_OPERATION) {
                ShortBuffer shortBuffer = ByteBuffer.wrap(data, 0, bufferSize).asShortBuffer();
                short[] shortArray = new short[shortBuffer.limit()];
                shortBuffer.get(shortArray);

                float[] floatArray = new float[shortBuffer.limit()];

                for (int i = 0; i < shortArray.length; i++) {
                    floatArray[i] = (float) Short.reverseBytes(shortArray[i]);
                    audioData.add(floatArray[i]);
                }

                processor.addSamples(floatArray);

                if (processor.getSpeechEnd() > 0) {
                    onStopRecording.onStop(stopRecording());
                    Log.d(TAG,"onStopRecording called in WavRecorder");
                }
            }
        }
    }

    public void setOnStopRecoding(OnStopRecording listener) {
        onStopRecording = listener;
    }

    synchronized public AudioRecord stopRecording() {
        if (status == Status.WORKING) {

            status = Status.IDLE;

            try {
                recorder.stop();
            } catch (RuntimeException ex) {
                ex.printStackTrace();
            }

            recordingThread = null;

            final int bufferSize = audioData.size();
            Log.d(TAG,"audioData: "+audioData);
            float[] floats = new float[bufferSize];

            for (int i = 0; i < bufferSize; i++) {
                floats[i] = audioData.get(i);
            }

            return new AudioRecord(
                    floats,
                    RECORDER_SAMPLERATE,
                    (System.currentTimeMillis() - startRecordingTime) / 1000,
                    recorderParams
            );
        } else {
            return null;
        }
    }
}
