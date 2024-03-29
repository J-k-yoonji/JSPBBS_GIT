<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 장치별 화면 최적화 및 화면배율 설정 -->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0">
<!-- 루트폴더의 부트스트랩 참조 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판 글쓰기 화면</title>
</head>
<style>
	/* 구글에서 제공해 주는 폰트를 가져다 쓰는 방법 해당 폰트가 있는 구글의 주소로 매칭*/
	@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
	@import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
	
	* {
		font-family : 'Nanum Gothic';
	}
	h1 {
		font-family : 'Hanna';
	}
</style>
<script>
    function validateForm(form) { 
        if (form.bbsTitle.value == "") {
            alert("제목을 입력하세요.");
            form.bbsTitle.focus();
            return false;
        }
        if (form.bbsContent.value == "") {
            alert("내용을 입력하세요.");
            form.bbsContent.focus();
            return false;
        }
        if (form.ofile.value == "") {
            alert("파일을 첨부하세요.");
            return false;
        } 
    }
    
    
    function checkSize(input) {
        if (input.files && input.files[0].size > (20 * 1024 * 1024)) {
            alert("파일 사이즈가 30MB 를 넘습니다.");
            input.value = null;
        }
    }
  
    
    function fileTypeCheck(obj) {

    	pathpoint = obj.value.lastIndexOf('.');

    	filepoint = obj.value.substring(pathpoint+1,obj.length);

    	filetype = filepoint.toLowerCase();

    	if(filetype=='jsp') {

    		// jsp 확장자 파일인 경우 업로드 제한.

    		alert('jsp파일은 업로드할 수 없습니다.');
    		obj.value = null;
    		
    		return false;
    	}
    }
    
</script>
<body>
<jsp:include page="./include/nav.jsp" />
<!-- 내비게이션 바  -->
<%= BoardSession.sessionChkStr(request)%>
	
	<!-- 게시판 글쓰기화면 시작-->
	<div class="container">
		<!-- bbs에서 만든 양식 참조 사용 -->
		<div class = "row">
		<!-- form -->
			<form name="fileForm" method="post" action="writeFileAction.jsp" enctype="multipart/form-data" onsubmit="return validateForm(this);">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
				<thead>
					<tr>
						<!-- colspan="2" 현재의 속성이 2개의 열을 차지하게 해준다. -->
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 제목과 글 작성이 각각 한줄로 들어갈 수 있도록 tr로 각각 묶어준다. -->
					<tr>
					<!-- 글 제목을 작성할 수있는 input을 삽입 해준다. -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" /></td>
					</tr>
					<tr>
					<!-- 장문의 글을 작성 할 수있는 textarea태그를 이용해서 Content를 입력하도록 삽입한다. -->
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
 					<tr>
						<td><input type="file" name="ofile" id="ofile" onchange="checkSize(this); fileTypeCheck(this);"/>
					    <p style="color:red; text-align:left;">${errorMessage }</p></td>
					</tr> 
				</tbody>
			</table>
				<!-- 사용자에게 보여지는 글쓰기 버튼을 구현 -->	
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기"/>
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 화면 끝 -->	
	
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
	<script>
		document.getElementById('bbs').setAttribute('class', 'active');
	</script>
</body>
</html>