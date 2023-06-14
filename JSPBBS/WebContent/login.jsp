<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 장치별 화면 최적화 및 화면배율 설정 -->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0">
<!-- 루트폴더의 부트스트랩 참조 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>로그인 창</title>
</head>
<body>
<jsp:include page="./include/nav.jsp" />
<!-- 네비게이션 바  -->
	
	<!--<2> : 여기서 부터 로그인 양식. div:하나의 컨테이너처럼 감싸주는 역할 -->
	<div class="container"> 
		<div class="col-lg-4"></div>
		<!-- 로그인 폼 작성 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- form 삽입. post는 회원가입이나 로그인같이 어떠한 정보값을 숨기면서 보내는 메소드. loginAction.jsp 페이지로 사용자가 작성한 정보를 보내도록 함 -->
				<form method="post" action="loginAction.jsp">
					<!-- 로그인 페이지 내부의 문장 가운데 정렬로 삽입 -->
					<h3 style="text-align: center;">로그인 화면</h3>
					<!-- 아이디 입력 공간 구현 -->
					<div class="form-group">
						<!-- name="userID"쪽은 나중에 서버프로그램을 작성할때 사용하기때문에 대소문자구별 -->
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<!-- 패스워드 입력 공간 구현 -->
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<!-- 로그인 버튼 구현 -->
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>	
			</div>	
		</div>
		<!-- 왜 넣어줄까 2 -->
		<div class="col-lg-4"></div>
	</div>
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>