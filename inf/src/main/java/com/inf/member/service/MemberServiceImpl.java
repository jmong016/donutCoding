package com.inf.member.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;
import com.inf.member.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service("memberService")
@Transactional
@Log4j
public class MemberServiceImpl implements MemberService {

	private static String CURR_PROFILE_REPO_PATH = "C:\\inf\\file_repo\\profile";
	private static String IMAGE_TEMP_PATH_PROFILE = "C:\\inf\\temp\\profile";

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	// 아이디 체크
	@Override
	public int idChk(String member_id) {
		int result = memberMapper.idChk(member_id);
//		log.info("idChk>>>>>" + result );
		System.out.println(result);
		return result;
	}

	// 회원가입
	@Override
	public int register(MemberVO memberVO) {
		int result = memberMapper.register(memberVO);
		return result;
	}

	// 이메일 체크
	@Override
	public int emailChk(String member_email) {
		int result = memberMapper.emailChk(member_email);
		return result;
	}

	// 로그인
	@Override
	public UserVO login(String member_id, String member_password) {
		UserVO user = new UserVO();
		MemberVO member = selectOneById(member_id);
		if (member == null) {
			log.info("id에 해당하는 member 없음");
			return null;
		} else {
			log.info("mapper.xml 결과물 >>>>>>> " + member.getMember_id());
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (encoder.matches(member_password, member.getMember_password())) {
				log.info("비밀번호 일치");
				user.setMember_id(member.getMember_id());
				user.setMember_email(member.getMember_email());
				user.setMember_nickNM(member.getMember_nickNM());
				user.setMember_profile_img_nm(member.getMember_profile_img_nm());
				user.setMember_content(member.getMember_content());
				user.setMember_phoneNO(member.getMember_phoneNO());
				user.setMember_status(member.getMember_status());
				user.setMember_role(member.getMember_role());
				return user;
			} else {
				log.info("비밀번호 불일치");
				return null;
			}
		}

	}

	// 멘토 신청 - 회원 상태를 '승인대기'로 변경
	@Override
	public Map<String, Object> changeRoleToMentor(String member_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = memberMapper.updateMemberStatusToAwait(member_id);
		MemberVO member = selectOneById(member_id);
		UserVO user = new UserVO();
		user.setMember_id(member.getMember_id());
		user.setMember_nickNM(member.getMember_nickNM());
		user.setMember_role(member.getMember_role());
		user.setMember_status(member.getMember_status());

		map.put("result", result);
		map.put("user", user);

		return map;
	}

	// 멘토 신청 취소 - 회원 상태 취소로 만들고 다시 user 붙이기
	@Override
	public Map<String, Object> cancleApplyforMentor(String member_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = memberMapper.updateMemberStatusToCancle(member_id);
		MemberVO member = selectOneById(member_id);
		UserVO user = new UserVO();
		user.setMember_id(member.getMember_id());
		user.setMember_nickNM(member.getMember_nickNM());
		user.setMember_role(member.getMember_role());
		user.setMember_status(member.getMember_status());

		map.put("result", result);
		map.put("user", user);

		return map;
	}

	public MemberVO selectOneById(String member_id) {
		return memberMapper.selectOneById(member_id);
	}

	@Override
	public List<MemberVO> allMemberApplyToMentor() {
		List<MemberVO> list = memberMapper.selectAllAwaitMemberForMentor();
		if (list.size() <= 0) {
			list = null;
		}
		return list;
	}

	@Override
	public List<MemberVO> allMentorApproved() {
		List<MemberVO> list = memberMapper.selectAllMentor();
		if (list.size() <= 0) {
			list = null;
		}
		return list;
	}

	@Override
	public List<MemberVO> allMentorStopped() {
		List<MemberVO> list = memberMapper.selectAllMentorStopped();
		if (list.size() <= 0) {
			list = null;
		}
		return list;
	}

	@Override
	public int approveMentor(String member_id) {
		return memberMapper.updateMemberRoleToMentor(member_id);
	}

	@Override
	public int stopMentor(String member_id) {
		return memberMapper.updateMemberStatusToStop(member_id);
	}

	@Override
	public int restartMentor(String member_id) {
		return memberMapper.updateMemberStatusToApprove(member_id);
	}

	@Override
	public int changeProfileImage(MemberVO member) {
		int result = memberMapper.updateProfileImage(member);
		if (result > 0) {
			if (member.getMember_profile_img_nm().equals("default_profile.png")) {
				File srcFile = new File(CURR_PROFILE_REPO_PATH + "\\" + member.getMember_id());
				try {
					FileUtils.deleteDirectory(srcFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				File srcFile = new File(IMAGE_TEMP_PATH_PROFILE + "\\" + member.getMember_profile_img_nm());
				File destDir = new File(CURR_PROFILE_REPO_PATH + "\\" + member.getMember_id());
				try {
					FileUtils.deleteDirectory(destDir);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else {
			result = 0;
		}
		return result;
	}

	@Override
	public int changeMemberInfo(MemberVO member) {
		int result = memberMapper.updateMemberInformation(member);

		return result;
	}

	@Override
	public Map<String, String> changeMemberPassword(MemberVO member, String new_password) {
		Map<String, String> map = new HashMap<String, String>();

		MemberVO _member = selectOneById(member.getMember_id());

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if (encoder.matches(member.getMember_password(), _member.getMember_password())) {
			map.put("isMember", "yes");
			member.setMember_password(encoder.encode(new_password));
			int result = memberMapper.updateMemberPassword(member);
			if (result > 0) {
				map.put("result", "updated");
			} else {
				map.put("result", "failed");
			}
		} else {
			map.put("isMember", "no");
		}

		return map;
	}

	@Override
	public int changeMemberPhoneNo(MemberVO member) {
		int result = memberMapper.updateMemberPhoneNo(member);
		return result;
	}

	@Override
	public int getAllUserCount() {
		return memberMapper.selectAllUserCount();
	}

}
