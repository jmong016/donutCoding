package com.inf.course.service;

import java.util.List;
import java.util.Map;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;

public interface CourseService {

	Map<String, List<CourseVO>> indexCourseLists();
	List<CourseVO> allCourseList(String order);
	List<CategorySkillVO> categorySkillLists();
	List<CourseVO> courseListByCategory(int category_seq);
	List<CourseVO> courseListByCategoryBySkill(Map<String, Integer> param);
	CourseVO courseByCourseSeq(int course_seq);
	int addNewCourse(CourseVO course, List<Integer> category_seq, List<String> skill_nm);
	List<CourseVO> awaitCourse(String member_id);
	int cancelCourse(int course_seq);
	List<CourseVO> cancelCourse(String member_id);
	List<CourseVO> ableCourse(String member_id);
	List<CourseVO> allAwaitCourse();
	List<CourseVO> allAbleCourse();
	List<CourseVO> allEnableCourse();
	int approveCourse(int course_seq);
	int stopCourse(int course_seq);
	int reapplyCourse(int course_seq);
	List<CourseVO> searchCourse(String type, String item);

}
