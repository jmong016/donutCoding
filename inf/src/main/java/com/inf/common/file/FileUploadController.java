package com.inf.common.file;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class FileUploadController {
	private static String IMAGE_TEMP_PATH_COURSE = "C:\\inf\\temp\\course";
	private static String IMAGE_TEMP_PATH_PROFILE = "C:\\inf\\temp\\profile";
	
	@ResponseBody
	@PostMapping("/uploadAjax")
	public Map<String, String> uploadAjax(MultipartFile uploadFile) {
		log.info("강의등록 >>>>>>>> 파일 임시 저장");
		Map<String, String> map = new HashMap<String, String>();
		
		String uploadFileName = UUID.randomUUID().toString() + "_" + uploadFile.getOriginalFilename();
		log.info(uploadFileName);
		
			try {
				File saveFile = new File(IMAGE_TEMP_PATH_COURSE, uploadFileName);
				if (checkImageType(saveFile)) {
					uploadFile.transferTo(saveFile);
					map.put("result", uploadFileName);
				}else {
					map.put("result", "falied");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
				return map;
	}
	
	@ResponseBody
	@PostMapping("/uploadAjaxProfile")
	public Map<String, String> uploadAjaxProfile(MultipartFile uploadFile) {
		log.info("정보 변경 >>>>>>>> 이미지 임시 저장");
		Map<String, String> map = new HashMap<String, String>();
		
		String uploadFileName = UUID.randomUUID().toString() + "_" + uploadFile.getOriginalFilename();
		log.info(uploadFileName);
		
		try {
				File saveFile = new File(IMAGE_TEMP_PATH_PROFILE, uploadFileName);
				// check image type file
				if (checkImageType(saveFile)) {
					uploadFile.transferTo(saveFile);
					map.put("result", uploadFileName);
				}else {
					map.put("result", "failed");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
				return map;
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}
}
