package com.inf.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;


@Controller
public class FileDownloadController {
	private static String CURR_COURSE_REPO_PATH = "C:\\inf\\file_repo\\course";
	private static String CURR_PROFILE_REPO_PATH = "C:\\inf\\file_repo\\profile";
	
	@RequestMapping("/download")
	protected void download(@RequestParam("img_nm") String img_nm,
		                 	@RequestParam("course_seq") String course_seq,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_COURSE_REPO_PATH+"\\"+course_seq+"\\"+img_nm;
		File image=new File(filePath);

		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; img_nm="+img_nm);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); 
			if(count==-1)  
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
		
	@RequestMapping("/thumbnails")
	protected void thumbnails(@RequestParam("img_nm") String img_nm, @RequestParam("course_seq") String course_seq,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_COURSE_REPO_PATH+"\\"+course_seq+"\\"+img_nm;
		File image=new File(filePath);
		
		int lastIndex = img_nm.lastIndexOf(".");
		String imageFileName = img_nm.substring(0,lastIndex);
		
		if (image.exists()) { 
			Thumbnails.of(image).size(350, 450).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
	@RequestMapping("/detail/thumbnails")
	protected void detailThumbnails(@RequestParam("img_nm") String img_nm, @RequestParam("course_seq") String course_seq,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_COURSE_REPO_PATH+"\\"+course_seq+"\\"+img_nm;
		File image=new File(filePath);
		
		int lastIndex = img_nm.lastIndexOf(".");
		String imageFileName = img_nm.substring(0,lastIndex);
		
		if (image.exists()) { 
			Thumbnails.of(image).size(500, 300).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
	@RequestMapping("/profile")
	protected void profile(@RequestParam("img_nm") String img_nm, @RequestParam("member_id") String member_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		File image;
		if(img_nm.equalsIgnoreCase("default_profile.png")) {
			String filePath=CURR_PROFILE_REPO_PATH+"\\common\\"+img_nm;
			image=new File(filePath);
		}else {
			String filePath=CURR_PROFILE_REPO_PATH+"\\"+member_id+"\\"+img_nm;
			image=new File(filePath);
		}
		
		int lastIndex = img_nm.lastIndexOf(".");
		String imageFileName = img_nm.substring(0,lastIndex);
		
		if (image.exists()) { 
			Thumbnails.of(image).size(300, 400).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
