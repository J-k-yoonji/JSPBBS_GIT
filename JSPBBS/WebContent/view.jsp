<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %> 
<%@ page import="vo.BoardVO"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>    
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<% request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<!-- 장치별 화면 최적화 및 화면배율 설정 -->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0">
<!-- 루트폴더의 부트스트랩 참조 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판 글상세보기 화면</title>
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
<%= BoardSession.sessionChkStr(request)%>
<!-- 내비게이션 바  -->
	
	<!-- 게시판 글상세보기 화면 시작-->
	<%
		//로그인한 사람이라면	userID 라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값 (아래 수정/삭제 버튼은 해당글 작성자에게만 보여주기 위해)
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		//로그인 안한 경우에 로그인 페이지로 돌려보내 주는 java code 작성(BoardSession.java에 메서드 만들어두었으므로 삭제함.)
		//매개변수및 기본셋팅 처리 하는 부분
		int bbsID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("bbsID") != null) {
			//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}

		//해당글의 구체적인 내용을 BbsDAO 내부 만들었던 getBbs함수를 실행시켜주는 부분 
		BoardDAO boardDAO = new BoardDAO();
		BoardVO boardVO = boardDAO.getBoardVO(bbsID);
	%>

	<!-- 게시판 틀 -->
	<div class="container">
		<div class="row">
				<table class="table table-striped"
					style="text-align: left; border: 1px solid #dddddd">
					<thead>
						<tr>
							<!--테이블 제목 부분 구현 -->
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 게시판 글 보기 내부 1행 작성 -->
							<td style="width: 20%;"> 글 제목 </td>
							<td colspan="2">
							<% request.setAttribute("boardVO", boardVO); %>
							<c:set var="title" value="${boardVO.bbsTitle}"/>
							<c:out value="${title}"/>
							</td>
						</tr>
						<tr>
							<!-- 게시판 글 보기 내부 2행 작성 -->
							<td>작성자</td>	
							<td colspan="2"><%= boardVO.getUserID() %></td>
						</tr>
						<tr>
							<!-- 게시판 글 보기 3행 작성 -->
							<td>작성일</td>
							<!-- bbs페이지에서 db에서 일자를 가져오는 소스코드를 참고 하는데 다른점은 내부 글의 데이터니까 아까만든 인스턴스에서 가져온다. -->	
							<td colspan="2"><%= boardVO.getBbsRegDate().substring(0, 11) + boardVO.getBbsRegDate().substring(11, 13) + "시"
							+ boardVO.getBbsRegDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<!-- 마지막 행 내용 최소 높이를 200px; 지정-->
							<td>내용</td>	
							<!-- 들어갈 내용에 replaceAll을 사용해서 특수문자나 기호가 들어가도 정상 출력이 되게 해 주는 처리를 한다.
							replaceAll("공백","&nbsp;") 공백을 nbsp로 치환해서 출력해 줌 특수문자 치환을 넣어주면 크로스 브라우징 해킹방지도 가능하다.-->
							<td colspan="2" style="min-height: 200px; text-align: left;">
							<% String str = boardVO.getBbsContent().replaceAll(" ", "&nbsp;"); %>
							<% str = str.replaceAll("<","&lt;"); %>
							<% str = str.replaceAll(">", "&gt;"); %>
							<% str = str.replaceAll("\n","<br>"); %>
							<%= str %>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td><%= boardVO.getOfile() %><a href="Download.jsp?oName=<%= URLEncoder.encode(boardVO.getOfile(),"UTF-8") %>&sName=<%= URLEncoder.encode(boardVO.getSfile(),"UTF-8") %>">[다운로드]</a></td>
						</tr>
					</tbody>
				</table>
				<!-- 목록으로 돌아갈 수 있는 버튼을 테이블 외부에서 작성해준다. -->	
				<a href = "bbs.jsp" class="btn btn-primary">목록</a>
				
				<%
					//글작성자가 본인일시에만 수정,삭제 가능.(만약 사용자가 로그인한 상태이고, 사용자의 userID와  현재글 작성자의 UserID를 DB에서 들고와서 비교시 같을 경우) 
					if(userID != null && userID.equals(boardVO.getUserID())){
				%>
						<!-- 본인이라면 update.jsp에 bbsID를 가져갈 수 있게 해주고, 넘겨준다.-->
						<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-info">수정</a>
						<!-- 삭제는 페이지를 거치지않고 바로 실행될꺼기때문에 Action페이지로 바로 보내준다. -->
						<a onclick="return confirm('정말 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-danger">삭제</a>
				<%					
					}

				%>
		</div>
	</div>
	<!-- 게시판 글상세보기 화면 끝 -->	
	
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
	<script>
		document.getElementById('bbs').setAttribute('class', 'active');
	</script>
</body>
</html>