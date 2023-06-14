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
	
	<!-- 회원가입 양식 시작-->
	<div class="container"> 
		<div class="col-lg-4"></div>
		<!-- 로그인 폼 작성 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<!-- 성별 선택 추가 -->
					<div class="form-group" style="text-align: center;">
						<!-- 버튼 공간을 따로 마련해준다.(남,녀) -->
						<div class="btn-group" data-toggle="buttons">
							<!-- 선택이 된곳에 표시를 하는 active를 설정해준다. -->
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자 
							</label>
						</div>
					<!-- 성별 선택부분 완료 -->
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
					</div>
					<!-- 로그인 버튼 구현 -->
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>	
			</div>	
		</div>
	</div>
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>