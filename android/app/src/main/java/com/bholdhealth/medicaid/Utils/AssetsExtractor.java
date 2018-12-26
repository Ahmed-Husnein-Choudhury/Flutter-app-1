package com.bholdhealth.medicaid.Utils;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//
import android.content.Context;
import android.content.res.AssetManager;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class AssetsExtractor {
    private AssetManager assetManager;
    private Context context;
    public static String IDSDK_INIT_DATA_PATH = "init_data";

    public AssetsExtractor(Context context) {
        this.assetManager = context.getAssets();
        this.context = context;
    }

    public String extract(String dir) throws RuntimeException {
        File externalFilesDir = this.context.getExternalFilesDir("");
        if (externalFilesDir == null) {
            throw new RuntimeException("Cannot retrieve external files dir!");
        } else {
            String to = externalFilesDir.getPath();
            this.copyFileOrDir(dir, to);
            return to + "/" + dir;
        }
    }

    private void copyFileOrDir(String path, String toPath) throws RuntimeException {
        try {
            String[] assets = this.assetManager.list(path);
            if (assets != null) {
                if (assets.length == 0) {
                    this.copyFile(path, toPath);
                } else {
                    String fullPath = toPath + "/" + path;
                    File dir = new File(fullPath);
                    if (!dir.exists() && !dir.mkdir()) {
                        throw new RuntimeException("Unable to create destination dir!");
                    }

                    if (!path.equals("")) {
                        path = path + "/";
                    }

                    String[] var6 = assets;
                    int var7 = assets.length;

                    for(int var8 = 0; var8 < var7; ++var8) {
                        String asset = var6[var8];
                        this.copyFileOrDir(path + asset, toPath);
                    }
                }
            }
        } catch (IOException var10) {
            var10.printStackTrace();
        }

    }

    private void copyFile(String filename, String toPath) {
        try {
            InputStream in = this.assetManager.open(filename);
            String newFileName = toPath + "/" + filename;
            OutputStream out = new FileOutputStream(newFileName);
            byte[] buffer = new byte[1024];

            int read;
            while((read = in.read(buffer)) != -1) {
                out.write(buffer, 0, read);
            }

            in.close();
            out.flush();
            out.close();
        } catch (Exception var8) {
            var8.printStackTrace();
        }

    }
}

