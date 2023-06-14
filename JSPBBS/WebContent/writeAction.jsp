<!-- 실제로 글쓰기를 눌러서 글을 작성해 주는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 게시글을 작성할 수 있는 데이터베이스는 BbsDAO객체를 이용해서 다룰수 있기때문에 참조 -->	
<%@ page import="dao.BoardDAO"%>
<!-- bbsdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>
<!-- 하나의 게시글 정보를 담을 수 있게 Bbs자바빈즈를 사용-->
<jsp:useBean id="boardVO" class="vo.BoardVO" scope="page" />
<!-- 하나의 게시글 인스턴스 구현 -->
<jsp:setProperty name="boardVO" property="bbsTitle" />
<jsp:setProperty name="boardVO" property="bbsContent" />
<%
	System.out.println(boardVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 처리</title>
</head>
<body>
	<%
	    //현재 세션 상태 체크
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		//로그인한 사람만 글을 쓸 수 있도록 함
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			//로그인 안된 사람들은 로그인 페이지로 이동
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			//로그인한 사람들의 경우, 입력이 안 된 부분이 없는지 체크
			if (boardVO.getBbsTitle() == null || boardVO.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				//실제로 데이터 베이스에 등록을 해준다 boardDAO 인스턴스를 만들고,
				BoardDAO boardDAO = new BoardDAO();
				//write메서드를 호출,실행하여 실제로 게시글을 작성 할 수 있게 한다. userID
				int result = boardDAO.write(boardVO.getBbsTitle(), userID, boardVO.getBbsContent());
				//만약에 함수에 반환된 값이 -1라면 DB오류 발생이니까
				if (result == -1) {
					//실패했다고 알려준다
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//성공적으로 글을 작성했다면 게시판 목록화면 bbs.jsp으로 보낸다
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 성공했습니다')");
					script.println("location.href='bbs.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>