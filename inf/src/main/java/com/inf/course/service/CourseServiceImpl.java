package com.inf.course.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;
import com.inf.course.mapper.CourseMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("courseService")
@Transactional
public class CourseServiceImpl implements CourseService {
	
	private static String CURR_COURSE_REPO_PATH = "C:\\inf\\file_repo\\course";
	private static String IMAGE_TEMP_PATH_COURSE = "C:\\inf\\temp\\course";

	@Setter(onMethod_ = @Autowired)
	private CourseMapper mapper;

	@Override
	public Map<String, List<CourseVO>> indexCourseLists() {
		Map<String, List<CourseVO>> map = new HashMap<String, List<CourseVO>>();
		List<CourseVO> startCourses = mapper.selectCourseSeqByLevel("입문");
		List<CourseVO> newCourses = mapper.selectCourseSeqByRegDT();
		map.put("startCourses", startCourses);
		map.put("newCourses", newCourses);
		return map;
	}

	@Override
	public List<CourseVO> allCourseList(String order) {
		List<CourseVO> allCourses = new ArrayList<CourseVO>();
		if(order == null || "recent".equals(order)) {
			allCourses = mapper.selectAllAbleCourses();
		}else if("rating".equals(order)){
			allCourses = mapper.selectAllAbleCoursesOrderByRating();
		}else { 
			allCourses = mapper.selectAllAbleCoursesOrderByPersonnel(); 
		}
		System.out.println("전체 강의 수 >>>>>>>> " + allCourses.size());
		return allCourses;
	}

	@Override
	public List<CategorySkillVO> categorySkillLists() {
		List<CategorySkillVO> list = mapper.selectAllCategoriesAndSkills();
		return list;
	}

	@Override
	public List<CourseVO> courseListByCategory(int category_seq) {
		List<CourseVO> list = mapper.selectCourseByCategory(category_seq);
		return list;
	}

	@Override
	public List<CourseVO> courseListByCategoryBySkill(Map<String, Integer> param) {
		List<CourseVO> list = mapper.selectCourseByCategoryAndSkill(param);
		System.out.println(list.size());
		return list;
	}

	@Override
	public CourseVO courseByCourseSeq(int course_seq) {
		CourseVO course = mapper.selectCourseByCourseSeq(course_seq);
		return course;
	}

	@Override
	public int addNewCourse(CourseVO course, List<Integer> category_seq, List<String> skill_nm) {
		log.info("강의 등록 serviceImpl 접근");
		// method 1
		mapper.insertNewCourse(course);
		int course_seq = course.getCourse_seq();
		log.info(course_seq);
		
		Map<String, Object> ct = new HashMap<String, Object>();
		ct.put("course_seq", course_seq);
		ct.put("category_seq", category_seq);
		// method 2
		int ctResult = mapper.insertNewCourseCategory(ct);
		log.info("course_category에 추가된 행수 >>>>>>> " + ctResult);
		
		List<SkillVO> skills = new ArrayList<SkillVO>();
		
		for(int i = 0; i<skill_nm.size();i++) {
			SkillVO skill = new SkillVO();
			skill.setSkill_nm(skill_nm.get(i));
			int result = mapper.findDuplicatedSkillName(skill);
			log.info("중복 확인 결과 >>>>>>> " + result);
			if(result > 0) {
				// method 3
				SkillVO _skill = mapper.findSkillSeqByName(skill);
				log.info(_skill);
				skills.add(_skill);
			}else {
				// method 3
				mapper.insertNewSkills(skill);
				log.info(skill);
				skills.add(skill);
			}
		}
		log.info(skills);
		
		Map<String, Object> sk = new HashMap<String, Object>();
		sk.put("course_seq", course_seq);
		sk.put("skills", skills);
		System.out.println(sk.get("skills"));
		// method 4
		int skResult = mapper.insertNewCourseSkills(sk);
		log.info("course_skill에 추가된 행수 >>>>>> " + skResult);
		
		if(skResult >0) {
			File srcFile = new File(IMAGE_TEMP_PATH_COURSE + "\\" + course.getCourse_img_nm());
			File destDir = new File(CURR_COURSE_REPO_PATH + "\\" + course_seq);
			try {
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return skResult;
	}

	// 승인 대기중인 강의 
	@Override
	public List<CourseVO> awaitCourse(String member_id) {
		List<CourseVO> await = mapper.selectAwaitCoursesById(member_id);
		return await;
	}

	@Transactional
	@Override
	public int cancelCourse(int course_seq) {
		int result = mapper.cancelCourseBySeq(course_seq);
		return result;
	}

	@Override
	public List<CourseVO> cancelCourse(String member_id) {
		List<CourseVO> cancle = mapper.selectCancelCoursesById(member_id);
		return cancle;
	}

	@Override
	public List<CourseVO> allAwaitCourse() {
		List<CourseVO> await = mapper.selectAllAwaitCourses();
		if(await.size() == 0) {
			await = null;
		}
		return await;
	}

	@Override
	public List<CourseVO> allAbleCourse() {
		List<CourseVO> able = mapper.selectAllAbleCourses();
		return able.size() == 0? null : able;
	}

	@Override
	public List<CourseVO> allEnableCourse() {
		List<CourseVO> enable = mapper.selectAllEnableCourses();
		return enable.size() == 0? null : enable;
	}

	@Override
	public int approveCourse(int course_seq) {
		int result = mapper.updateCourseStatusToApproved(course_seq);
		return result;
	}

	@Override
	public int stopCourse(int course_seq) {
		int result = mapper.updateCourseStatusToStop(course_seq);
		return result;
	}

	@Override
	public List<CourseVO> ableCourse(String member_id) {
		List<CourseVO> able = mapper.selectAbleCourses(member_id);
		return able.size() == 0? null : able;
	}

	@Override
	public int reapplyCourse(int course_seq) {
		int result = mapper.updateCourseStatusToAwait(course_seq);
		return result;
	}

	@Override
	public List<CourseVO> searchCourse(String type, String item) {
		String str = "%" + item + "%";
		switch (type) {
		case "skill":
			List<CourseVO> courseSkill = mapper.selectCourseBySearchSkill(str);
			return courseSkill.size() == 0 ? null : courseSkill;
		case "name":
			List<CourseVO> courseName = mapper.selectCourseBySearchName(str);
			return courseName.size() == 0 ? null : courseName; 	
		default:
			List<CourseVO> course = mapper.selectCourseBySearchAll(str);
			return course.size() == 0 ? null : course; 
		}
	}



}
