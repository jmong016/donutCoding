package com.inf.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.inf.course.mapper.CourseMapper;
import com.inf.member.mapper.MemberMapper;
import com.inf.task.domain.CourseFileVO;
import com.inf.task.domain.ProfileFileVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class TempFileCheck {

	@Setter(onMethod_ = @Autowired)
	private CourseMapper courseMapper;

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	// 일정 시간마다 자동 실행
	// 초(0~59) 분(0~59) 시(0~23) 일(1~31) 월(1~12 or JAN~DEC) 년(빈값, 1970~2099)
	// 매시 25분마다 DB에서 사용하지 않는 이미지들을 삭제한다.
	@Scheduled(cron = "0 30 * * * *")
	public void tempImageCheck(){

		log.warn("임시 폴더 파일을 확인합니다......................................");
		log.warn(new Date());

		List<CourseFileVO> course = courseMapper.selectCourseImageFiles();
		List<ProfileFileVO> profile = memberMapper.selectProfileImageFiles();

		List<Path> coursePaths = course.stream()
				.map(vo -> Paths.get("C:\\inf\\file_repo\\", vo.getCourse_seq() +"\\" + vo.getCourse_img_nm()))
				.collect(Collectors.toList());
		
		List<Path> profilePaths = profile.stream()
				.map(vo -> Paths.get("C:\\inf\\file_repo\\", vo.getMember_id() +"\\" + vo.getMember_profile_img_nm()))
				.collect(Collectors.toList());

		File courseDir = Paths.get("C:\\inf\\temp\\course").toFile();
		File profileDir = Paths.get("C:\\inf\\temp\\profile").toFile();

		// .listFiles 해당하는 파일을 다 보여준다.
		File[] courses = courseDir.listFiles(file -> course.contains(file.toPath()) == false);
		File[] profiles = profileDir.listFiles(file -> profile.contains(file.toPath()) == false);
		
		log.warn("===========================================");
		for(File file : courses) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		log.warn("===========================================");
		for(File file : profiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
