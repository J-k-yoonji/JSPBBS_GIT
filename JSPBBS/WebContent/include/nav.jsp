<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내비게이션 바</title>
</head>
<body>
	<%
	// 세션 상태를 체크해서 각각 보여지는 내비게이션 화면이 다르게 함.
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<!-- 내비게이션 구현-웹사이트의 전반적인 구성을 보여줌. default: 밝은 색 -->
	<nav class="navbar navbar-default">
		<!-- header부분 먼저 구현:홈페이지의 로고 등을 담는 영역 -->
		<div class="navbar-header">
			<!-- <1>:웹사이트 외형 상의 제일 좌측 버튼을 생성해줌. data-target= 데이터 타겟명을 지정 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-exmaple="false">
		<!-- 이건 모바일 화면으로 볼때, 요약된 메뉴 목록에 줄을 그려주는 디자인적부분 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 웹페이지의 로고 글자 지정. 클릭 시 main.jsp로 이동하게 해줌 -->
			<a class="navbar-brand" href="main.jsp">JSP게시판</a>
		</div>
		<!-- 여기서 <1>에 만든 버튼 내부의 데이터 타겟명과 div의 id가 일치해야함 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- div 내부의 ul은 하나의 어떠한 리스트를 보여줄때 사용 -->
			<ul class="nav navbar-nav">
				<!-- 리스트 내부 li안에 a태그로 링크를 넣어 클릭시 메인으로 이동하게 함 -->
				<li id="main" ><a href="main.jsp">메인</a></li>
				<!-- 게시판으로 이동하게 만든다 -->
				<li id="bbs" class=""><a href="bbs.jsp">게시판목록</a></li>
			</ul>
			<!-- ul 리스트 하나 더 생성: 웹페이지 화면에서 우측 부분-->
<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<!-- 해당 페이지로 이동 후 세션해지 후 main화면으로 링크 -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>	
			<!-- 이런식으로 세션 관리를 해서 회원 상태에 따라서 보여줄것과 안보여줄것을 분리 할 수있음. -->
		</div>
		<!-- 내비게이션 바 구성 끝 -->
	</nav>
</body>
</html>