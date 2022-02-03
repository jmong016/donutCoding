<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#change-info-wrapper .flex-item{
	display: flex;
	flex-wrap: wrap;
}

#change-info-wrapper .flex-wrap {
	display: flex;
	flex-direction:column;
	flex-wrap: wrap;
}

#change-info-wrapper .flex-wrap * {
	padding: 0.2em;
	margin: auto;
}

#change-info-wrapper .validate {
	display: none;
	color: var(--accent-color);
	font-weight: bold;
	color: var(--accent-color);
	text-align: center;
}

#change-info-wrapper .apply-wrapper>div {
	padding: 0.5em 0;
}

#change-info-wrapper .method-check {
	display: none;
}
#change-info-wrapper .profile-change .flex-wrap input[type="file"]{
	position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
    }
#change-info-wrapper .profile-change .flex-wrap .upload-name{
	text-align: center;
	vertical-align: middle;
	border: 1px solid #ebebeb;
	border-radius: 5px;
}
#change-info-wrapper input[type="text"],input[type="password"],input[type="email"]{
	width:100%;
	border-radius: 1em;
	text-align: center;
	border: 2px solid var(--main-color);
	font-size: 1.3rem;
}
#change-info-wrapper input[type="password"]{
	margin : 0.2em auto;
}
#change-info-wrapper .save-sec{
	border: 1px solid #ebebeb;
	padding: 1em;
	width: 80%;
	margin: 1em auto;
}
#change-info-wrapper .save-btn{
	display:block;
	width: 60%;
	margin: 1em auto;
	padding: 0.5em;
}
#change-info-wrapper .input-wrapper{
	margin-bottom: 1.2em;
}
#change-info-wrapper #email-btn{
	display: block;
	margin: auto;
}
</style>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<div id="mypage-wrapper">
<c:choose>
	<c:when test="${user.member_role == '멘토'}">
	<%@ include file="../common/aside_mentor.jsp" %>
	</c:when>
	<c:when test="${user.member_role == '관리자'}">
	<%@ include file="../common/aside_admin.jsp" %>
	</c:when>
	<c:otherwise>
	<%@ include file="../common/aside.jsp" %>
	</c:otherwise>
</c:choose>

