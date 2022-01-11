package com.inf.course.service;

import java.util.List;
import java.util.Map;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;

public interface CourseService {

	Map<String, List<CourseVO>> indexCourseLists();
	List<CourseVO> allCourseList();
	List<CategorySkillVO> categorySkillLists();
	List<CourseVO> courseListByCategory(int category_seq);
	List<CourseVO> courseListByCategoryBySkill(Map<String, Integer> param);
	CourseVO courseByCourseSeq(int category_seq);
	int addNewCourse(CourseVO course, List<Integer> category_seq, List<String> skill_nm);
	List<CourseVO> awaitCourse(String member_id);
	CourseVO cancelCourse(int course_seq);
	List<CourseVO> cancelCourse(String member_id);

}
