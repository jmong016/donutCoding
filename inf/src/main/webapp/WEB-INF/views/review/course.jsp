<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/inf.css" />
<style>
#review-container .review_item{
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	border: 1px solid var(--gray-color);
	border-radius: 1em;
}
#review-container .thumbnail:hover{
	cursor: pointer;
}
#review-container *{
	text-align: center;
}
#review-container .star-wrapper p{
	zoom: 1.5;
	padding: 0;
	display: inline-block;
}
#review-container .star-wrapper .selected{
	color: orange;
}
</style>

<div class="container p-3 my-2 white-bg"
	style="border-radius: 1em; border: none;">
	<h3 style="text-align: center;">강의 수강평</h3>
</div>

<section id="review-course" class="container">
<%@ include file="../common/aside_inf.jsp" %>

	<div id="review-container" class="p-2">
		<!-- 강의 -->
		<div class="course-review">
			<c:choose>
				<c:when test="${courseReview != null}">
					<c:forEach items="${courseReview }" var="i">
						<div id="review-${i.reviewSeq }" class="review_item my-2 ">
							<div class="review-content">
								<div class="star-wrapper mb-1">
									<c:forEach begin="1" end="5" step="1" var="num">
										<c:choose>
											<c:when test="${num <= i.rate }">
												<p class="star selected" ><span class="fa fa-star"></span></p>
											</c:when>
											<c:otherwise>
												<p class="star" ><span class="fa fa-star"></span></p>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<span>( ${i.rate }점 )</span>
								</div>
								<div class="content mb-1">
									${i.content }
								</div>
								<div class="info">
									<span>글쓴이 : ${i.memberNick } </span> 
									<span>작성일 : <fmt:formatDate value="${i.regDate }" pattern="yyyy년 MM월 dd일  HH:mm"/>  </span> 
									<span>강의명 : <a href="${path }/course/${i.courseSeq}">${i.courseName }</a> </span>
								</div>
							</div>
							<div class="review-thumbnail">
								<a href="${path }/course/${i.courseSeq}"> <!-- 썸네일 --> <img
									class="img-thumbnail" alt="thumbnail"
									src="${path }/thumbnails?course_seq=${i.courseSeq}&img_nm=${i.courseImg}"
									style="width: 150px; height: 100px; object-fit: cover; border: none; border-radius: 1em;">
								</a>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>
						<h4 class="p-3" style="text-align: center;">수강평이 없습니다!</h4>
						<button type="button" class="btn btn-warning"
							onclick="location.href='${path}/coursess'"
							style="display: block; margin: auto;">강의 보러가기</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

</section>

<%@ include file="../common/footer.jsp"%>