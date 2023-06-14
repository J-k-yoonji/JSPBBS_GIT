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
<title>메인 화면</title>
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
<body>
<jsp:include page="./include/nav.jsp" />
<!-- 네비게이션 바  -->
	
	<!-- 여기서 부터 메인화면-->
	<div class="container">
		<!-- 일반적으로 웹사이트를 소개하는 영역이 있는데 그것을 바로 jumbotron이라고 부른다, bootstrap에서 제공하는 요소이다. -->
		<div class="jumbotron">
			<!-- 공간의 제목 -->
			<h1>웹 사이트 소개</h1>
			<!-- 내용 -->
			<p> 안녕하세요, 웹사이트입니다.</p>
			<!-- p태그로 감싸서 a태그로 디자인용 button을 하나만든다. 하나쯤 있는게 이쁘기때문에. -->
			<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
		</div>
	</div>
	<!-- 사진을 넣을 공간을 div로 구현해 준다. -->
	<div class="container">
		<!-- 공간의id는 myCarousel = 사진첩이라고 할 수 있다. -->
		<div id="myCarousel" class="carousel slide" data-rid="carousel">
			<!-- ol태그는 번호를 앞에 붙여 목록을 만드는 형식이다. 지시자를 구현해 준다.-->
			<ol class="carousel-indicators">
				<!-- 넣을 이미지가 3개 이기때문에, 3개를 넣어주고 맨 처음보여줄 부분에 active를 붙여준다. -->
				<li data-target="#myCarousel" data-slice-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slice-to="1"></li>
				<li data-target="#myCarousel" data-slice-to="2"></li>
			</ol>
			<!-- 실질적으로 이미지가 들어 갈 수있는 부분을 구현해 준다.  -->
			<div class="carousel-inner">
				<!-- 현재 선택이 되어있는 사진을 보여준다, -->
				<div class="item active">
					<!-- images파일 안에있는 1이라는 사진을 가져온다 -->
					<img src="images/outdoor.jpg">
				</div>
				<div class="item">
					<img src="images/outdoor.jpg">
				</div>
				<div class="item">
					<img src="images/outdoor.jpg">
				</div>
			</div>
			<!-- 이제 사진을 양 옆으로 넘길 수 있는 버튼을 구현 해준다. -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<!-- 버튼 내에 이모티콘을 구현해 준다. -->
				<span class="glyphicon glyphicon-chevron-left"></span>
			<!-- 이러면 아이콘으로 된 버튼의 왼쪽으로 옮기는 버튼 구현이 끝났다. -->
			</a> 
			<a class="right carousel-control" href="#myCarousel" data-slide="next"> 
			<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
	<script>
		document.getElementById('main').setAttribute('class', 'active');
	</script>
</body>
</html>