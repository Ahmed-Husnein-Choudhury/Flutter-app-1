package com.bholdhealth.medicaid.Models;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AudioRecord {

    public class AudioInfo {
        public String params;
        public String recordingDatetime;
        public long length;
    }

    public float[] data;
    public int sampleRate;
    public AudioInfo audioInfo;

    public AudioRecord(float[] data, int sampleRate, long length, String additionalParams) {
        this.data = data;
        this.sampleRate = sampleRate;

        this.audioInfo = new AudioInfo();
        this.audioInfo.length = length;
        this.audioInfo.params = additionalParams;
        this.audioInfo.recordingDatetime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
    }
}
