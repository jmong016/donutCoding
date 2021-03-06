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

<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!--===============================================================================================-->
<link href="/resources/css/logutil.css" rel="stylesheet" />
<link href="/resources/css/login.css" rel="stylesheet" />
<!--===============================================================================================-->
<link href="/resources/images/icons/favicon.ico" rel="icon" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/fonts/iconic/css/material-design-iconic-font.min.css">

</head>
<style>
#nav-cart{
	color: var(--main-color);
}
#nav-cart:hover{
	color: var(--white-color);
	background : var(--main-color);
}
</style>
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

				<!-- ??? nav-->
				<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 web-nav">
					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="${path }/courses">??????</a>
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
						href="#!">?????????</a></li>

					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="#!">????????????</a>
							<div class="dropdown-content-hover">
								<a class="dropdown-item" href="#!">??????&??????</a> <a
									class="dropdown-item" href="#!">????????????</a> <a
									class="dropdown-item" href="#!">?????????</a> <a
									class="dropdown-item" href="#!">?????????</a>
							</div>
						</div>
					</li>

					<li class="nav-item">
						<div class="dropdown-col">
							<a class="nav-link" role="button" href="#!">?????????</a>
							<div class="dropdown-content-hover">
								<a class="dropdown-item" href="${path }/review/course">?????????</a> <a
									class="dropdown-item" href="#!">????????? ??????</a> <a
									class="dropdown-item" href="#!">?????????</a> <a
									class="dropdown-item" href="#!">????????? ?????????</a> <a
									class="dropdown-item" href="#!">????????? ??????</a> <a
									class="dropdown-item" href="#!">????????? ??????</a>
							</div>
						</div>
					</li>
				</ul>
				<c:if test="${user == null}">
					<div class="header-buttons ms-auto">
						<button type="button"
							class="btn btn-outline-warning web-btn-header" onclick="location.href='${path}/mypage/applyMentor'">?????? ?????? ??????</button>
						<button type="button" class="btn btn-outline-info"
							onclick="showLoginModal()">?????????</button>
						<button type="button" class="btn btn-outline-primary"
							onclick="location.href='${path }/member/join'">????????????</button>
					</div>
				</c:if>
				<c:if test="${user != null}">
					<div class="header-buttons ms-auto" style="display: flex">
						<button type="button"
							class="btn btn-outline-warning web-btn-header" onclick="location.href='${path}/mypage/applyMentor'">?????? ?????? ??????</button>
						<div id="for-web" class="dropdown-col" style="position: relative;">
						<button id="nav-cart" type="button" role="button" class="btn" 
						onclick="location.href='${path }/order/cart'"><i class="fas fa-shopping-cart"></i></button>
						<div class="dropdown-content-hover" style="right: 0;">
									<div class="dropdown-row">
									<a class="dropdown-item" href="${path }/order/cart">????????????</a> 
									<a class="dropdown-item" href="${path }/order/wishList">???????????????</a>
								</div>
								</div>
						</div>
						<div id="for-web" class="dropdown-col" style="position: relative;">
								<c:choose>
									<c:when test="${user.member_role == '?????????' }">
									<button type="button" role="button"
									class="btn btn-outline-primary"
									onclick="location.href='${path }/admin/manageCourse'">??? ??????</button>
									<div class="dropdown-content-hover" style="right: 0;">
									<div class="dropdown-row">
									<a class="dropdown-item" href="${path }/admin/manageCourse">?????? ??????</a> 
									<a class="dropdown-item" href="${path }/admin/manageMentor">?????? ??????</a>
									<a class="dropdown-item" href="${path }/admin/manageCommunity">???????????? ??????</a>
									<a class="dropdown-item" href="${path }/admin/amount">?????? ??????</a> 
									<a class="dropdown-item" href="${path }/member/logout">????????????</a>
								</div>
								</div>
									</c:when>
									<c:otherwise>
									<button type="button" role="button"
								class="btn btn-outline-primary"
								onclick="location.href='${path }/mypage/main'">??? ??????</button>
							<div class="dropdown-content-hover" style="right: 0;">
										<div class="dropdown-row">
									<a class="dropdown-item" href="${path }/mypage/course">??? ??????</a> 
									<a class="dropdown-item" href="${path }/order/wishList">???????????????</a>
									<a class="dropdown-item" href="${path }/mypage/artilces">????????? ?????????</a> 
									<a class="dropdown-item" href="${path }/order/courseHistory">????????????</a> 
									<a class="dropdown-item" href="${path }/member/logout">????????????</a>
								</div>
								</div>
									</c:otherwise>
								</c:choose>
						</div>
						<div id="for-mobile" class="dropdown-col dropdown dropdown-menu-end">
						<button type="button" role="button"
								class="btn btn-outline-primary"  data-bs-toggle="dropdown"
								ondblclick="location.href='${path }/mypage/main'">??? ??????</button>
								<ul class="dropdown-menu" style="right: 0;left: unset;">
									<li><a class="dropdown-item" href="${path }/mypage/course">???
										??????</a></li>
									<li><a class="dropdown-item" href="${path }/order/wishList">???????????????</a></li>
									<li><a class="dropdown-item" href="${path }/mypage/artilces">?????????
										?????????</a></li>
									<li><a class="dropdown-item"
										href="${path }/order/courseHistory">????????????</a></li>
									<li><a class="dropdown-item" href="${path }/member/logout">????????????</a></li>
								</ul>
							</div>
					</div>
				</c:if>

			</div>
		</nav>
	</div>

	<!-- ????????? nav -->
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
				<a href="${path }/courses">??????</a>
			</div>
			<div class="bottom-item">
				<a href="#!">?????????</a>
			</div>
			<div class="bottom-item">
				<a href="${path }/main">???</a>
			</div>
			<div class="bottom-item">
				<a href="#!">?????????</a>
			</div>
			<div class="bottom-item">
				<div class="dropup">
					<a href="#" data-bs-toggle="dropdown">?????????</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">?????? ?????????</a></li>
						<li><a class="dropdown-item" href="#">?????????</a></li>
						<li><a class="dropdown-item" href="#">????????? ??????</a></li>
						<li><a class="dropdown-item" href="#">????????? ??????</a></li>
						<li><a class="dropdown-item" href="#">?????????</a></li>
						<li><a class="dropdown-item" href="#">?????? ?????? ??????</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- ????????? -->
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
							<span class="txt1"> ??????????????? ???????????????? </span> <a class="txt2"
								href="#!" style="font-weight: bold;"> Find Password </a>
						</div>
						<div class="text-center pt5">
							<span class="txt1"> ??????????????????????????????? </span> <a class="txt2"
								href="${path }/member/join" style="font-weight: bold;"> Sign
								Up </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		/* ????????? ?????? ????????? ??? ajax??? ?????? ????????? ???????????? */
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
		/* id, pw null ?????? */
		$("#login_id").on("focusout", function() {
			var id = $(this).val().trim();
			if (id == "" || id == null) {
				$("#id_null").attr("data-placeholder", "ID??? ???????????????");
				$("#login_id").focus();
			} else {
				$("#id_null").attr("data-placeholder", "ID");
			}
		});
		$("#login_password").on("focusout", function() {
			var id = $(this).val().trim();
			if (id == "" || id == null) {
				$("#pw_null").attr("data-placeholder", "??????????????? ???????????????");
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
				error.text("????????? ?????? ?????? ????????? ???????????????.");
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