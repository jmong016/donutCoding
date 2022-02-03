<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#manage-mentor .tab {
	display: flex;
	flex-wrap: wrap;
}

#manage-mentor .tab button {
	margin: 0 0.5em;
	width: max-content;
}

#manage-mentor .tab>div {
	width: max-content;
	margin: auto;
}
#manage-mentor .flex-item{
	display: flex;
	flex-wrap: wrap;
}

#manage-mentor .flex-wrap {
	display: flex;
	flex-wrap: wrap;
}

#manage-mentor .flex-wrap * {
	padding: 0.2em;
}

#manage-mentor .validate {
	display: none;
	color: var(--accent-color);
	font-weight: bold;
	color: var(--accent-color);
}

#manage-mentor .apply-wrapper>div {
	padding: 0.5em 0;
}

#manage-mentor .method-check {
	display: none;
}
</style>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<div id="mypage-wrapper">
	<%@ include file="../../common/aside_admin.jsp"%>
	<section id="mypage-content">
		<div id="manage-mentor">
			<div class="tab">
				<div>
					<button class="btn btn-outline-primary tablinks"
						onclick="openTab(event, 'c-mentor')">멘토(승인 완료)</button>
					<button class="btn btn-outline-primary tablinks"
						onclick="openTab(event, 'c-stop')">멘토(자격 정지)</button>
				</div>
				<div>
					<button class="btn btn-warning tablinks"
						onclick="openTab(event, 'c-await')">승인 대기중인 회원</button>
				</div>
			</div>
			
			<div id="c-await" class="tabcontent">
				<h5 class="p-3">회원 (멘토 승인 대기 중)</h5>
				<div class="c-await-list">
					<c:choose>
						<c:when test="${awaitMember != null}">
							<c:forEach var="i" items="${awaitMember }">
								<div class="flex-item p-3">
									<div class="member-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/profile?member_id=${i.member_id}&img_nm=${i.member_profile_img_nm}"
											style="max-width: 150px;max-height:150px;border-radius: 50%;border:none;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="member_list_content_container flex-item">
										<div class="p-2">
										아이디 : <strong>${i.member_id }</strong>
										</div>
										<div class="p-2">
										이메일 : <strong>${i.member_email }</strong>
										</div>
										<div class="p-2" >
										전화번호 : <strong>${i.member_phoneNO}</strong>
										</div>
										<div class="p-2">
										승인 신청일 : <strong>${i.member_applyDT }</strong>
										</div>
									</div>
									</div>
									<div class="approve_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-warning" onclick="approveMentor('${i.member_id}')">멘토 승인</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>멘토 승인 대기중인 회원이 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div id="c-mentor" class="tabcontent">
				<h5 class="p-3">멘토 (승인 완료)</h5>
				<div class="c-mentor-list">
					<c:choose>
						<c:when test="${approvedMentor != null}">
							<c:forEach var="i" items="${approvedMentor }">
									<div class="flex-item p-3">
									<div class="member-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/profile?member_id=${i.member_id}&img_nm=${i.member_profile_img_nm}"
											style="max-width: 150px;max-height:150px;border-radius: 50%;border:none;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="member_list_content_container flex-item">
										<div class="p-2">
										아이디 : <strong>${i.member_id }</strong>
										</div>
										<div class="p-2">
										이메일 : <strong>${i.member_email }</strong>
										</div>
										<div class="p-2" >
										전화번호 : <strong>${i.member_phoneNO}</strong>
										</div>
										<div class="p-2">
										승인 완료일 : <strong>${i.member_approveDT }</strong>
										</div>
									</div>
									</div>
									<div class="stop_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-danger" onclick="stopMentor('${i.member_id}')">자격 정지</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>승인 완료된 멘토가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<div id="c-stop" class="tabcontent">
				<h5 class="p-3">멘토 (자격정지)</h5>
				<div class="c-stop-list">
					<c:choose>
						<c:when test="${stopMentor != null}">
							<c:forEach var="i" items="${stopMentor }">
								<div class="flex-item p-3">
									<div class="member-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/profile?member_id=${i.member_id}&img_nm=${i.member_profile_img_nm}"
											style="max-width: 150px;max-height:150px;border-radius: 50%;border:none;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="member_list_content_container flex-item">
										<div class="p-2">
										아이디 : <strong>${i.member_id }</strong>
										</div>
										<div class="p-2">
										이메일 : <strong>${i.member_email }</strong>
										</div>
										<div class="p-2" >
										전화번호 : <strong>${i.member_phoneNO}</strong>
										</div>
										<div class="p-2">
										자격 정지일 : <strong>${i.member_stopDT }</strong>
										</div>
									</div>
									</div>
									<div class="restart_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-info white-font" onclick="restartMentor('${i.member_id}')">자격 복귀</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>자격 정지된 멘토가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</section>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		if("${approved }" || "${restarted}" ){
			openTab(event, 'c-mentor');
		}else if("${stopped }"){
			openTab(event, 'c-stop');
		}else{
		openTab(event, 'c-await');
		}
	});
	
	function approveMentor(id){
		$.ajax({
			url : "${path}/admin/approveMentor",
			type : "POST",
			dataType : "json",
			data : {"member_id" : id },
			success : function(data) {
				var result = data.result;
				var msg = data.msg;
				if(result == 'true'){
					alert(msg);
					showApprovedList();
				}else{
					alert(msg);
				}
			}
		})
	}
	
	function showApprovedList(){
		 location.href = "${path}/admin/approvedMentor"
	}
	
	function stopMentor(id){
		$.ajax({
			url : "${path}/admin/stopMentor",
			type : "POST",
			dataType : "json",
			data : {"member_id" : id },
			success : function(data) {
				var result = data.result;
				var msg = data.msg;
				if(result == 'true'){
					alert(msg);
					showStoppedList();
				}else{
					alert(msg);
				}
			}
		})
	}
	
	function showStoppedList(){
		 location.href = "${path}/admin/stoppedMentor"
	}
	
	function restartMentor(id){
		$.ajax({
			url : "${path}/admin/restartMentor",
			type : "POST",
			dataType : "json",
			data : {"member_id" : id},
			success : function(data) {
				var result = data.result;
				var msg = data.msg;
				if(result == 'true'){
					alert(msg);
					showRestartedList();
				}else{
					alert(msg);
				}
			}
		})
	}
	
	function showRestartedList(){
		 location.href = "${path}/admin/restartedMentor"
	}
	
	function openTab(evt, tabName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		
		document.getElementById(tabName).style.display = "block";
		evt.currentTarget.className += " active";
	}
	
</script>

<%@ include file="../../common/footer.jsp"%>