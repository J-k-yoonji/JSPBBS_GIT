package utils;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

public class FileUtil {
    // 지정한 위치의 파일을 삭제합니다.
    public static void deleteFile(HttpServletRequest req,
            String directory, String filename) {
        String sDirectory = req.getServletContext().getRealPath(directory);
        File file = new File(sDirectory + File.separator + filename);
        if (file.exists()) {
            file.delete();
        }
    }
}
