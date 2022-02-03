<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#my-review-container .review_item{
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	border: 1px solid var(--gray-color);
	border-radius: 1em;
}
#my-review-container .btn-wrapper button{
	display: block;
}
#my-review-container .thumbnail:hover{
	cursor: pointer;
}
#mypage-content *{
	text-align: center;
}
#review-modal *{
	text-align: center;
}
#my-review-container .rating-wrapper p{
	zoom: 1.5;
	padding: 0;
	display: inline-block;
}
#review-modal .star-wrapper button{
	zoom: 1.5;
	padding: 0;
	display: inline-block;
}
#my-review-container .rating-wrapper .selected{
	color: orange;
}
#review-modal .star-wrapper .selected , .checked{
	color: orange !important;
}
</style>
<div id="mypage-wrapper">
	<c:choose>
		<c:when test="${user.member_role == '멘토'}">
			<%@ include file="../common/aside_mentor.jsp"%>
		</c:when>
		<c:when test="${user.member_role == '관리자'}">
			<%@ include file="../common/aside_admin.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="../common/aside.jsp"%>
		</c:otherwise>
	</c:choose>
	<section id="mypage-content">
		<div class="p-3 mx-auto">
				<h4>내 수강평</h4>
		</div>
		<div id="my-review-container" class="p-2">
			<!-- 강의 -->
			<div class="course-review">
				<c:choose>
					<c:when test="${myReview != null}">
						<c:forEach items="${myReview }" var="i">
							<div id="review-${i.reviewSeq }" class="review_item my-2 ">
								<div class="review-thumbnail">
									<a href="${path }/course/${i.courseSeq}"> <!-- 썸네일 --> <img
										class="img-thumbnail" alt="thumbnail"
										src="${path }/thumbnails?course_seq=${i.courseSeq}&img_nm=${i.courseImg}"
										style="width: 150px; height: 100px; object-fit: cover; border: none; border-radius: 1em;">
									</a>
								</div>
								<div class="review-content">
									<div class="rating-wrapper mb-1">
										<c:forEach begin="1" end="5" step="1" var="num">
											<c:choose>
												<c:when test="${num <= i.rate }">
													<p class="selected">
														<span class="fa fa-star"></span>
													</p>
												</c:when>
												<c:otherwise>
													<p>
														<span class="fa fa-star"></span>
													</p>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<span>( ${i.rate }점 )</span>
									</div>
									<div class="content mb-1">${i.content }</div>
									<div class="info">
										<span>글쓴이 : ${i.memberNick } </span> <span>작성일 : <fmt:formatDate
												value="${i.regDate }" pattern="yyyy년 MM월 dd일  HH:mm" />
										</span> <span>강의명 : <a href="${path }/course/${i.courseSeq}">${i.courseName }</a>
										</span>
									</div>
								</div>
								<div class="btn-wrapper my-auto">
									<button type="button" class="btn btn-primary mb-1"
									onclick="showModifyModal(${i.reviewSeq},${i.courseSeq },'${i.content }',${i.rate })">
									수정하기
									</button>
									<button type="button" class="btn btn-danger"
									onclick="deleteReview(${i.reviewSeq})">
									삭제하기
									</button>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>
							<h4 class="p-3" style="text-align: center;">작성한 수강평이 없습니다!</h4>
							<button type="button" class="btn btn-warning"
								onclick="location.href='${path}/mypage/course'"
								style="display: block; margin: auto;">수강평 작성하기</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	
	<!-- 수강후기 모달 -->
	<div class="modal fade" id="review-modal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">수강 후기 작성</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
				<input id="courseSeq" type="number" name="courseSeq" hidden="hidden">
				<input id="reviewSeq" type="number" name="reviewSeq" hidden="hidden">
					<div class="star-wrapper mb-2" data-check="false">
						<button id="star1" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star2" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star3" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star4" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star5" type="button" class="btn star" ><span class="fa fa-star"></span></button>
					</div>
				<textarea id="content" type="text" class="form-control" maxlength="100"
				placeholder="최대 100글자까지 입력 가능합니다." style="height:150px"></textarea>
				
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="modifyReview()">수정하기</button>
				</div>

			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
	function showModifyModal(review,course,content,rate){
		$("#reviewSeq").val(review);
		$("#courseSeq").val(course);
		$("#content").val(content.replaceAll("<br>", "\r\n"));
		$(".star").each(function(index){
			index >= rate? $(this).removeClass("selected") : $(this).addClass(" selected");
		});
		$("#review-modal").modal("show");
	}
	
	function deleteReview(seq){
		Swal.fire({
			  html: "해당 수강평을 삭제하시겠습니까?",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소',
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url : "${path}/review/deleteCourse",
						type : "post",
						dataType : "json",
						data : { "reviewSeq" : seq},
						success : function(data){
							var title = data.title;
							var msg = data.msg;
							var type = data.type;
							sAlert(title,msg,type);
						}
					});
			  }
			});
	}
	
	function modifyReview(){
		var courseSeq = $("#courseSeq").val();
		var reviewSeq = $("#reviewSeq").val();
		var content = $("#content");
		var cVal = content.val().replace(/\n/g, "<br>");
		var rate = 1;
		if(isNull(content)){
			return;
		}
		if($(".star-wrapper").data("check") != "true"){
				Swal.fire({
				  icon: 'error',
				  title: "평점을 선택하세요",
				  showConfirmButton: false,
				  timer: 1200
				}).then(() => {
					$('.star-wrapper').animate( { zoom : "1.2"}, 500, function() {
			            $( this ).animate( { zoom : "1"}, 500 );
			   		 });
				});
			
			return;
		}else{
			rate = $(".star-wrapper").children(".selected").length;
		}
		
		$.ajax({
			url : "${path}/review/modifyCourse",
			type : "post",
			dataType : "json",
			data : { "reviewSeq" : reviewSeq,
					 "memberID" : "${user.member_id}",
					 "courseSeq" : courseSeq,
					 "content" : cVal,
					 "rate" : rate},
			success : function(data){
				var msg = data.msg;
				var title = data.title;
				var type = data.type;
					sAlert(title,msg,type);
			}
		});
	}
	$("#content").on("input change",function(){
		if(isNull($(this))){
			return;
		}
	});
	
	$(".star").on("mouseover",function(){
		var num = parseInt($(this).attr("id").substr($(this).attr("id").length-1));
		$(".star").each(function(index){
			index >= num ? $(this).removeClass("checked") : $(this).addClass(" checked");
		});
	});
	
	$(".star").on("mouseout",function(){
		$(".star").each(function(){
			$(this).removeClass("checked");
		});
	});
	
	$(".star").on("click",function(){
		var num = parseInt($(this).attr("id").substr($(this).attr("id").length-1));
		$(".star").each(function(index){
			index >= num ? $(this).removeClass("selected") : $(this).addClass(" selected");
			$(".star-wrapper").data("check","true");
		});
	});
	
	$('#review-modal').on('hidden.bs.modal', function () {
		$(".star").each(function(){
			$(this).removeClass("selected");
		});
		$(".star-wrapper").data("check","false");
		$(".c-check-null").css("display","none");
		$("#content").css("background","").val("");
	});

	function sAlert(title,msg,type){
		Swal.fire({
			  icon: type,
			  title: title,
			  html : msg
			}).then((result) => {
				 location.reload();
			});
	}
	function sConfirm(title,msg,type,callback){
		Swal.fire({
			  title: title,
			  html: msg,
			  icon: type,
			  showCancelButton: true,
			  confirmButtonText: '이동',
			  cancelButtonText: '취소',
			}).then((result) => {
			  if (result.isConfirmed) {
			    callback;
			  }else{
				  location.reload();  
			  }
			})
	}
	function isNull(input){
		var value = input.val();
		if(value == "" || value == null){
			input.css("background","var(--accent-color)").focus();
			return true;
		}else{
			input.css("background","");
			return false;
		}
	}
</script>

<%@ include file="../common/footer.jsp"%>