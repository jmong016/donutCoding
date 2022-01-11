<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#mento-course .tab {
	display: flex;
	flex-wrap: wrap;
}

#mento-course .tab button {
	margin: 0 0.5em;
	width: max-content;
}

#mento-course .tab>div {
	width: max-content;
	margin: auto;
}
#mento-course .flex-item{
	display: flex;
	flex-wrap: wrap;
}

#mento-course .flex-wrap {
	display: flex;
	flex-wrap: wrap;
}

#mento-course .flex-wrap * {
	padding: 0.2em;
}

#mento-course .validate {
	display: none;
	color: var(--accent-color);
	font-weight: bold;
	color: var(--accent-color);
}

#mento-course .apply-wrapper>div {
	padding: 0.5em 0;
}

#mento-course .method-check {
	display: none;
}
</style>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<div id="mypage-wrapper">
	<%@ include file="../../common/aside_mentor.jsp"%>
	<section id="mypage-content">
		<div id="mento-course">
			<div class="tab">
				<div>
					<button class="btn btn-outline-primary tablinks"
						onclick="openTab(event, 'c-await')">대기중인 강의</button>
					<button class="btn btn-outline-primary tablinks"
						onclick="openTab(event, 'c-cancle')">취소한 강의</button>
				</div>
				<div>
					<button class="btn btn-warning tablinks"
						onclick="openTab(event, 'c-apply')">강의 등록하기</button>
				</div>
			</div>

			<div id="c-apply" class="tabcontent">
				<h5 style="padding: 1em 0; font-weight: bold;">강의 등록 신청</h5>
				<!-- 강의 등록 구현 -->

				<div class="apply-wrapper">
					<!-- 카테고리 선택 -->
					<div class="ct-app">
						<p id="ct-check" class="validate">카테고리는 최대 3개까지 등록 가능합니다.</p>
						<p id="ct-check-null" class="validate">카테고리를 선택하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>카테고리</strong>
								</h6>
							</div>
							<select id="ct_list" name="ct_list">
								<option value="" disabled="disabled" hidden=""
									selected="selected">카테고리</option>
								<c:forEach items="${ctMap }" var="ct">
									<option value="${ct.category_seq }" label="${ct.category_nm }">
								</c:forEach>
							</select>
							<div id="ct_selected"></div>
						</div>
					</div>
					<!-- 스킬 추가 -->
					<div class="sk-app">
						<p id="sk-check" class="validate">스킬은 최대 3개까지 등록 가능합니다.</p>
						<p id="sk-check-null" class="validate">기술명을 추가하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>기술</strong>
								</h6>
							</div>
							<input id="sk_select" type="text" name="skill_nm" size="30"
								placeholder="기술명">
							<button id="sk_add" type="button" class="btn btn-primary">추가</button>
							<div id="sk_selected"></div>
						</div>
					</div>
					<!-- 난이도 선택 -->
					<div class="level-app">
						<p id="level-check" class="validate"></p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>난이도</strong>
								</h6>
							</div>
							<input id="level-1" type="radio" name="course_level" value="입문" checked> 
							<label for="level-1">입문</label> <input
								id="level-2" type="radio" value="초급" name="course_level">
							<label for="level-2">초급</label> <input id="level-3" type="radio"
								value="중급이상" name="course_level"> <label for="level-3">중급이상</label>
							<div id="sk_selected"></div>
						</div>
					</div>
					<!-- 수강 기간 제한 여부 -->
					<div class="limit-app">
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>수강 기간 제한 여부</strong>
								</h6>
							</div>
							<div>
								<button id="unlimited" type="button" class="btn btn-outline-info limit-btn"
									data-check="N" value="false" >무제한 수강</button>
							</div>
							<div>
								<button id="limited" type="button"
									class="btn btn-outline-warning limit-btn" data-check="N" value="true">수강 기간 제한</button>
							</div>
						</div>
					</div>
					<!-- 수강 기간 설정 -->
					<div class="limit-period-app">
						<p id="limit-check-null" class="validate">수강 제한 기간을 선택하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>수강 기간</strong>
								</h6>
							</div>
							<p id="limit-method-check" style="color: red;">
								<strong>수강 기간 제한 여부를 선택하세요.</strong>
							</p>
							<div class="method-check method-unlimited">
								<input name="course_price" id="course_price" type="text"
									size="10" placeholder="무제한 수강" disabled="disabled"/>
							</div>
							<div class="method-check method-limited">
								<select id="limit_list" name="limit_list">
								<option value="" disabled="disabled" hidden="" selected="selected">기간 선택</option>
								<c:forEach begin="1" end="12" step="1" var="i">
									<option value="${i }" label="${i}개월">
								</c:forEach>
							</select>
							</div>
							<div class="method-check method-limited">
								<input name="coursse_available_period" id="coursse_available_period"
									disabled="disabled" type="number" placeholder="" />
							</div>
						</div>
					</div>
					<!-- 판매 방식 -->
					<div class="sale-app">
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>판매 방식</strong>
								</h6>
							</div>
							<div>
								<button id="free" type="button" class="btn btn-outline-info sale-btn"
									data-check="N" value="free" >무료 판매</button>
							</div>
							<div>
								<button id="non-sale" type="button"
									class="btn btn-outline-warning sale-btn" data-check="N" value="false">정가 판매</button>
							</div>
							<div>
								<button id="sale" type="button" class="btn btn-outline-info sale-btn"
									data-check="N" value="true" >할인 판매</button>
							</div>
						</div>
					</div>
					<!-- 판매 금액 -->
					<div class="price-app">
						<p id="price-check-null" class="validate">정가를 입력하세요.</p>
						<p id="price-check-range" class="validate">
							할인가는 <strong>정가보다 낮은 금액만</strong> 입력가능합니다.
						</p>
						<p id="cal-check" class="validate">
							할인율 계산을 위해서는 <strong>정가와 할인가를 입력</strong>하세요.
						</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>판매 금액</strong>
								</h6>
							</div>
							<p id="sales-method-check" style="color: red;">
								<strong>판매방식을 선택하세요.</strong>
							</p>
							<div class="price method-check method-free-check">
								<input name="course_price" id="course_price" type="number"
									size="10" placeholder="무료" disabled="disabled"/>
							</div>
							<div class="price method-check method-common-check">
								<input name="course_price" id="course_price" type="number"
									size="10" placeholder="정가" />
							</div>
							<div class="sales-price method-check method-sale-check">
								<input name="course_sales_price" id="course_sales_price"
									type="number" size="10" placeholder="할인가" />
							</div>
							<div class="sales-price method-check method-sale-check">
								<button id="sale-cal" type="button" class="btn btn-primary"
									data-cal="N">할인율 확인</button>
							</div>
							<div class="sales-period method-check btn-cal-check">
								<input name="course_discount_rate" id="course_discount_rate"
									disabled="disabled" type="number" placeholder="할인율" />
							</div>
						</div>
					</div>
					<!-- 대표 이미지 -->
					<div class="thumb-app">
						<p id="thumb-check-null" class="validate">대표이미지는 반드시 첨부해야합니다.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>대표 이미지</strong>
								</h6>
							</div>
							<input id="thumb_select" type="file" name="course_img_nm">
							<div id="thumb_selected"><img id="preview" style="width: 50%;object-fit:cover;"></div>
						</div>
					</div>
					<!-- 강의명 -->
					<div class="nm-app">
						<p id="nm-check" class="validate">강의명은 최대 33글자까지 입력가능합니다.</p>
						<p id="nm-check-null" class="validate">강의명을 입력하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>강의명</strong>
								</h6>
							</div>
							<input id="course_NM" type="text" maxlength="33" size="60"
								name="course_NM" placeholder="강의명">
						</div>


						<p id="null-check" class="validate">모든 정보를 입력하셔야 합니다.</p>

					</div>
					<!-- 강의소개 -->
					<div class="intro-app">
						<p id="intro-check-null" class="validate">강의 소개를 작성하세요.</p>
						<div class="flex-wrap">
							<div class="name">
								<h6>
									<strong>강의 소개</strong>
								</h6>
							</div>
						</div>
						<div class="flex-wrap">
							<textarea id="summernote" name="course_intro"></textarea>
						</div>
					</div>
				</div>
				<!-- 강의 등록 구현 END -->
				<button id="c-submit" class="btn btn-primary" type="button">강의 신청</button>
			</div>

			<div id="c-await" class="tabcontent">
				<h5>강의 (승인 대기 중)</h5>
				<div class="c-await-list">
					<c:choose>
						<c:when test="${awaitCourse != null}">
							<c:forEach var="i" items="${awaitCourse }">
								<div class="flex-item">
									<div class="course-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}">
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
													<c:when test="${i.course_sales_price != null}">
														<span> <!-- 정상가 --> <del>${i.course_price}</del> <!-- 할인가 -->
															<span class="pay_price dark-font">${i.course_sales_price }</span>
														</span>
													</c:when>
													<c:otherwise>
														<span class="pay_price dark-font">${i.course_price }</span>
													</c:otherwise>
												</c:choose>
											</div>
											
										</div>
									</div>
									</div>
									<div class="cancel_btn_container" style="padding-left: 1em;margin: auto 0;">
												<!-- 신청 취소 버튼 -->
												<button type="button" class="btn btn-danger cancel-btn" onclick="cancelCourse(${i.course_seq})">신청 취소</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>승인을 신청하신 강의가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div id="c-cancle" class="tabcontent">
				<h5>강의 (신청 취소)</h5>
				<div class="c-cancle-list">
					<c:choose>
						<c:when test="${cancleCourse != null}">
							<c:forEach var="i" items="${cancleCourse }">
								<div class="flex-item">
									<div class="course-thumbnail">
										<img class="img-thumbnail" alt="thumbnail"
											src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}">
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
													<c:when test="${i.course_sales_price != null}">
														<span> <!-- 정상가 --> <del>${i.course_price}</del> <!-- 할인가 -->
															<span class="pay_price dark-font">${i.course_sales_price }</span>
														</span>
													</c:when>
													<c:otherwise>
														<span class="pay_price dark-font">${i.course_price }</span>
													</c:otherwise>
												</c:choose>
											</div>
											
										</div>
									</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h6>신청을 취소하신 강의가 없습니다.</h6>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</section>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		
		if("${await }" != null && "${await }" != "" ){
			openTab(event, 'c-await');
		}else if("${cancle }" != null && "${cancle }" != "" ){
			openTab(event, 'c-cancle');
		}else{
		openTab(event, 'c-apply');
		}
		/* 썸머노트 */
		$('#summernote').summernote({
			placeholder : '강의 소개를 작성하세요.',
			minHeight : 400,
			maxHeight : 700,
			maxWidth : 700,
			minWidth : 320
		});
	});
	// 카테고리를 선택했을 때
	$("#ct_list").on("change",function() {
				var ct_seq = $("#ct_list option:selected").val();
				var ct_nm = $("#ct_list option:selected").attr("label");

				$("#ct_selected").append(
						$("<button type='button' onClick='ctBtnClicked("
								+ ct_seq
								+ ")' class='btn ct-choosed' data-ct-seq='"
								+ ct_seq + "'>" + ct_nm + "</button>"));

				var choosed_list = $("#ct_selected button").length;
				if (choosed_list >= 3) {
					$("#ct-check").css("display", "block");
					$(this).prop("disabled", "disabled");
					return false;
				}
				$("#sk_list").prop("disabled", "");
			});
	// 추가된 카테고리를 클릭하면 삭제
	function ctBtnClicked(ct_seq) {
		var target = $(".ct-choosed[data-ct-seq='" + ct_seq + "']");
		target.remove();
		var choosed_list = $("#ct_selected button").length;
		if (choosed_list < 3) {
			$("#ct-check").css("display", "none");
			$("#ct_list").prop("disabled", "");
			return false;
		}
	}
	// 스킬 추가
	$("#sk_add").on("click", function() {
						var input = $("#sk_select").val().trim();
						if (input == null || input == "") {
							$("#sk-check-null").css("display", "block");
							$("#sk_select").focus();
							return false;
						} else {
							$("#sk-check-null").css("display", "none");
							$("#sk_selected")
									.append(
											$("<button type='button' onClick='skBtnClicked("
													+ '"'
													+ input
													+ '"'
													+ ")' class='btn sk-choosed' data-sk-name='"
													+ input
													+ "'>"
													+ input
													+ "</button>"));
							$("#sk_select").val("");
						}
						var choosed_list = $("#sk_selected").children().length;
						if (choosed_list >= 3) {
							$("#sk-check").css("display", "block");
							$(this).prop("disabled", "disabled");
							return false;
						}
						/* TODO: 이미 있는 값 들어오면 거절하기 */
					});
	// 추가된 기술을 클릭하면 삭제
	function skBtnClicked(input) {
		var target = $(".sk-choosed[data-sk-name='" + input + "']");
		target.remove();
		var choosed_list = $("#sk_selected").children().length;
		if (choosed_list < 4) {
			$("#sk-check").css("display", "none");
			$("#sk_add").prop("disabled", "");
			return false;
		}
	}
	// 무제한 수강시
	$("#unlimited").on("click", function() {
		if ($(this).data("check") == "N") {
			$(this).data("check","Y");
			$(this).prop("disabled", true);
			$("#limit-method-check").css("display", "none");
			$(".method-unlimited").css("display", "block");
			$(".method-limited").css("display", "none");
		}
		if ($("#limited").data("check") =="Y") {
			$("#limited").data("check","N");
			$("#limited").prop("disabled", false);
		}
	});
	// 수강 제한시
	$("#limited").on("click", function() {
		if ($(this).data("check") == "N") {
			$(this).data("check","Y");
			$(this).prop("disabled", true);
			$("#limit-method-check").css("display", "none");
			$(".method-unlimited").css("display", "none");
			$(".method-limited").css("display", "block");
		}
		if ($("#unlimited").data("check") =="Y") {
			$("#unlimited").data("check","N");
			$("#unlimited").prop("disabled", false);
		}
	});
	// 제한 기간을 선택했을 때
	$("#limit_list").on("change",function() {
				var period = $("#limit_list option:selected").val();
				var label = $("#limit_list option:selected").attr("label");

				$("#coursse_available_period").attr("placeholder",label);
			});
	// 정가 판매시
	$("#non-sale").on("click", function() {
		if ($(this).data("check") == "N") {
			$(this).data("check","Y");
			$(this).prop("disabled", true);
			$(".method-free-check").css("display", "none");
			$(".method-common-check").css("display", "block");
			$("#sales-method-check").css("display", "none");
		}
		if ($("#sale").data("check") == "Y") {
			$("#sale").data("check","N");
			$(".method-sale-check").css("display", "none");
			$("#sale").prop("disabled", false);
		}
		if ($("#free").data("check") =="Y") {
			$("#free").data("check","N");
			$("#free").prop("disabled", false);
		}
	});
	// 할인 판매시
	$("#sale").on("click", function() {
		if ($(this).data("check") == "N") {
			$(this).data("check","Y");
			$(this).prop("disabled", true);
			$(".method-free-check").css("display", "none");
			$(".method-common-check").css("display", "block");
			$(".method-sale-check").css("display", "block");
			$("#sales-method-check").css("display", "none");
		}
		if ($("#non-sale").data("check") =="Y") {
			$("#non-sale").data("check","N");
			$("#non-sale").prop("disabled", false);
		}
		if ($("#free").data("check") =="Y") {
			$("#free").data("check","N");
			$("#free").prop("disabled", false);
		}
	});
	// 무료 판매시
	$("#free").on("click", function() {
		if ($(this).data("check") == "N") {
			$(this).data("check","Y");
			$(this).prop("disabled", true);
			$(".method-free-check").css("display", "block");
			$(".method-common-check").css("display", "none");
			$(".method-sale-check").css("display", "none");
			$("#sales-method-check").css("display", "none");
		}
		if ($("#non-sale").data("check") =="Y") {
			$("#non-sale").data("check","N");
			$("#non-sale").prop("disabled", false);
		}
		if ($("#sale").data("check") =="Y") {
			$("#sale").data("check","N");
			$("#sale").prop("disabled", false);
		}
	});
	// 정가 , 할인가 숫자 검증
	$("#course_price").on("input",function() {
		$(this).val($(this).val().replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1"));
	});
	$("#course_sales_price").on("input", function() {
		$(this).val($(this).val().replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1"));
	});
	$("#course_sales_price").on("focus", function() {
		var price = $("#course_price").val();
		if (price == null || price == "") {
			$("#price-check-null").css("display", "block");
			$("#course_price").focus();
		} else {
			$("#price-check-null").css("display", "none");
		}
	});
	// 할인가 정가 비교
	$("#course_sales_price").on("change", function() {
		var price = parseInt($("#course_price").val());
		var s_price = parseInt($(this).val());
		if (price <= s_price) {
			$("#price-check-range").css("display", "block");
			$(this).val("");
			$(this).focus();
		} else {
			$("#price-check-range").css("display", "none");
		}
	});
	// 할인율 계산
	$("#sale-cal").on("click", function() {
		var price = $("#course_price").val();
		var s_price = $("#course_sales_price").val();
		if (price == "" || s_price == "" || price == null || s_price == null) {
			$("#cal-check").css("display", "block");
			return false;
		} else {
			$("#cal-check").css("display", "none");
		}
		var p = parseInt($("#course_price").val());
		var s = parseInt($("#course_sales_price").val());
		var rating = parseInt(100 - (s / p * 100));
		$(".btn-cal-check").css("display", "block");
		$("#course_discount_rate").attr("placeholder", rating);
	});
	// 강의명 33글자 넘게 입력시
	$("#course_NM").on("input",function(){
		if($(this).val().length > 33){
			$("#nm-check").css("display","block");
		}else{
			$("#nm-check").css("display","none");
		}
	});
	// 대표 이미지 
	$("#thumb_select").on("change",function(){
		var formData = new FormData();
		var file = $(this)[0].files[0];
		var regex = new RegExp("(.*?)\.(png|jpg|jpeg|svg)$");
		var maxSize = 5242880; //5MB
		  
		    if(file.size >= maxSize){
		      alert("5MB 미만 용량만 첨부가능합니다.");
		      $(this).val("");
		      return false;
		    }
		    if(!regex.test(file.name)){
		      alert("이미지 파일만 첨부할 수 있습니다.");
		      $(this).val("");
		      return false;
		    }
		    
		    formData.append("uploadFile", file);
		    
		    $.ajax({
		        url: '${path}/uploadAjax',
		        processData: false, 
		        contentType: false,
		        data: formData,
		        type: 'POST',
		        dataType:'json',
		          success: function(data){
		            var result = data.result;
		        	  if(result == "failed"){
		        		  alert("이미지 등록 실패, 다시 시도해주세요.");
		        	  }else{
		        		  $("#thumb_select").data("img",result);
		        	  }
		        }
		      });
		    setImageFromFile(this, '#preview');
	});
	
	// submit
	$("#c-submit").on("click", function() {
		var cts = new Array();
		var sks = new Array();
		$("#ct_selected").children().each(function() {
			cts.push($(this).data("ctSeq"));
		});
		$("#sk_selected").children().each(function() {
			sks.push($(this).data("skName"));
		});
		if(cts == null || cts == ""){
			$("#ct-check-null").css("display","block");
			$("#ct_list").focus();
			return false;
		}
		if(sks == null || sks == ""){
			$("#sk-check-null").css("display","block");
			$("#sk_select").focus();
			return false;
		}
		var level = $("input[name='course_level']:checked").val();
		var isLimit;
		$(".limit-btn").each(function(){
			if($(this).data("check") == "Y"){
				isLimit = $(this).val();
			}	
		});
		if(isLimit == undefined){
			alert("수강 기간 제한 여부를 선택하세요.");
			$("#limit_list").focus();
			return false;
		}
		var period;
		if(isLimit == 'false'){
			period = 0;
		}else if(isLimit == 'true'){
			var month = $("#limit_list option:selected").val();
			if(month == null || month == ""){
				alert("수강 제한 기간을 선택하세요.");
				$("#limit_list").focus();
				return false;
			}else{
				period = month;
			}
			
		}
		
		var isSale;
		$(".sale-btn").each(function(){
			if($(this).data("check") == "Y"){
				isSale = $(this).val();
			}	
		});
		if(isSale == undefined){
			alert("판매 방식을 설정하세요.");
			return false;
		}
		var price;
		var sales_price;
		var rating;
		/* 무료 판매 */
		if(isSale == 'free'){
			price = 0;
			sales_price = 0;
			rating = 0;
		/* 정가 판매 */
		}else if(isSale == 'false'){
			if(isNull("course_price")){
				alert("정가를 입력하세요.");
				$("#course_price").focus();
				return false;
			}else{
				price = parseInt($("#course_price").val());
				sales_price = 0;
				rating = 0;
			}
		/* 할인가 판매 */
		}else if(isSale == 'true'){
			if(isNull("course_price")){
				alert("정가를 입력하세요.");
				$("#course_price").focus();
				return false;
			}else if(isNull("course_sales_price")){
				alert("할인가를 입력하세요.");
				$("#course_sales_price").focus();
				return false;
			}else{
				price = parseInt($("#course_price").val());
				sales_price = parseInt($("#course_sales_price").val());
					if(price <= sales_price){
						alert("할인가보다 정가가 클 수 없습니다.");
						$("#course_sales_price").focus();
						return false;
					}else{
						rating = parseInt(100 - (sales_price / price * 100));
					}
			}
		}
		var name;
		if(isNull("course_NM")){
			$("#nm-check-null").css("display","block");
			$("#course_NM").focus();
			return false;
		}else{
			name = $("#course_NM").val();
			$("#nm-check-null").css("display","none");
		}
		var intro = $("#summernote").val();
		if(intro == null || intro == ""){
			$("#intro-check-null").css("display","block");
			$("#summernote").focus();
			return false;
		}else{
			$("#intro-check-null").css("display","none");
		}
		
		var img_name = $("#thumb_select").data("img");
		
		if(img_name == undefined){
			$("#thumb-check-null").css("display","block");
			$("#thumb_select").focus();
			return false;
		}else{
			$("#thumb-check-null").css("display","none");
		}
		
		var objParams = {
				 "cts" : cts, 
                 "sks" : sks,
                 "course_intro" : intro,
                 "course_level" : level,
                 "course_price" : price,
                 "course_sales_price" : sales_price,
                 "course_discount_rate" : rating,
                 "course_NM" : name,
                 "member_id" : "${user.member_id}",
                 "course_img_nm" : img_name,
                 "course_available_period" : period
             };
		
		$.ajax({
			url : "${path}/mypage/applyCourse",
			type : "POST",
			dataType : "json",
			data : objParams,
			success : function(data) {
				var result = data.result;
				alert(result);
				showAwaitList();
			}
		})
	});
	
	function isNull(id){
		var item = document.getElementById(id).value;
		if(item == null || item == ""){
			return true;
		}else{
			return false;
		}
	}
	function setImageFromFile(input, id) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(id).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	function cancelCourse(seq){
		$.ajax({
			url : "${path}/mypage/cancelCourse",
			type : "POST",
			dataType : "json",
			data : {"course_seq" : seq },
			success : function(data) {
				var result = data.result;
				alert(result);
				showCancleList();
			}
		})
	}
	
</script>

<script type="text/javascript">
	function showAwaitList(){
		 location.href = "${path}/mypage/awaitCourse"
	}
	
	function showCancleList(){
		location.href = "${path}/mypage/cancelCourse"
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