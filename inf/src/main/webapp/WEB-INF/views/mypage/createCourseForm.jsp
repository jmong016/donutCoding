<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../common/header.jsp"%>

<!--  summernote jQuery, bootstrap -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>


<div class="container">
	<form id="form" action="createCourse" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="member_id" value="${param.member_id}" />
		<table>
			<tr>
				<td>카테고리</td>
				<td><select id="ct_list" name="ct_list">
						<option value="0">카테고리
						<c:forEach items="${ctMap }" var="ct">
							<option value="${ct.category_seq }">${ct.category_nm }
						</c:forEach>
				</select></td>
				<td>
				<div id="ct_selected"></div>
				</td>
			</tr>
			<tr>
				<td>기술</td>
				<td>
				<input id="sk_select" type="text" name="skill_nm" placeholder="기술명">
				<button id="sk_add" type="button" class="btn btn-primary" >추가</button>
				</td>
				<td><p id="sk-error" style="color:red; display:none;">기술명을 입력하세요.</p></td>
				<td><div id="sk_selected">
				</div></td>
			</tr>

			<tr>
				<td>난이도</td>
				<td><input type="radio"
						name="course_level" value="입문" checked>입문
				<input type="radio"
						value="초급" name="course_level">초급
				<input type="radio"
						value="중급이상" name="course_level">중급 이상
				</td>
			</tr>
			<tr>
				<td>판매 방식</td>
				<td>
				<label class="radio-inline" for="sale_check">
				<input type="checkbox" id="sale_check">할인 판매 
				 </label>
						</td>
				<td> <input
						class="price" name="course_price" id="course_price" type="number"
						size="10" placeholder="정상가" /></td>
						
				<td id="onSale" style="display:none;">
				<input class="price" name="course_sales_price" id="course_sales_price"
						type="number" size="10" placeholder="할인가" />
				<p style="display:inline-block;">할인율(%)</p>
				<input type="number" name="course_discount_rate">
				</td>
			</tr>
			<tr>
				<td>강의명</td>
				<td><input name="course_NM" type="text" size="40"
					placeholder="강의명" /> <input type="hidden" name="member_id"
					value="${user.member_id}" /></td>

			</tr>

		</table>
		<div>
			<h4>강의 내용</h4>
			<div>
				<textarea id="summernote" name="course_intro"></textarea>
			</div>
			<div>
				<input type="hidden">
			</div>
		</div>

		<div class="form_section">
			<label>강의 대표 이미지</label>
			<div class="form_section_content">
				<input type="file" name="course_img_nm">
			</div>
		</div>
		<div class='uploadResult'>
			<ul>

			</ul>
		</div>

		<div align=center>
			<!--  <input  type="button" value="강의 등록하기" onclick="createCourse"> -->
			<!-- <input type="button" value="강의 등록하기"
				onClick="fn_add_new_goods(this.form)"> -->
			<input type="button" id="btn_submit" class="btn btn-info" value="강의 등록하기">
		</div>


	</form>



</div>
<!-- container end -->

<script type="text/javascript">
	$(document).ready(function () {
		/* 썸머노트 */
	    $('#summernote').summernote({
	        placeholder: '내용을 작성하세요',
	        height: 400,
	        maxHeight: 400
	    });
	    
	});
	// 카테고리를 선택했을 때
	$("#ct_list").on("change",function(){
		var ct_seq = $("#ct_list option:selected").val();
		var ct_nm = $("#ct_list option:selected").text();
		
		$("#ct_selected").append($("<button type='button' onClick='ctBtnClicked("+ct_seq+")' class='btn ct-choosed' data-ct-seq='"+ct_seq+"'>"+ct_nm+"</button>"));
	
		var choosed_list = $("#ct_selected button").length;
		if(choosed_list >= 3){
			alert("강의 관련 카테고리는 최대 3개까지 선택 가능합니다.");
			$(this).prop("disabled","disabled");
			return false;
		}
			$("#sk_list").prop("disabled","");
	});
	// 추가된 카테고리를 클릭하면 삭제
	function ctBtnClicked(ct_seq){
		var target = $(".ct-choosed[data-ct-seq='"+ct_seq+"']");
		target.remove();
		var choosed_list = $("#ct_selected button").length;
		if(choosed_list < 3){
			$("#ct_list").prop("disabled","");
			return false;
		}
	}
	// 스킬 추가
	$("#sk_add").on("click",function(){
		var input = $("#sk_select").val().trim();
		if(input == null || input == ""){
			$("#sk-error").css("display","block");
			return false;
		}else{
			$("#sk-error").css("display","none");
			$("#sk_selected").append($("<button type='button' onClick='skBtnClicked("+'"'+input+'"'+")' class='btn sk-choosed' data-sk-name='"+input+"'>"+input+"</button>"));
			$("#sk_select").val("");
		}
		var choosed_list = $("#sk_selected").children().length;
		if(choosed_list >= 3){
			alert("강의 관련 기술은 최대 3개까지 선택 가능합니다.");
			$(this).prop("disabled","disabled");
			return false;
		}
		/* TODO: 이미 있는 값 들어오면 거절하기 */
	});
	// 추가된 기술을 클릭하면 삭제
	function skBtnClicked(input){
		var target = $(".sk-choosed[data-sk-name='"+input+"']");
		target.remove();
		var choosed_list = $("#sk_selected").children().length;
		if(choosed_list < 4){
			$("#sk_add").prop("disabled","");
			return false;
		}
	}
	// 할인 판매시
	$("#sale_check").on("change",function(){
		if(!$(this).prop("checked")){
			$("#onSale").css("display","none");
		}else{
			$("#onSale").css("display","block");
		}
	});
	
	// submit
	$("#btn_submit").on("click",function(){
		var cts = new Array();
		var sks = new Array();
		$("#ct_selected").children().each(function(){
			cts.push($(this).data("ctSeq"));
		});
		console.log(cts);
		$("#sk_selected").children().each(function(){
			sks.push($(this).data("skName"));
		});
		console.log(sks);
	});
	
</script>


<%@ include file="../common/footer.jsp"%>