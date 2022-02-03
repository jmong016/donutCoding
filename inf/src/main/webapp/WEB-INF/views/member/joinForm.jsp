<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<style>
label {
   padding: 0px 10px;
   margin: 0px;
}

input[type=text], input[type=password], input[type=ID], input[type=phone]
   {
   width: 100%;
   padding: 15px;
   margin: 5px 0 22px 0;
   display: inline-block;
   border: none;
   background: #f1f1f1;
}

#idChk, #emailChk {
   width: 18%;
   font-size: 14px;
   color: white;
}

input[type=text]:focus, input[type=password]:focus {
   background-color: #ddd;
   outline: none;
}

.cancelbtn, .signupbtn {
   color: white;
   /*    padding: 14px 20px;
   margin: 5px 0; */
   border: none;
   cursor: pointer;
   width: 40%;
   opacity: 0.9;
}

.cancelbtn, .signupbtn: hover {
   opacity: 1;
}

.signupbtn {
   padding: 14px 10px;
   background-color: #F2BF5E;
}

.cancelbtn {
   padding: 14px 10px;
   background-color: #7FBFDA;
}

.cancelbtn, .signupbtn {
   min-width: 100px;
   max-width: 150px;
}

.clearfix::after {
   content: "";
   clear: both;
   display: table;
}

@media screen and (max-width: 300px) {
   .cancelbtn, .signupbtn {
      width: 100%;
   }
}

.input-group {
   height: 65px;
}

.input-group button {
   height: 100%;
}

.input-group input {
   height: 100%;
   margin: 0;
}

.flex-wrapper {
   display: flex;
}

.flex-wrapper * {
   min-width: max-content;
}

.join-button-wrapper {
   margin: auto;
   min-width: 300px;
   width: 50%;
   display: flex;
   justify-content: space-around;
}

.join-form {
   width: 50% !important;
   min-width: 320px !important;
   max-width: 700px !important;
}

#form_failed{
	boarder-color:#ffc107;
	text-align: center;
	color: red;
	
}
</style>



<div class="container mt-3 join-form">
   <h3>회원 가입</h3>
   <p>입력후 회원가입 버튼을 눌러주세요.</p>

   <form action="" method="post" class="was-validated" id="join_form" name="join_form"
      style="border: 1px solid #ccc">

      <div class="mb-3 mt-3">
         <label for="member_id" class="form-label">아이디</label>
         <div class="input-group mb-3">
            <input type="text" class="form-control" name="member_id"
               id="member_id" placeholder="아이디를 입력해주세요." required>
            <button class="btn btn-primary " id="idChk" type="button"
               onClick="fn_idChk()" data-check="N">
               <span class="white-font">중복 체크</span>
            </button>
         </div>
         <span id="idRegex"></span>
      </div>


<div class="mb-3 mt-3">
   <label for="member_password" class="form-label">비밀번호</label>
   <div class="input-group mb-3">
      <input type="password" class="form-control" name="member_password"
         id="member_password" placeholder="2~15자리의 영문, 숫자 입력이 가능합니다."
         name="member_password" required>
   </div>
   <span id="pwRegex"></span>
</div>


<div class="mb-3 mt-3">
   <label for="member_password-checked" class="form-label">비밀번호 재입력</label>
   <div class="input-group mb-3">
      <input type="password" class="form-control"
         id="member_password-checked" placeholder="비밀번호를 다시한번 입력해 주세요."
         name="member_password1" required>
   </div>
   <span id="sampwRegex"></span>
</div>


<div class="mb-3">
   <label for="member_email" class="form-label">이메일</label>
   <div class="input-group mb-3">
      <input type="text" class="form-control" id="member_email"
         placeholder="***@***.com" name="member_email" required>
      <button class="btn btn-primary" id="emailChk" type="button"
         onClick="fn_emailChk()" data-check="N">
         <span class="white-font">중복 체크</span>
      </button>
   </div>
   <span id="emailRegex"></span>
</div>

