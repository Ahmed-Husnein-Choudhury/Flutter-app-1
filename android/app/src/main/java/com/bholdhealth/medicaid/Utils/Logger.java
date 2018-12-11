package com.bholdhealth.medicaid.Utils;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.support.v4.content.FileProvider;

import com.bholdhealth.medicaid.Models.AudioRecord;
import com.opencsv.CSVWriter;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


public class Logger {
    private static String basePath;

    public static void init(Context context) {
        basePath = context.getExternalFilesDir("userdata").getAbsolutePath();
        File file = new File(basePath);
        if (!file.exists()) {
            file.mkdirs();
        }
    }

    public static void writeLog(AudioRecord recordObject, String userName, String userPhrase) {

        // recordedDate, recordedTime, recordLength, name, recordParams, fileName, passPhrase

        List<String[]> data = new ArrayList<>();

        data.add(new String[]{"date and time of record", recordObject.audioInfo.recordingDatetime});
        data.add(new String[]{"length of record in seconds", String.valueOf(recordObject.audioInfo.length)});
        data.add(new String[]{"record's file name", "voice_" + recordObject.audioInfo.recordingDatetime + ".wav",});
        data.add(new String[]{"record's audio parameters", recordObject.audioInfo.params});
        data.add(new String[]{"user name", userName});
        data.add(new String[]{"user phrase", userPhrase});
        data.add(new String[]{"user template file name", userPhrase});

        try {
            CSVWriter writer = getWriter();
            writer.writeAll(data);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void writeYesNoLog(String confirmation) {

        List<String[]> data = new ArrayList<>();
        data.add(new String[]{"user confirm ", confirmation});

        try {
            CSVWriter writer = getWriter();
            writer.writeAll(data);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static CSVWriter getWriter() {

        try {
            CSVWriter writer;

            File dir = new File(basePath);

            String fileName = "VoiceLogData.csv";
            String filePath = dir + File.separator + fileName;
            File f = new File(filePath);

            if (f.exists() && !f.isDirectory()) {
                FileWriter fileWriter = new FileWriter(filePath, true);
                writer = new CSVWriter(fileWriter);
                return writer;
            } else {
                writer = new CSVWriter(new FileWriter(filePath));
                return writer;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void zipAndSendLogs(Context context) {
        String zipName = "VoiceBiometricsLogs.zip";

        File dir = context.getExternalFilesDir("logs");

        if (dir == null) {
            return;
        }

        String zipPath = dir.getAbsolutePath();

        String toLocation = zipPath + File.separator + zipName;

        File zipFileLocation = new File(zipPath + File.separator + zipName);
        zipFileLocation.getParentFile().mkdirs();

        final int BUFFER = 2048;

        File sourceFile = new File(context.getExternalFilesDir("userdata").getAbsolutePath());
        try {
            BufferedInputStream origin = null;
            FileOutputStream dest = new FileOutputStream(toLocation);
            ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(
                    dest));
            if (sourceFile.isDirectory()) {
                ZipEntry entry = new ZipEntry("userdata/");
                out.putNextEntry(entry);
                zipSubFolder(out, sourceFile, sourceFile.getParent().length());
            } else {
                byte data[] = new byte[BUFFER];
                FileInputStream fi = new FileInputStream(basePath);
                origin = new BufferedInputStream(fi, BUFFER);
                ZipEntry entry = new ZipEntry(getLastPathComponent(basePath));
                out.putNextEntry(entry);
                int count;
                while ((count = origin.read(data, 0, BUFFER)) != -1) {
                    out.write(data, 0, count);
                }
            }
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


        Uri path = FileProvider.getUriForFile(context, "com.idrnd.idvoice.fileprovider", zipFileLocation);
        Intent emailIntent = new Intent(Intent.ACTION_SEND);
        emailIntent.setType("vnd.android.cursor.dir/email");
        String to[] = {""}; //some email address
        emailIntent.putExtra(Intent.EXTRA_EMAIL, to);
        emailIntent.putExtra(Intent.EXTRA_STREAM, path);
        emailIntent.putExtra(Intent.EXTRA_SUBJECT, "Voice Biometrics Logs");
        context.startActivity(Intent.createChooser(emailIntent, "Voice Biometrics Logs"));
    }


    private static void zipSubFolder(ZipOutputStream out, File folder,
                                     int basePathLength) throws IOException {
        final int BUFFER = 2048;

        File[] fileList = folder.listFiles();
        BufferedInputStream origin = null;
        for (File file : fileList) {
            if (file.isDirectory()) {
                zipSubFolder(out, file, basePathLength);
            } else {
                byte data[] = new byte[BUFFER];
                String unmodifiedFilePath = file.getPath();
                String relativePath = unmodifiedFilePath.substring(basePathLength + 1);
                FileInputStream fi = new FileInputStream(unmodifiedFilePath);
                origin = new BufferedInputStream(fi, BUFFER);
                ZipEntry entry = new ZipEntry(relativePath);
                out.putNextEntry(entry);
                int count;
                while ((count = origin.read(data, 0, BUFFER)) != -1) {
                    out.write(data, 0, count);
                }
                origin.close();
            }
        }
    }

    private static String getLastPathComponent(String filePath) {
        String[] segments = filePath.split("/");
        if (segments.length == 0)
            return "";
        String lastPathComponent = segments[segments.length - 1];
        return lastPathComponent;
    }
}
