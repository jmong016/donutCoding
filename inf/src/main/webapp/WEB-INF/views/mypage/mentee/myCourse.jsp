<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<style>
#my-course-wrapper .course{
	display: flex;
	flex-wrap: wrap;
	border: 1px solid var(--gray-color);
	border-radius: 1em;
}
#my-course-wrapper .thumbnail:hover{
	cursor: pointer;
}
#my-course-wrapper .course>div{
	flex: 1;
}
#my-course-wrapper *{
	text-align: center;
}
#review-modal *{
	text-align: center;
}
#review-modal .star-wrapper button{
	zoom: 1.5;
	padding: 0;
}
#review-modal .checked , .selected{
	color: orange;
}
</style>
<div id="mypage-wrapper">
	<%@ include file="../../common/aside.jsp"%>
	<section id="mypage-content">
		<div id="my-course-wrapper">
			<div class="p-3 mx-auto">
				<h4>내 학습</h4>
			</div>

			<div class="order-wrapper">
				<c:choose>
					<c:when test="${myCourse != null}">
						<c:forEach items="${myCourse }" var="m">
							<div class="course p-2 mt-2 my-auto mx-auto">
								<div class="thumbnail"
									onclick="location.href='${path }/course/${m.course.course_seq }'">
									<img alt="${m.course.course_NM }"
										src="${path }/thumbnails?course_seq=${m.course.course_seq}&img_nm=${m.course.course_img_nm}"
										style="width: 150px; height: 100px; object-fit: cover; border: none; border-radius: 1em;">
								</div>
								
								<div class="info my-auto mx-auto">
									<h5>
										<a class="dark-font"
											href="${path }/course/${m.course.course_seq}">${m.course.course_NM }</a>
									</h5>
									<c:choose>
										<c:when test="${m.end_dt != null}">
											<p class="mt-1">수강 기한 : <span class="badge bg-danger my-auto">${m.end_dt }</span> 까지</p>
										</c:when>
										<c:otherwise>
											<p class="mt-1">수강 기한 : 무제한</p>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="other my-auto mx-auto">
									<button type="button" class="btn btn-warning"
										onclick="showReviewModal(${m.course.course_seq})"
										style="display: block; margin: auto;">수강 후기 작성</button>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>
							<h5 class="p-3" style="text-align: center;">수강 중인 강의가 없습니다!</h5>
							<button type="button" class="btn btn-warning"
								onclick="location.href='${path}/courses'"
								style="display: block; margin: auto;">강의 보러가기</button>
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
				<input id="seq" type="number" name="course_seq" hidden="hidden">
					<div class="star-wrapper mb-2" data-check="false">
						<button id="star1" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star2" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star3" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star4" type="button" class="btn star" ><span class="fa fa-star"></span></button>
						<button id="star5" type="button" class="btn star" ><span class="fa fa-star"></span></button>
					</div>
				<textarea id="content" type="text" class="form-control" maxlength="100"
				placeholder="최대 100글자까지 입력 가능합니다."></textarea>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="writeReview()">후기 작성</button>
				</div>

			</div>
		</div>
	</div>

</div>

<script type="text/javascript">

/* $(document).ready(function(){
	$('#content').summernote({
		height : 200,
		placeholder: '최대 100자까지 입력가능합니다.',
		maxlength: 200
	});
}); */
	function showReviewModal(seq){
		$.ajax({
			url : "${path}/review/isduplicated",
			type: "post",
			dataType : 'json',
			data : { "courseSeq" : seq,
					 "memberID" : "${user.member_id}"
					},
			success : function(result){
				if(result){
					$("#seq").val(seq);
					$("#review-modal").modal("show");
				}else{
					sConfirm("이미 작성한 수강평입니다.","해당 수강평으로 이동하시겠습니까?","warning","${path}/mypage/review");
				}
			}
		});
		
	}
	
	function writeReview(){
		var seq = $("#seq").val();
		var content = $("#content");
		var cVal = content.val().replace(/\n/g, "<br>");
		var rate = 0;
		if(isNull(content)){
			return;
		}
		if($(".star-wrapper").data("check") != "true"){
				Swal.fire({
				  icon: 'error',
				  title: "평점을 선택하세요",
				  showConfirmButton: false,
				  timer: 1200
				}).then((result) => {
					$('.star-wrapper').animate( { zoom : "1.2"}, 500, function() {
			            $( this ).animate( { zoom : "1"}, 500 );
			   		 });
				});
			
			return;
		}else{
			rate = $(".star-wrapper").children(".selected").length;
		}
		
		$.ajax({
			url : "${path}/review/writeCourse",
			type : "post",
			dataType : "json",
			data : { "memberID" : "${user.member_id}",
					 "courseSeq" : seq,
					 "content" : cVal,
					 "rate" : rate},
			success : function(data){
				var result = data.result;
				var error = data.error;
				var msg = data.msg;
				var title = data.title;
				if(result){
					sConfirm(title,msg,"success","${path}/mypage/review");
				}else{
					sAlert(title,msg,"error");
				}
				
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
		$(".star").each(function(index, item){
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
		$(".star").each(function(index, item){
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

	function orderDetail(name,phone,email){
		var html =
			"주문인 : "+ name + "<br>" + "주문인 연락처 : " + phone + "<br>" 
			+ "주문인 이메일 : " + email;
		Swal.fire({
			  icon: 'info',
			  confirmButtonText: '닫기',
			  html: html
			})
	}
	function sAlert(title,msg,type){
		Swal.fire({
			  icon: type,
			  title: title,
			  html : msg
			});
	}
	function sConfirm(title,msg,type,link){
		Swal.fire({
			  title: title,
			  html: msg,
			  icon: type,
			  showCancelButton: true,
			  confirmButtonText: '이동',
			  cancelButtonText: '취소',
			}).then((result) => {
			  if (result.isConfirmed) {
			    location.href = link;
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

<%@ include file="../../common/footer.jsp"%>