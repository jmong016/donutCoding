<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside id="my-page-aside">
	<nav class="navbar bg-light">
		<div class="container-fluid"
			style="display: flex; flex-direction: column;">
			<ul class="navbar-nav">
				<p>관리</p>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/myCourse">강의 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="#">강의 승인</a></li>
				<li class="nav-item"><a class="nav-link" href="#">강사 승인</a></li>
				<li class="nav-item"><a class="nav-link" href="#">커뮤니티 관리</a></li>
			</ul>

			<ul class="navbar-nav">
				<p>구매관리</p>
				<li class="nav-item"><a class="nav-link" href="#">정산 내역</a></li>
			</ul>
			<ul class="navbar-nav">
				<p>설정</p>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/myInfo">정보 변경</a></li>
			</ul>
		</div>
	</nav>
</aside>