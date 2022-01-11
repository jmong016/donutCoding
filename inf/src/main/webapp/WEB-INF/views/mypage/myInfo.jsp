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
	<div>
	<h1>정보 변경</h1>
	</div>
</section>
</div>

<%@ include file="../common/footer.jsp" %>