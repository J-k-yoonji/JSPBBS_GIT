<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardPage" %>    
<%@ page import="utils.BoardSession" %>    
<%@ page import="java.io.PrintWriter" %>
<!-- BbsDAO 함수를 사용하기때문에 가져오기 -->
<%@ page import="dao.BoardDAO" %>
<!-- DAO쪽을 사용하면 당연히 javaBeans도 사용되니 들고온다.-->
<%@ page import="vo.BoardVO" %>
<!-- ArrayList같은 경우는 게시판의 목록을 가져오기위해 필요한 것 -->
<%@ page import="java.util.ArrayList" %>    
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<% request.setCharacterEncoding("UTF-8"); %>
  
<!-- 페이징관련 처리 코드 -->

<%//게시글을 담을 인스턴스
BoardDAO boardDAO = new BoardDAO(); %>



<%
	int totalCount = boardDAO.getTotal();  // 총 게시물 수 확인
	
	/*** 페이지 처리 start ***/
	// 전체 페이지 수 계산.
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE")); //한 화면에 출력할 게시물 개수
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK")); //한 화면에 출력할 페이지 번호 블록 개수
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); //전체 페이지 수. 올림. 
	
	// 현재 페이지 확인
	int pageNum = 1;  // 현재페이지 번호. 기본값 1로 설정.
	String pageTemp = request.getParameter("pageNum");
	if (pageTemp != null && !pageTemp.equals(""))
	    pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
	
	// 목록에 출력할 게시물 범위 계산
	int start = (pageNum - 1) * pageSize + 1;  // 첫 게시물 번호
	int end = pageNum * pageSize; // 마지막 게시물 번호
/*  	startRow = param.put("start", start);  */
/* 	pageSize = param.put("end", end); */
	/*** 페이지 처리 end ***/
%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<!-- 장치별 화면 최적화 및 화면배율 설정 -->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=3.0">
<!-- 루트폴더의 부트스트랩 참조 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판 목록</title>
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

<%-- <% String sessionChkStr = BoardSession.sessionChkStr(request); 
<%= sessionChkStr %> --%>

<!-- 내비게이션 바  -->
			<!-- 게시판 글목록 bbs.jsp 클릭했을 경우 시작-->
<%-- 	<%
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
	%> --%>

	<!-- 여기서 부터 게시판 목록화면-->
    <div class="container">
        <!-- 테이블이 들어갈 수 있는 공간 -->
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">제목</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성자</th>
                        <th style="background-color:#eeeeee; text-align:center;">조회수</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                <!--임시 데이터 삭제 후 아래와 같이 수정 -->
                <%

                	//list 생성 그 값은 현재의 페이지에서 가져온 리스트 게시글목록
                    ArrayList<BoardVO> list = boardDAO.getListPage(start, pageSize);
                    //가져온 목록을 하나씩 출력하도록 선언한다..
/*                 	for(int i = 0; i < list.size(); i++) */
                    for (BoardVO boardVO : list)
                    {
                %>
                <% 
/*                 request.setAttribute("list", list);  */
                   request.setAttribute("boardVO", boardVO);
                %>
                <c:set var="title" value="${boardVO.bbsTitle}"/>
                <!-- 실제 데이터를 사용자에게 보여주는 부분 -->
                    <tr>
                    	<!-- 현재의 게시글에 대한 정보를 하나씩 데이터를 데이터베이스에서 불러와서 보여준다. -->
                        <td><%=boardVO.getBbsID() %></td>
                        <!-- 제목을 눌렀을때는 해당 게시글의 내용을 보여주는 페이지로 이동해야하기때문에
                         view.jsp페이지로 해당 게시글번호를 매개변수로 보내서 처리한다. href="주소?변수명 = 값! 이런식으로 처리를 해준다.-->
                        <td><a href="view.jsp?bbsID=<%=boardVO.getBbsID()%>"><c:out value="${title}"/></a>
                        </td>
<%--                         <td><a href="view.jsp?bbsID=<%=boardVO.getBbsID()%>"><%=boardVO.getBbsTitle() %><c:out value="${title}"/></a>
                        </td> --%>
                        <td><%=boardVO.getUserID() %></td>
                        <td><%=boardVO.getBbsViewcount() %></td>
                        <!--날짜 데이터를 가져오는것은 substring(index,index) 함수는 DB내부에서 필요한 정보만 잘라서 들고오게 해 주는 함수-->
                        <td><%=boardVO.getBbsRegDate().substring(0,11) + boardVO.getBbsRegDate().substring(11, 13) + "시" 
                        + boardVO.getBbsRegDate().substring(14,16) + "분" %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table> 
            <!--페이징 처리-->
            <div width="90%" style="text-align:center;">
                <%= BoardPage.pagingStr(totalCount, pageSize,blockPage, pageNum, request.getRequestURI()) %>  
                            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
            </div>
                  
            <!-- 테이블 자체는 글의 목록을 보여주는 역할뿐. 글을 작성할 수 있는 화면으로 넘어갈 수 있게 버튼 추가 -->

        </div>
    </div>
	
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
	<script>
		document.getElementById('bbs').setAttribute('class', 'active');
	</script>
</body>
</html>