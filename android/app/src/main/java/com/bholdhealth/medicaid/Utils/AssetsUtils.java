package com.bholdhealth.medicaid.Utils;

import android.content.res.AssetManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class AssetsUtils {
    private AssetManager assetManager;

    public AssetsUtils(AssetManager assetManager) {
        this.assetManager = assetManager;
    }

    private void copyFileOrDir(String path, String toPath) {
        String assets[];

        try {
            assets = assetManager.list(path);

            if (assets.length == 0) {
                copyFile(path, toPath);
            } else {
                String fullPath = toPath + "/" + path;

                File dir = new File(fullPath);
                if (!dir.exists())
                    dir.mkdir();

                for (String asset: assets) {
                    copyFileOrDir(path + "/" + asset, toPath);
                }
            }
        } catch (IOException ex) {}
    }

    public void copyAssetFolder(String fromAssetPath, String toPath) {
        copyFileOrDir(fromAssetPath, toPath);
    }

    private void copyFile(String filename, String toPath) {
        InputStream in;
        OutputStream out;

        try {
            in = assetManager.open(filename);
            String newFileName = toPath+ "/" + filename;
            out = new FileOutputStream(newFileName);

            byte[] buffer = new byte[1024];
            int read;
            while ((read = in.read(buffer)) != -1) {
                out.write(buffer, 0, read);
            }

            in.close();
            out.flush();
            out.close();
        } catch (Exception e) {}
    }
}