<div class="form-check mb-3">
   <div class="flex-wrapper" id="form_failed">
      <c:if test="${joinResult == 'Failed'}">
      <div>
      	<p>회원가입 실패! 관리자에게 문의해 주세요.</p>
      </div>
      </c:if>
   </div>
</div>

</form>
<div class="clearfix">
   <div class="join-button-wrapper">
      <button type="button" id="sign" class="signupbtn" onclick="wow()">회원가입</button>

      <button type="button" id="cancel" class="cancelbtn">취소</button>
   </div>
</div>

<script>
   $(document).ready(function() {      
      // 아이디와 패스워드가 적합한지 검사할 정규식
      var engNum = /^[a-zA-Z0-9]{2,15}$/;
      // 이메일이 적합한지 검사할 정규식
      var emailck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

      // 취소
       $("#cancel").on("click", function() {
         location.href = "${path}/main";
      });
		// 회원가입
      $("#sign").on("click", function() {
         if ($("#member_id").val().trim() == "") {
            //alert("아이디를 입력해주세요.");
            $("#idRegex").text("아이디를 입력해주세요.").css("color","red");
            $("#member_id").css("background-color","var(--accent-color)");
            $("#member_id").focus();
            return false;
         }
         if ($("#member_password").val().trim() == "") {
            //alert("비밀번호를 입력해주세요.");
            $("#pwRegex").text("비밀번호를 입력해주세요.").css("color","red");
            $("#member_password").css("background-color","var(--accent-color)");
            $("#member_password").focus();
            return false;
         }
         if ($("#member_email").val().trim() == "") {
            //alert("이메일을 입력해주세요.");
            $("#emailRegex").text("이메일을 입력해주세요.").css("color","red");
            $("#member_email").css("background-color","var(--accent-color)");
            $("#member_email").focus();
            return false;
         }
         var idChkVal = $("#idChk").attr("data-check");
         if (idChkVal == "N") {
            $("#idRegex").text("중복확인 필수입니다.").css("color","red");
            $("#member_id").css("background-color","var(--accent-color)");
            return false;
         }
         var emailChkVal = $("#emailChk").attr("data-check");
         if (emailChkVal == "N") {
            $("#emailRegex").text("중복확인 필수입니다.").css("color","red");
            $("#member_email").css("background-color","var(--accent-color)");
            return false;
         }
         $("#join_form").attr("action", "${path}/member/join");
         $("#join_form").submit();
      });
      //정규식 id
      $("#member_id").keyup(function(){
         id = $(this).val();
         if(!engNum.test(id)){
            $("#idRegex").text("영문+숫자 2~15자리 입력가능").css("color","red");
         }else{
            $("#idRegex").text("사용 가능").css("color","skyblue");
         }
      });
      //정규식 password
      $("#member_password").keyup(function(){
         pw = $(this).val();
         if(!engNum.test(pw)){
            $("#pwRegex").text("영문+숫자 2~15자리 입력가능").css("color","red");
         }else{
            $("#pwRegex").text("사용가능").css("color","skyblue");
         }
      });
      //정규식 email
      $("#member_email").keyup(function(){
         em = $(this).val();
         if(!emailck.test(em)){
            $("#emailRegex").text("이메일 형식 불일치").css("color","red");
         }else{
            $("#emailRegex").text("사용가능").css("color","skyblue");
         }
      });
   });
   
   // 중복 체크 후 아이디 혹은 이메일을 변경했을 때
   $("#member_id").on("change", function() {
      if ($("#idChk").attr("data-check") == "N") {
         return false;
      } else {
         $("#idRegex").text("다시 ID 중복체크를 실행해주세요.").css("color","red");
         $("#member_id").css("background-color"," var(--accent-color)");
         $("#idChk").attr("data-check","N");
         $("#idChk").focus();
         return false;
      }
   });
   $("#member_email").on("change", function() {
      if ($("#emailChk").attr("data-check") == "N") {
         return false;
      } else {
         $("#emailRegex").text("다시 email 중복체크를 실행해주세요.").css("color","red");
         $("#member_email").css("background-color"," var(--accent-color)");
         $("#emailChk").attr("data-check","N");
         $("#emailChk").focus();
         return false;
      }
   });
   //idChk
   function fn_idChk() {
      var id = $("#member_id").val().trim();
      var engNum = /^[a-zA-Z0-9]{2,15}$/;
         if (id == "" || id == null) {
            //alert("아이디를 입력해주세요.");
            $("#idRegex").text("아이디를 입력해주세요.").css("color","red");
            $("#member_id").css("background-color"," var(--accent-color)");
            return false;
         }
         if(!engNum.test(id)){
             //alert("id 형식에 맞게 작성하세요.");
             $("#idRegex").text("아이디 형식 불일치").css("color","red");
             $("#member_id").css("background-color"," var(--accent-color)");
             $("#member_id").focus();
             return false;
          }
      $.ajax({
         url : "${path}/member/idChk",
         type : "post",
         dataType : "json",
         data : {
            "member_id" : id
         },
         success : function(data) {
            if (data == 1) {
               //alert("중복된 ID입니다.");
            	$("#idRegex").text("중복된 아이디 입니다.").css("color","red");
            	$("#member_id").css("background-color"," var(--accent-color)");
            } else if (data == 0) {
               $("#idChk").attr("data-check","Y");
               $("#idRegex").text("사용가능한 ID입니다.").css("color","blue");
               $("#member_id").css("background-color","");
               $("#member_password").focus();
            }
         }
      })
   }
   //비번 중복 체크
   $('.form-control').focusout(function() {
      var pwd1 = $("#member_password").val().trim();
      var pwd2 = $("#member_password-checked").val().trim();
      var engNum = /^[a-zA-Z0-9]{2,15}$/;
      if(!engNum.test(pwd1)){
          //alert("pw 형식에 맞게 작성하세요.");
          $("#pwRegex").text("패스워드 형식 불일치").css("color","red");
          $("#member_password").css("background-color"," var(--accent-color)");
          $("#member_password").focus();
          return false;
       }else{
    	   $("#pwRegex").text("패스워드 형식 일치").css("color","blue");
    	   $("#member_password").css("background-color","");
    	   $("#member_password-checked").css("background-color","");
       }
      if (pwd1 != '' && pwd2 == '') {
         null;
      } else if (pwd1 != "" || pwd2 != "") {
         if (pwd1 == pwd2) {
            $("#sampwRegex").text("비밀번호와 동일합니다.").css("color","blue");
         } else {
            $("#sampwRegex").text("비밀번호와 동일하지 않습니다.").css("color","red");
            $("#member_password").css("background-color"," var(--accent-color)");
            $("#member_password-checked").css("background-color"," var(--accent-color)");
            $("#member_password-checked").focus();
         }
      }
   });
   //emailChk
   function fn_emailChk() {
	   var emailck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
      var email = $("#member_email").val().trim();
         if (email == "" || email == null) {
            //alert("이메일을 입력해주세요.");
            $("#emailRegex").text("아이디를 입력해주세요.").css("color","red");
            $("#member_email").css("background-color"," var(--accent-color)");
            return false;
         }
         if(!emailck.test(email)){
             //alert("email 형식에 맞게 작성하세요.");
             $("#emailRegex").text("이메일 형식 불일치").css("color","red");
             $("#member_email").css("background-color"," var(--accent-color)");
             $("#member_email").focus();
             return false;
          }
      $.ajax({
         url : "${path}/member/emailChk",
         type : "post",
         dataType : "json",
         data : {
            "member_email" : email
         },
         success : function(data) {
            if (data == 1) {
            	$("#emailRegex").text("중복된 Email입니다.").css("color","red");
            	$("#member_email").css("background-color"," var(--accent-color)");
            } else if (data == 0) {
               $("#emailChk").attr("data-check","Y");
               $("#emailRegex").text("사용 가능한 Email입니다.").css("color","blue");
               $("#member_email").css("background-color","");
            }
         }
      })
   }
</script>

<%@ include file="../common/footer.jsp"%>