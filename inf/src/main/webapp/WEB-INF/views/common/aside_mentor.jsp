<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside id="my-page-aside">
	<nav class="navbar bg-light">
		<div class="container-fluid"
			style="display: flex; flex-direction: column;">
			<ul class="navbar-nav">
				<p>학습 관리</p>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/course">강의 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="#">멘토링</a></li>
				<li class="nav-item"><a class="nav-link" href="#">작성한 게시글</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/review">작성한 수강평</a></li>
			</ul>

			<ul class="navbar-nav">
				<p>구매관리</p>
				<li class="nav-item"><a class="nav-link" href="#">위시리스트</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/order/courseHistory">강의 구매내역</a></li>
			</ul>
			<ul class="navbar-nav">
				<p>내 정보</p>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/applyMentor">지식 공유 참여</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/mypage/myInfo">정보 변경</a></li>
			</ul>
		</div>
	</nav>
</aside>