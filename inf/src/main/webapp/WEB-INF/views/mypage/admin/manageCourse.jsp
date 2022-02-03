<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#admin-course .tab {
	display: flex;
	flex-wrap: wrap;
}

#admin-course .tab button {
	margin: 0 0.5em;
	width: max-content;
}

#admin-course .tab>div {
	width: max-content;
	margin: auto;
}
#admin-course .flex-item{
	display: flex;
	flex-wrap: wrap;
}

#admin-course .flex-wrap {
	display: flex;
	flex-wrap: wrap;
}

#admin-course .flex-wrap * {
	padding: 0.2em;
}

#admin-course .validate {
	display: none;
	color: var(--accent-color);
	font-weight: bold;
	color: var(--accent-color);
}

#admin-course .apply-wrapper>div {
	padding: 0.5em 0;
}

#admin-course .method-check {
	display: none;
}
</style>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<div id="mypage-wrapper">
	<%@ include file="../../common/aside_admin.jsp"%>
	<section id="mypage-content">
		<div id="admin-course">
			<div class="tab">
				<div>
					<button class="btn btn-outline-primary tablinks"
						onclick="openTab(event, 'c-able')">판매 진행 강의</button>
					<button class="btn btn-outline-primary tablinks"
					onclick="openTab(event, 'c-enable')">판매 중지 강의</button>
				</div>
				<div>
					<button class="btn btn-warning tablinks"
						onclick="openTab(event, 'c-await')">승인 대기중인 강의</button>
				</div>
			</div>
			
			<div id="c-await" class="tabcontent">
				<h5 class="p-3">강의 (승인 대기 중)</h5>
				<div class="c-await-list">
					<c:choose>
						<c:when test="${awaitCourse != null}">
							<c:forEach var="i" items="${awaitCourse }">
								<div class="flex-item">
									<div class="course-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}"
											style="width: 300px;height:200px;object-fit:cover;border:none;border-radius: 1em;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="course_list_content_container">
										<div>
										<!-- 카테고리 --> <span
											class="course_category gray-font"> 
											<c:forEach items="${i.ct_list }" var="ct">
										${ct.category_nm }
											</c:forEach>
										</span> 
										</div>
										<!-- title --> 
										<strong class="course_title">${i.course_NM }
										<span class="badge bg-secondary levelbadge">${i.course_level }</span>
										</strong> <!-- tags -->

											<div class="tags">
												<c:forEach items="${i.skill_list }" var="skill">
													<span class="badge rounded-pill bg-success">${skill.skill_nm }</span>
												</c:forEach>
											</div> 
										<!-- 가격 -->
										<div class="course_price">

											<div class="product_amount">
												<c:choose>
													<c:when test="${i.course_sales_price > 0}">
														<span> <!-- 정상가 --> <del>${i.course_price}</del> <!-- 할인가 -->
															<span class="pay_price dark-font">${i.course_sales_price }</span>
														</span>
													</c:when>
													<c:when test="${i.course_price == 0}">
														<p>무료</p>
													</c:when>
													<c:otherwise>
														<span class="pay_price dark-font">${i.course_price }</span>
													</c:otherwise>
												</c:choose>
											</div>
											
										</div>
									</div>
									</div>
									<div class="approve_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-warning" onclick="approveCourse(${i.course_seq})">강의 승인</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>승인 대기 중인 강의가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div id="c-able" class="tabcontent">
				<h5 class="p-3">강의 (판매 진행)</h5>
				<div class="c-able-list">
					<c:choose>
						<c:when test="${ableCourse != null}">
							<c:forEach var="i" items="${ableCourse }">
								<div class="flex-item">
									<div class="course-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}"
											style="width: 300px;height:200px;object-fit:cover;border:none;border-radius: 1em;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="course_list_content_container">
										<div>
										<!-- 카테고리 --> <span
											class="course_category gray-font"> 
											<c:forEach items="${i.ct_list }" var="ct">
										${ct.category_nm }
											</c:forEach>
										</span> 
										</div>
										<!-- title --> 
										<strong class="course_title">${i.course_NM }
										<span class="badge bg-secondary levelbadge">${i.course_level }</span>
										</strong> <!-- tags -->

											<div class="tags">
												<c:forEach items="${i.skill_list }" var="skill">
													<span class="badge rounded-pill bg-success">${skill.skill_nm }</span>
												</c:forEach>
											</div> 
										<!-- 가격 -->
										<div class="course_price">

											<div class="product_amount">
												<c:choose>
													<c:when test="${i.course_sales_price > 0}">
														<span> <!-- 정상가 --> <del>${i.course_price}</del> <!-- 할인가 -->
															<span class="pay_price dark-font">${i.course_sales_price }</span>
														</span>
													</c:when>
													<c:when test="${i.course_price == 0}">
														<p>무료</p>
													</c:when>
													<c:otherwise>
														<span class="pay_price dark-font">${i.course_price }</span>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
									</div>
									<div class="stop_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-danger" onclick="stopCourse(${i.course_seq})">판매 중지</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>판매 중인 강의가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<div id="c-enable" class="tabcontent">
				<h5 class="p-3">강의 (판매 중지)</h5>
				<div class="c-enable-list">
					<c:choose>
						<c:when test="${enableCourse != null}">
							<c:forEach var="i" items="${enableCourse }">
								<div class="flex-item">
									<div class="course-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}"
											style="width: 300px;height:200px;object-fit:cover;border:none;border-radius: 1em;">
									</div>
									<!-- content 시작 -->
									<div style="padding-left: 1em;margin: auto 0;">
									<div class="course_list_content_container">
										<div>
										<!-- 카테고리 --> <span
											class="course_category gray-font"> 
											<c:forEach items="${i.ct_list }" var="ct">
										${ct.category_nm }
											</c:forEach>
										</span> 
										</div>
										<!-- title --> 
										<strong class="course_title">${i.course_NM }
										<span class="badge bg-secondary levelbadge">${i.course_level }</span>
										</strong> <!-- tags -->

											<div class="tags">
												<c:forEach items="${i.skill_list }" var="skill">
													<span class="badge rounded-pill bg-success">${skill.skill_nm }</span>
												</c:forEach>
											</div> 
										<!-- 가격 -->
										<div class="course_price">

											<div class="product_amount">
												<c:choose>
													<c:when test="${i.course_sales_price > 0}">
														<span> <!-- 정상가 --> <del>${i.course_price}</del> <!-- 할인가 -->
															<span class="pay_price dark-font">${i.course_sales_price }</span>
														</span>
													</c:when>
													<c:when test="${i.course_price == 0}">
														<p>무료</p>
													</c:when>
													<c:otherwise>
														<span class="pay_price dark-font">${i.course_price }</span>
													</c:otherwise>
												</c:choose>
											</div>
											
										</div>
									</div>
									</div>
									<div class="restart_btn_container" style="padding-left: 1em;margin: auto 0;">
												<button type="button" class="btn btn-info white-font" onclick="restartCourse(${i.course_seq})">판매 진행하기</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>판매 중지된 강의가 없습니다.</h6>
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
			openTab(event, 'c-able');
		}else if("${stopped }"){
			openTab(event, 'c-enable');
		}else{
		openTab(event, 'c-await');
		}
	});
	
	function approveCourse(seq){
		$.ajax({
			url : "${path}/admin/approveCourse",
			type : "POST",
			dataType : "json",
			data : {"course_seq" : seq },
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
		 location.href = "${path}/admin/approvedCourse"
	}
	
	function stopCourse(seq){
		$.ajax({
			url : "${path}/admin/stopCourse",
			type : "POST",
			dataType : "json",
			data : {"course_seq" : seq },
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
		 location.href = "${path}/admin/stoppedCourse"
	}
	
	function restartCourse(seq){
		$.ajax({
			url : "${path}/admin/restartCourse",
			type : "POST",
			dataType : "json",
			data : {"course_seq" : seq },
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
		 location.href = "${path}/admin/restartedCourse"
	}
	
	function openTab(evt, cityName) {
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
		
		document.getElementById(cityName).style.display = "block";
		evt.currentTarget.className += " active";
	}
	
</script>

<%@ include file="../../common/footer.jsp"%>