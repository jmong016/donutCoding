package com.inf.course.mapper;

import java.util.List;
import java.util.Map;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;

public interface CourseMapper {

	public List<CourseVO> selectCourseSeqByLevel(String level);
	public List<CourseVO> selectCourseSeqByRegDT();
	public List<CourseVO> selectCourseList(List<Integer> startCoursesSeq);
	public List<CourseVO> selectAllCourses();
	public List<CategorySkillVO> selectAllCategoriesAndSkills();
	public List<CourseVO> selectCourseByCategory(int category_seq);
	public List<CourseVO> selectCourseByCategoryAndSkill(Map<String, Integer> param);
	public CourseVO selectCourseByCourseSeq(int category_seq);
	public List<SkillVO> selectSkillListByCtseq(int course_seq);
	public int insertNewCourse(CourseVO course);
	public int insertNewCourseCategory(Map<String, Object> ct);
	
	public int findDuplicatedSkillName(SkillVO skill);
	public SkillVO findSkillSeqByName(SkillVO skill);
	public int insertNewSkills(SkillVO skill);
	public int insertNewCourseSkills(Map<String, Object> sk);
	public List<CourseVO> selectAwaitCoursesById(String member_id);
	public int cancelCourseBySeq(int course_seq);
	public List<CourseVO> selectCancelCoursesById(String member_id);
	
}