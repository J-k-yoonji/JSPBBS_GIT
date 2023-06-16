<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %>     
<%@ page import="vo.BoardVO"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 장치별 화면 최적화 및 화면배율 설정 -->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0">
<!-- 루트폴더의 부트스트랩 참조 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판 글수정 화면</title>
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
<!-- 내비게이션 바  -->
<%= BoardSession.sessionChkStr(request)%>
		<!-- 게시판 글수정 화면 시작-->
	<%
		//로그인한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} 
		//로그인 안한 경우에 로그인 페이지로 돌려보내 주는 java code 작성
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		//view페이지에서 넘겨준 bbsID를 들고오는 소스 코드
		if (request.getParameter("bbsID") != null) {
			//받은 bbsID를 정수형으로 반환해서 bbsID 인스턴스에 저장
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		//bbsID가 제대로 들어오지 않았다면,
		if (bbsID == 0) {
			//다시 게시판 메인 페이지로 돌려보낸다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		//현재 작성한 글이 작성자가 일치하는지 확인해주는 소스코드 작성
		//만약 userID와 뷰페이지에서 넘겨받은 bbsID값을 가지고 해당 글을 가져온 후
		BoardVO boardVO = new BoardDAO().getBoardVO(bbsID);
		//실제로 이 글의 작성자가 일치하는지 비교해준다. userID는 세션에 있는 값이고, bbs.getUserID는 이글을 작성한 사람의 값이다.
		if (!userID.equals(boardVO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			//동일하지 않다면 오류를 출력해 돌려보내준다.
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");				
		}
	%>
	
	<!-- 게시판 글쓰기화면 시작-->
	<div class="container">
		<!-- bbs에서 만든 양식 참조 사용 -->
		<div class = "row">
		<!-- form -->
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
				<thead>
					<tr>
						<!-- colspan="2" 현재의 속성이 2개의 열을 차지하게 해준다. -->
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 제목과 글 작성이 각각 한줄로 들어갈 수 있도록 tr로 각각 묶어준다. -->
					<tr>
					<!-- 글 제목을 작성할 수있는 input을 삽입 해준다. -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"
								value="<%=boardVO.getBbsTitle()%>"></td>
					</tr>
					<tr>
					<!-- 장문의 글을 작성 할 수있는 textarea태그를 이용해서 Content를 입력하도록 삽입한다. -->
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" 
								style="height: 350px;"><%=boardVO.getBbsContent()%></textarea></td>
					</tr>
				</tbody>
			</table>
				<!-- 수정완료 버튼을 생성 -->	
				<input type="submit" class="btn btn-primary pull-right" value="수정완료"/>
			</form>
		</div>
	</div>
	<!-- 게시판 글수정 화면 끝 -->	
	
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
	<script>
		document.getElementById('bbs').setAttribute('class', 'active');
	</script>
</body>
</html>