<section id="mypage-content">
	<div id="change-info-wrapper">
				<div class="info-wrapper" >
					<h4 class="p-3" style="width: max-content;margin:auto;">정보 변경</h4>
					<div class="save-sec">
					<!-- 프로필 이미지 -->
					<div class="profile-change input-wrapper">
						<p id="thumb-check-null" class="validate">프로필 이미지는 반드시 첨부해야합니다.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>프로필 이미지</strong>
									
								</h5>
							</div>
							<label for="profile_select">
							<img id="preview" class="img-thumbnail" alt="thumbnail"
							src="${path }/profile?member_id=${user.member_id}&img_nm=${user.member_profile_img_nm}"
							style="width: 170px;height:170px;border-radius: 50%;border:none;object-fit:cover;">
							</label>
							<input id="profile_select" type="file" name="member_profile_img_nm">
							<div>
							<button id="default-profile-btn" type="button" class="btn btn-outline-primary" 
							onclick="useDefaultProfileImg()" data-check="false">
							기본 이미지 사용</button>
							</div>
							<button id="btn-profile" class="btn btn-primary save-btn" type="button" onclick="changeProfileImage()">변경하기</button>
						</div>
					</div>
					</div>
					
					<div class="save-sec section-info">
					<!-- 닉네임 -->
					<div class="nick-change input-wrapper">
						<p id="nick-check" class="validate">닉네임은 최대 10글자까지 입력가능합니다.</p>
						<p id="nick-check-null" class="validate">닉네임을 입력하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>닉네임</strong>
								</h5>
							</div>
							<input id="member_nickNM" type="text" maxlength="10"
								name="member_nickNM" value="${user.member_nickNM }" 
								oninput="changeCheck($('#member_nickNM'),'${user.member_nickNM }',$('#nick-check-null'),$('#btn-info'))">
						</div>
					</div>
					<!-- 자기소개 -->
					<div class="intro-change input-wrapper">
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>자기 소개</strong>
								</h5>
							</div>
						</div>
						<div style="width: 70%;margin:auto;min-width: 300px;">
							<textarea id="summernote" name="member_content" maxlength="20">
							${user.member_content }</textarea>
						</div>
					</div>
					<!-- 이메일 -->
					<div class="email-change input-wrapper">
						<p id="email-check" class="validate">이메일 형식이 일치하지 않습니다.</p>
						<p id="email-check-duple" class="validate" style="color:red;">이메일 중복 체크는 필수입니다.</p>
						<p id="email-check-no" class="validate"  style="color:red;">이미 사용중인 이메일입니다.</p>
						<p id="email-check-ok" class="validate" style="color:blue;">사용 가능한 이메일입니다.</p>
						<p id="email-check-null" class="validate">이메일을 입력하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>이메일</strong>
								</h5>
							</div>
							<input id="member_email" type="email" maxlength="20" placeholder="ex) abc@abc.com"
								name="member_email" value="${user.member_email }"
								oninput="changeCheck($('#member_email'),'${user.member_email }',$('#email-check-null'),$('#btn-info'))">
						</div>
						<button id="email-btn" type="button" class="btn btn-danger" data-check="false" 
						onclick="isDuplicated($('#member_email'))">
						중복 체크</button>
					</div>
						
					<!-- 전화번호 -->
					<div class="phone-change input-wrapper">
						<p id="phone-check" class="validate">휴대폰 번호 형식과 일치하지 않습니다.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>전화번호</strong>
								</h5>
							</div>
							<input id="member_phoneNO" type="text" maxlength="11"
								name="member_phoneNO" value="${user.member_phoneNO }" placeholder="ex) 01099996666"
								oninput="changeCheck($('#member_phoneNO'),'${user.member_phoneNO }','noop',$('#btn-info'))">
						</div>
					</div>
					<button id="btn-info" class="btn btn-primary save-btn" type="button" onclick="saveInfo()">저장하기</button>
					</div>
					
					<div class="save-sec section-pw">
					<!-- 비밀번호 -->
					<div class="pw-change">
						<p id="pw-check-curr" class="validate" style="color:red;">현재 비밀번호가 일치하지 않습니다.</p>
						<p id="pw-check-null" class="validate">비밀번호를 입력하세요.</p>
						<p id="pw-check-exp" class="validate">영문+숫자 2~15자리 입력가능합니다.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>비밀번호</strong>
								</h5>
							</div>
							<input id="member_password" type="password" maxlength="33"
								name="member_password" placeholder="현재 비밀번호"
								oninput="passwordCheck($('#member_password'))">
							<p id="pw-check-new" class="validate">변경 비밀번호와 확인 비밀번호가 일치하지 않습니다.</p>
							<input id="new_password" type="password" maxlength="33"
								name="new_password" placeholder="변경할 비밀번호"
								oninput="passwordCheck($('#new_password'))">
							<input id="new_password_check" type="password" maxlength="33"
								name="new_password_check" placeholder="비밀번호 확인"
								oninput="passwordCheck($('#new_password_check'))">
						</div>
					</div>
						<button id="btn-pw" class="btn btn-primary save-btn" type="button"
						onclick="changePassword()">변경하기</button>
					</div>
					
					
					<!-- 회원 탈퇴 -->
					<div class="save-sec section-resign">
						<p id="resign-check" class="validate">비밀번호가 일치하지 않습니다.</p>
						<p id="resign-check-null" class="validate">비밀번호를 입력하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h5>
									<strong>회원탈퇴</strong>
								</h5>
							</div>
							<input id="member_password" type="password" name="member_password" placeholder="현재 비밀번호">
						</div>
						<button id="btn-resign" class="btn btn-danger save-btn" type="button">탈퇴하기</button>
					</div>
				</div>
	</div>
</section>
</div>

