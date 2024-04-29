package org.prajwal.techblogjsp.utility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class FileUpdater {

    // function to delete a file
    public static boolean deleteFile(String filePath) {
        boolean flag = false;

        try {
            // deletes the file on that path
            File file = new File(filePath);
            flag = file.delete();
        }catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public static boolean saveFile(InputStream inputStream, String filePath) {
        boolean flag = false;

        try {
            byte[] bytes = new byte[inputStream.available()];
            inputStream.read(bytes);
            FileOutputStream fileOutputStream = new FileOutputStream(filePath);
            fileOutputStream.write(bytes);
            fileOutputStream.flush();
            fileOutputStream.close();
            flag = true;
        }catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }
}
