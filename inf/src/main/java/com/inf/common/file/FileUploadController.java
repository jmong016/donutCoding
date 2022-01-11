package com.inf.common.file;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class FileUploadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\inf\\file_repo";
	private static String IMAGE_TEMP_PATH = "C:\\inf\\temp";
	
	
	@ResponseBody
	@PostMapping("/uploadAjax")
	public Map<String, String> uploadAjax(MultipartFile uploadFile) {
		log.info("강의등록 >>>>>>>> 파일 임시 저장");
		Map<String, String> map = new HashMap<String, String>();
		
		String uploadFileName = uploadFile.getOriginalFilename();
		log.info(uploadFileName);
		
		File uploadPath = new File(IMAGE_TEMP_PATH, uploadFileName);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				uploadFile.transferTo(saveFile);

				// check image type file
				if (checkImageType(saveFile)) {
					map.put("result", uploadFileName);
				}else {
					map.put("result", "falied");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
				return map;
	}
	
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
}
