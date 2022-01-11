



function price_blocked() {
	
	  var checkBox = document.getElementById("pr2");

	  if (checkBox.checked == true){
		  $('#course_sales_price').css("display","block");
		  $('#course_discount_rate').css("display","block");
	  } else {
		  $('#course_sales_price').css("display","none");
		  $('#course_discount_rate').css("display","none");
	  }
	}

/*submit보내기*/
//$("#btn_submit").click(function (event) {
//	
//	event.preventDefault();
//	
////	var url = $("#form").attr("action");
//	var form = $('#form')[0];
//	var formData = new FormData(form); 
//	
//	$.ajax({
//		url: "/member/createCourse", 
//		type: "POST", 
//		data: formData, 
//		success: function (data) { 
//			alert('success');
//		},
//		error: function (data) {
//			alert('fail'); 
//		},
//		cache: false,
//		contentType: false,
//		processData: false
//	});
//});

/*submit보내기*/
//$(document).ready(function(e){
//	
//	 $("input[type='file']").change(function(e){
//
//		    var formData = new FormData();
//		    
//		    var inputFile = $("input[name='uploadFile']");
//		    
//		    var files = inputFile[0].files;
//		    
//		    for(var i = 0; i < files.length; i++){
//
//		      if(!checkExtension(files[i].name, files[i].size) ){
//		        return false;
//		      }
//		      formData.append("uploadFile", files[i]);
//		      
//		    }
//		    
//		    $.ajax({
//		      url: '/uploadAjaxAction',
//		      processData: false, 
//		      contentType: false,
//		      beforeSend: function(xhr) {
//		          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
//		      },
//		      data:formData,
//		      type: 'POST',
//		      dataType:'json',
//		        success: function(result){
//		          console.log(result); 
//				  showUploadResult(result); //업로드 결과 처리 함수 
//
//		      }
//		    }); //$.ajax
//		    
//		  });  
//	 
//	  $("button[type='submit']").on("click", function(e){
//		    
//		    e.preventDefault();
//		    
//		    console.log("submit clicked");
//		    
//		    var str = "";
//		    
//		    $(".uploadResult ul li").each(function(i, obj){
//		      
//		      var jobj = $(obj);
//		      
//		      console.dir(jobj);
//		      console.log("-------------------------");
//		      console.log(jobj.data("filename"));
//		      
//		      
//		      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
//		      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
//		      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
//		      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
//		      
//		    });
//		    
//		    console.log(str);
//		    
//		    form.append(str).submit();
//		    
//		  });
//})