<script type="text/javascript">
var curImg;
$(document).ready(function() {
	/* 썸머노트 */
	$('#summernote').summernote({
		maxHeight : 500,
		maxWidth : 500,
		minHeight : 300,
		minWidth : 300,
	});
	
	$("#btn-info").prop("disabled",true);
	$("#btn-profile").prop("disabled",true);
	$("#email-btn").prop("disabled",true);
	
	curImg = $("#preview").attr('src');
	
	/* MutationObserver */
	// 대상 node 선택
	var target = $(".note-editable")[0];
	var curVal = $(".note-editable").html();
	console.log(curVal);
		// 감시자 인스턴스 만들기
		var observer = new MutationObserver(function(mutations) {
			var cnt=0;
			mutations.forEach(function(mutation) {
				var val = $(".note-editable").html();
				console.log(mutation.target);
				if(val == curVal){
					$("#btn-info").prop("disabled",true);
				}else{
					$("#btn-info").prop("disabled",false);
				}
			});
		});
		// 감시자의 설정:
		var config = {
			attributes : true,
			childList : true,
			characterData : true,
			subtree : true
		};
		// 감시자 옵션 포함, 대상 노드에 전달
		observer.observe(target, config);
		// 나중에, 감시를 중지 가능
		//observer.disconnect();
	});

	// 프로필 이미지 변경
	$("#profile_select").on("change", function() {
		var formData = new FormData();
		var file = $(this)[0].files[0];
		var regex = new RegExp("(.*?)\.(png|jpg|jpeg|svg)$");
		var maxSize = 5242880; //5MB

		if (file.size >= maxSize) {
			alert("5MB 미만 용량만 첨부가능합니다.");
			$(this).val("");
			return false;
		}
		if (!regex.test(file.name)) {
			alert("이미지 파일만 첨부할 수 있습니다.");
			$(this).val("");
			return false;
		}

		formData.append("uploadFile", file);
		
		$.ajax({
			url : '${path}/uploadAjaxProfile',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				var result = data.result;
				if (result == "failed") {
					alert("이미지 등록 실패, 다시 시도해주세요.");
				} else {
					$("#profile_select").data("img", result);
				}
			}
		});
		
		setImageFromFile(this, '#preview');
		
		var changeImg = $("#preivew").attr("src");
		
		if(curImg == changeImg){
			$("#btn-profile").prop("disabled",true);
		}else{
			$("#btn-profile").prop("disabled",false);
		}
	
	});
	/* 프로필 이미지 미리보기 */
	function setImageFromFile(input, id) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$(id).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	/* 기본 프로필 사용 */
	function useDefaultProfileImg() {
		$("#preview").attr('src',"${path }/profile?member_id=${user.member_id}&img_nm=default_profile.png");
		
		if("${user.member_profile_img_nm}" == 'default_profile.png'){
			$("#btn-profile").prop("disabled",true);
		}else{
			$("#profile_select").data("img", "default_profile.png");
			$("#btn-profile").prop("disabled",false);
		}
		
	}
	/* 값변경시 이벤트 */
	function changeCheck(id, curVal, error, btn) {
		var val = id.val().trim();
		if (val == curVal) {
			btn.prop('disabled', true);
		} else {
			btn.prop('disabled', false);
		}
		// nullCheck
		if(error != 'noop'){
			isNull(id,error);
		}
	}
	/* 이메일 변경시 이벤트 */
	$("#member_email").on("change input",function(){
		var email = $(this).val().trim();
		var emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var eExpCheck = $("#email-check");
		var eNullCheck = $("#email-check-null");
		var dupleCheck = $("#email-check-duple");
		var check = $("#email-btn").data("check");
		isNull($(this),eNullCheck);
		
		if($(this).val() == '${user.member_email}'){
			$("#email-btn").prop("disabled",true);
			dupleCheck.css("display","none");
			eExpCheck.css("display","none");
			$("#email-check-no").css("display","none");
			$("#email-check-ok").css("display","none");
			return false;
		}else{
			$("#email-btn").prop("disabled",false);
		}
		
		if(check){
			$("#email-btn").data("check","false");
			dupleCheck.css("display","block");
			$(this).css("background","var(--accent-color)").focus();
		}else{
			dupleCheck.css("display","none");
			$(this).css("background","");
		}
		if(emailExp.test(email)){
			eExpCheck.css("display","none");
			$(this).css("background","");
		}else{
			eExpCheck.css("display","block");
			$(this).css("background","var(--accent-color)").focus();
		}
	});
	/* 전화번호 변경시 이벤트 */
	$("#member_phoneNO").on("change input",function(){
		var phone = $(this).val().trim();
		var phoneExp = /^010-?([0-9]{4})-?([0-9]{4})$/;
		var pExpCheck = $("#phone-check");
		if(phone == '${user.member_phoneNO}'){
			pExpCheck.css("display","none");
			$(this).css("background","");
			return false;
		}else{
			if(phone == null || phone == ""){
				pExpCheck.css("display","none");
				$(this).css("background","");
				return false;
			}
		}
		if(phoneExp.test(phone)){
			pExpCheck.css("display","none");
			$(this).css("background","");
		}else{
			pExpCheck.css("display","block");
			$(this).css("background","var(--accent-color)").focus();
		}
	});
	/* 프로필 이미지 변경 */
	function changeProfileImage(){
		var img = $("#profile_select").data("img");
		$.ajax({
			url : '${path}/mypage/changeProfileImage',
			data : {"member_id" : "${user.member_id}",
					"member_profile_img_nm" : img},
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				var result = data.result;
				var msg = data.msg;
				if (result == 'true') {
					alert(msg);
					location.reload();
				} else {
					alert(msg);
				}
			}
		});
	}
	/* 이메일 중복 체크 */
	function isDuplicated(id){
		var emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var eExpCheck = $("#email-check");
		var eNullCheck = $("#email-check-null");
		var email = id.val().trim();
		var no = $("#email-check-no");
		var ok = $("#email-check-ok");
		
		if (isNull(id,eNullCheck)) {
			return false;
		}
		
		if (emailExp.test(email)) {
			eExpCheck.css("display","none");
		}else{
			eExpCheck.css("display","block");
			id.css("background","var(--accent-color)").focus();
			return false;
		}
		$.ajax({
			url : "${path}/member/emailChk",
			type : "post",
			dataType : "json",
			data : {
				"member_email" : email
			},
			success : function(data) {
				if (data > 0) {
					$("#email-btn").data("check","false");
					no.css("display","block");
					ok.css("display","none");
					id.css("background","var(--accent-color)").focus();
				} else{
					$("#email-btn").data("check","true");
					ok.css("display","block");
					no.css("display","none");
					id.css("background-color", "");
				}
			}
		})
	}

	/* 일반 정보 변경 */
	function saveInfo() {
		var nick = $("#member_nickNM");
		var nNullCheck = $("#nick-check-null");
		var content = $("#summernote").val();
		var email = $("#member_email");
		var eNullCheck = $("#email-check-null");
		/* 닉네임 , 이메일 null check */
		if (isNull(nick, nNullCheck)) {
			return false;
		} else if (isNull(email, eNullCheck)) {
			return false;
		}
		
		var emailCheck = $("#email-btn").data("check");
		var emailDuple = $("#email-check-duple");
		
		if(email.val().trim() != "${user.member_email}"){
			if(emailCheck){
				emailDuple.css("display","none");
			}else{
				emailDuple.css("display","block");
				email.css("background","var(--accent-color)");
				$("#email-btn").focus();
				return false;
			}
		}
		
		var phone = $("#member_phoneNO").val().trim();
		var pExpCheck = $("#phone-check");
		var phoneExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		if(phone != null && phone != ""){
			if(phoneExp.test(phone)){
				pExpCheck.css("display","none");
				$(this).css("background","");
			}else{
				pExpCheck.css("display","block");
				$("#member_phoneNO").css("background","var(--accent-color)").focus();
				return false;
			}
		}
		
		$.ajax({
			url : "${path}/mypage/changeInfo",
			type : "post",
			dataType : "json",
			data : {
				"member_id" : "${user.member_id}",
				"member_nickNM" : nick.val().trim(),
				"member_content" : content,
				"member_email" : email.val().trim(),
				"member_phoneNO" : phone
			},
			success : function(data) {
				var result = data.result;
				var msg = data.msg;
				if(result == 'true'){
					alert(msg);
					location.reload();
				}else{
					alert(msg);
				}
			}
		})
	}
	/* 비밀번호 변경 */
	function passwordCheck(id){
		var pwExp = /^[a-zA-Z0-9]{2,15}$/;
		var value = id.val().trim();
		var expCheck = $("#pw-check-exp");
		
		if(value != null && value != ""){
			if(pwExp.test(value)){
				expCheck.css("display","none");
				id.css("background","");
			}else{
				expCheck.css("display","block");
				id.css("background","var(--accent-color)").focus();
			}
		}else{
			expCheck.css("display","none");
			id.css("background","");
		}
		
	}
	
	function changePassword(){
		var val1 = $("#member_password");
		var val2 = $("#new_password");
		var val3 = $("#new_password_check");
		
		var error = $("#pw-check-null");
		var isEqual = $("#pw-check-new");
		var currEqual = $("#pw-check-curr");
		
		if(isNull(val1,error) || isNull(val2,error) || isNull(val3,error)){
			return false;
		}
		
		if(val2.val().trim() == val3.val().trim()){
			isEqual.css("display","none");
		}else{
			isEqual.css("display","block");
			return false;
		}
		
		$.ajax({
			url : "${path}/mypage/changePassword",
			type : "post",
			dataType : "json",
			data : { "member_id" : "${user.member_id}",
					"member_password" : val1.val().trim(),
					"new_password" : val2.val().trim(),
					"check_password" : val3.val().trim()
					},
			success : function(data){
					var result = data.result;
					var msg = data.msg;
					var changeCheck = data.newCheck;
					var curCheck = data.curCheck;
					
					if(result == 'true'){
						alert(msg);
						location.reload();
					}else{
						if(changeCheck == 'false'){
							isEqual.css("display","block");
							val3.val("");
							val2.val("").focus();
							return false;
						}
						if(curCheck == 'false'){
							currEqual.css("display","block");
							val1.val("").focus();
							return false;
						}
						alert(msg);
					}
			}
		})
		
	}

	/* null check */
	function isNull(id, error) {
		var val = id.val().trim();
		if (val == null || val == "") {
			error.css("display", "block");
			id.css("background","var(--accent-color)").focus();
			return true;
		} else {
			error.css("display", "none");
			id.css("background","");
			return false;
		}
	}
</script>

<%@ include file="../common/footer.jsp" %>