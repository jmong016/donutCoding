<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="/resources/css/myPage.css" />
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
	<div id="apply-mentor-wrapper">
		<div class="p-3">
	<h2>지식 공유 참여</h2>
		</div>
	
	<div>
	<c:choose>
		<c:when test="${user.member_role == '멘티'}">
		
		<div class="mentor-app">
			<c:choose>
				<c:when test="${user.member_status == null || user.member_status == '신청취소'}">
					<div class="p-3">
					<h4 class="main-font" style="font-weight: bold;">나의 지식에 가치를 부여하세요</h4>
					<p>나의 지식을 나눠 사람들에게 배움의 기회를 주고, 의미있는 대가를 가져가세요.</p>
					<p>donutCoding은 지식으로 의미있는 수익과 공유가 가능한 플랫폼 입니다.</p>
					</div>
					<div class="p-3">
						<button type="button" class="btn btn-warning" onclick="applyMentor('${user.member_id}')">멘토 신청하기</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="p-3">
					<h4><strong class="main-font">${user.member_id }님</strong>의 멘토 신청이 완료되었습니다.</h4>
					<p>멘토 신청 취소를 원하신다면, 아래 버튼을 눌러주세요.</p>
					</div>
					<div class="p-3">
						<button type="button" class="btn btn-danger" onclick="cancleApply('${user.member_id}')">신청 취소하기</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		</c:when>
		<c:when test="${user.member_role == '멘토'}">
					<div class="p-3">
					<h4><strong class="main-font">${user.member_id }님</strong>의 멘토 승인이 완료되었습니다.</h4>
					<p>멘티 회원으로 전환을 원하신다면, 아래 버튼을 눌러주세요.</p>
					</div>
					<div class="p-3">
						<button type="button" class="btn btn-danger" onclick="cancleApply('${user.member_id}')">신청 취소하기</button>
					</div>
		</c:when>
		<c:when test="${user.member_role == '관리자'}">
		<div class="p-3">
		<p>관리자는 지식 공유 참여가 불가능합니다.</p>		
		</div>
		</c:when>
	</c:choose>
	</div>
	</div>
</section>
</div>

<script type="text/javascript">
	function applyMentor(id){
	 	$.ajax({
			url : "${path}/mypage/applyMentor",
			type : "POST",
			dataType : "json",
			data : {"member_id" : id},
			success : function(data){
				var result = data.result;
				if(result == 'true'){
					location.reload();
				}else{
					alert("신청 실패, 다시 시도하세요.");
				}
			}
		})
	}
	function cancleApply(id){
	 	$.ajax({
			url : "${path}/mypage/cancleApply",
			type : "POST",
			dataType : "json",
			data : {"member_id" : id},
			success : function(data){
				var result = data.result;
				if(result == 'true'){
					location.reload();
				}else{
					alert("신청 취소 실패, 다시 시도하세요.");
				}
			}
		})
	}
</script>

<%@ include file="../common/footer.jsp" %>