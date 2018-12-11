package com.bholdhealth.medicaid.Utils;

import android.content.Context;

import java.io.File;
import java.io.IOException;

/**
 * Created by dmitry on 06.08.17.
 */

public class Folders {

    public static final int MAX_REPEAT = 3;
    public static final String TEMPLATE = "template";
    public static final String VERIFY = "verify";
    public static final String EXT = ".wav";
    private final String basePath;

    public Folders(Context context) {
        this.basePath = context.getExternalFilesDir("userdata").getAbsolutePath();
        File file = new File(this.basePath);
        if (!file.exists()) {
            file.mkdirs();
        }
    }

    public String createFile(String name) {
        String format = getPath().append("/").append(name).toString();
        File file = new File(format);
        try {
            file.createNewFile();
            return file.getAbsolutePath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }

    private StringBuilder getPath() {
        return new StringBuilder(basePath);
    }

    public void deleteUsers() {
        File file = new File(getPath().toString());
        if (file.list() != null && file.list().length > 0) {
            for (String item : file.list()) {
                File delete = new File(file.getAbsolutePath() + File.separator + item);
                delete.delete();
            }
        }
    }

    public String getTemplate(String user) {
        return getPath().append(File.separator).append(user).toString();
    }
}
