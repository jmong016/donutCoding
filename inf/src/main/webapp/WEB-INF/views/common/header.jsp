<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DonutCoding</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;600&display=swap"
	rel="stylesheet">
<link href="/resources/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="/resources/css/responsive.css" rel="stylesheet" />
<link href="/resources/css/root.css" rel="stylesheet" />


<!--===============================================================================================-->
<link href="/resources/css/logutil.css" rel="stylesheet" />
<link href="/resources/css/login.css" rel="stylesheet" />
<!--===============================================================================================-->
<link href="/resources/images/icons/favicon.ico" rel="icon" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/fonts/iconic/css/material-design-iconic-font.min.css">

</head>
<c:set var="path" value="<%=request.getContextPath()%>" />

<body class="sb-nav-fixed">
	<div class="container">

		<nav class="sb-topnav navbar navbar-expand header-nav"
			style="background-color: white; box-shadow: 1px 1px 3px #ddd;">
			<!-- Sidebar Toggle-->
			<button class="btn btn-link btn-sm" id="sidebarToggle">
				<i class="fas fa-bars dark-font"></i>
			</button>

			<div class="container-xl">
				<!-- Navbar Logo-->
				<a class="navbar-brand ps-3" href="${path }/main">DonutCoding</a>

				<!-- 웹 nav-->
				<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 web-nav">
					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="${path }/courses">강의</a>
							<div class="dropdown-content-hover">
								<c:forEach items="${ctMap }" var="ct">
									<div class="dropdown-row">
										<a class="dropdown-item"
											href="${path }/courses/${ct.category_seq}">${ct.category_nm }</a>
										<div class="dropdown-content-hover-row">
											<a class="dropdown-item"
												href="${path }/courses/${ct.category_seq}"><strong>ALL</strong></a>
											<c:forEach items="${ct.skill_list }" var="sk">
												<a class="dropdown-item"
													href="${path }/courses/${ct.category_seq}/${sk.skill_seq}">${sk.skill_nm }</a>
											</c:forEach>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</li>

					<li class="nav-item"><a class="nav-link" role="button"
						href="#!">멘토링</a></li>

					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="#!">커뮤니티</a>
							<div class="dropdown-content-hover">
								<a class="dropdown-item" href="#!">질문&답변</a> <a
									class="dropdown-item" href="#!">자유주제</a> <a
									class="dropdown-item" href="#!">스터디</a> <a
									class="dropdown-item" href="#!">블로그</a>
							</div>
						</div>
					</li>

					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="#!">인프런</a>
							<div class="dropdown-content-hover">
								<a class="dropdown-item" href="#!">수강평</a> <a
									class="dropdown-item" href="#!">멘토링 후기</a> <a
									class="dropdown-item" href="#!">스터디</a> <a
									class="dropdown-item" href="#!">인프런 이야기</a> <a
									class="dropdown-item" href="#!">인프런 채용</a> <a
									class="dropdown-item" href="#!">인프런 소개</a>
							</div>
						</div>
					</li>
				</ul>
				<c:if test="${user == null}">
					<div class="header-buttons ms-auto">
						<button type="button"
							class="btn btn-outline-warning web-btn-header">지식 공유 참여</button>
						<button type="button" class="btn btn-outline-info"
							onclick="showLoginModal()">로그인</button>
						<button type="button" class="btn btn-outline-primary"
							onclick="location.href='${path }/member/join'">회원가입</button>
					</div>
				</c:if>
				<c:if test="${user != null}">
					<div class="header-buttons ms-auto" style="display: flex">
						<button type="button"
							class="btn btn-outline-warning web-btn-header">지식 공유 참여</button>
						<div id="for-web" class="dropdown-col" style="position: relative;">
							<button type="button" role="button"
								class="btn btn-outline-primary"
								onclick="location.href='${path }/mypage/main'">내 정보</button>
							<div class="dropdown-content-hover" style="right: 0;">
								<div class="dropdown-row">
									<a class="dropdown-item" href="${path }/mypage/myCourse">내
										학습</a> <a class="dropdown-item" href="${path }/mypage/myCart">장바구니</a>
									<a class="dropdown-item" href="${path }/mypage/myWishList">위시리스트</a>
									<a class="dropdown-item" href="${path }/mypage/myArtilces">작성한
										게시글</a> <a class="dropdown-item"
										href="${path }/mypage/myPurchaseHistory">구매내역</a> <a
										class="dropdown-item" href="${path }/member/logout">로그아웃</a>
								</div>
							</div>
						</div>
						<div id="for-mobile" class="dropdown-col dropdown dropdown-menu-end">
						<button type="button" role="button"
								class="btn btn-outline-primary"  data-bs-toggle="dropdown"
								ondblclick="location.href='${path }/mypage/main'">내 정보</button>
								<ul class="dropdown-menu" style="right: 0;left: unset;">
									<li><a class="dropdown-item" href="${path }/mypage/myCourse">내
										학습</a></li>
									<li><a class="dropdown-item" href="${path }/mypage/myCart">장바구니</a></li>
									<li><a class="dropdown-item" href="${path }/mypage/myWishList">위시리스트</a></li>
									<li><a class="dropdown-item" href="${path }/mypage/myArtilces">작성한
										게시글</a></li>
									<li><a class="dropdown-item"
										href="${path }/mypage/myPurchaseHistory">구매내역</a></li>
									<li><a class="dropdown-item" href="${path }/member/logout">로그아웃</a></li>
								</ul>
							</div>
					</div>
				</c:if>

			</div>
		</nav>
	</div>

	<!-- 모바일 nav -->
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-light"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">
							<i class="fas fa-book-open"></i>
						</div>
						<c:forEach items="${ctMap }" var="ct" varStatus="vs">
							<a class="nav-link collapsed"
								href="${path }/courses/${ct.category_seq}"
								data-bs-toggle="collapse" data-bs-target="#collapse${vs.count }"
								aria-expanded="false" aria-controls="collapseLayouts">
								<div class="sb-nav-link-icon">
									<i class="fas fa-columns"></i>
								</div> ${ct.category_nm }
								<div class="sb-sidenav-collapse-arrow">
									<i class="fas fa-angle-down"></i>
								</div>
							</a>
							<div class="collapse" id="collapse${vs.count }"
								aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
								<nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link" href="${path }/courses/${ct.category_seq}"><strong>ALL</strong></a>
									<c:forEach items="${ct.skill_list }" var="sk">
										<a class="nav-link"
											href="${path }/courses/${ct.category_seq}/${sk.skill_seq}">${sk.skill_nm }</a>
									</c:forEach>
								</nav>
							</div>
						</c:forEach>


					</div>
				</div>
			</nav>
		</div>
	</div>

	<div class="navbar-bottom">
		<div class="container-fluid">
			<div class="bottom-item">
				<a href="${path }/courses">강의</a>
			</div>
			<div class="bottom-item">
				<a href="#!">멘토링</a>
			</div>
			<div class="bottom-item">
				<a href="${path }/main">홈</a>
			</div>
			<div class="bottom-item">
				<a href="#!">블로그</a>
			</div>
			<div class="bottom-item">
				<div class="dropup">
					<a href="#" data-bs-toggle="dropdown">더보기</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">질문 게시판</a></li>
						<li><a class="dropdown-item" href="#">수강평</a></li>
						<li><a class="dropdown-item" href="#">멘토링 후기</a></li>
						<li><a class="dropdown-item" href="#">멘토링 후기</a></li>
						<li><a class="dropdown-item" href="#">스터디</a></li>
						<li><a class="dropdown-item" href="#">지식 공유 참여</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 로그인 -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body">
					<div class="wrap-login100" style="padding: 0 55px 55px 55px;">
						<span class="login100-form-title p-b-26"> LOGIN </span> <span
							class="login100-form-title p-b-48"> <i
							class="zmdi zmdi-font"></i>
						</span>

						<div class="wrap-input100 validate-input"
							data-validate="Enter password">
							<input id="login_id" class="input100" type="text"
								name="member_id" style="margin: 0"> <span id="id_null"
								class="focus-input100" data-placeholder="ID"></span>
						</div>
						<div class="wrap-input100 validate-input"
							data-validate="Enter password">
							<span class="btn-show-pass"> <i class="zmdi zmdi-eye"></i>
							</span> <input id="login_password" class="input100" type="password"
								name="member_password" style="margin: 0"> <span
								id="pw_null" class="focus-input100" data-placeholder="Password"></span>
						</div>

						<div class="container-login100-form-btn">
							<div class="wrap-login100-form-btn">
								<div class="login100-form-bgbtn"></div>
								<button id="login_submit" class="login100-form-btn">Login</button>
							</div>
						</div>
						<h6 id="login_error"
							style="width: 100%; margin: auto; text-align: center; margin-top: 1em; color: var(- -main-color); font-weight: bold; border-bottom: 0.5em solid var(- -main-color); display: none;"></h6>
						<div class="text-center pt5">
							<span class="txt1"> 비밀번호를 잊으셨나요? </span> <a class="txt2"
								href="#!" style="font-weight: bold;"> Find Password </a>
						</div>
						<div class="text-center pt5">
							<span class="txt1"> 회원가입하시겠습니까? </span> <a class="txt2"
								href="${path }/member/join" style="font-weight: bold;"> Sign
								Up </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		/* 로그인 버튼 눌렀을 때 ajax를 통해 모달창 보여주기 */
		function showLoginModal() {
			$.ajax({
				url : "${path}/member/login",
				type : "GET",
				success : function(data) {
					if (data != null) {
						$('#myModal').modal("show");
					}
				}
			})
		}
		/* id, pw null 방지 */
		$("#login_id").on("focusout", function() {
			var id = $(this).val().trim();
			if (id == "" || id == null) {
				$("#id_null").attr("data-placeholder", "ID를 입력하세요");
				$("#login_id").focus();
			} else {
				$("#id_null").attr("data-placeholder", "ID");
			}
		});
		$("#login_password").on("focusout", function() {
			var id = $(this).val().trim();
			if (id == "" || id == null) {
				$("#pw_null").attr("data-placeholder", "비밀번호를 입력하세요");
				$("#login_password").focus();
			} else {
				$("#pw_null").attr("data-placeholder", "Password");
			}
		});
		$("#login_submit").on("click", function() {
			var id = $("#login_id").val().trim();
			var pw = $("#login_password").val().trim();
			var error = $("#login_error");
			var prePath = document.referrer;
			var currPath = document.location.href;
			if (id == "" || id == null || pw == "" || pw == null) {
				error.css("display", "block");
				error.text("아이디 혹은 비밀 번호를 입력하세요.");
				return false;
			} else {
				error.css("display", "none");
				var id = $("#login_id").val().trim();
				var pw = $("#login_password").val().trim();
				$.ajax({
					url : "${path}/member/login",
					type : "POST",
					dataType : "json",
					data : {
						"member_id" : id,
						"member_password" : pw
					},
					success : function(data) {
						var msg = data.msg;
						var result = data.result;
						var path = data.path;
						var referer = "${referer}";
						if (result == null) {
							error.css("display", "block");
							error.text(msg);
							$("#login_id").val("");
							$("#login_password").val("");
							$("#login_id").focus();
						} else {
							error.css("display", "none");
							$('#myModal').modal("hide");
							location.reload();
						}
						if (path == "http://localhost:8080/member/join") {
							location.href = "${path}/main";
						}
						if(referer != null || referer != ""){
							location.href = "${path}"+referer;
						}
					}
				})
			}
		});
	</script>
	<script src="/resources/js/login.js"></script>
	<div id="layoutSidenav_content">
		<main>