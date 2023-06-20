<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %>     
<%@ page import="vo.BoardVO"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>      
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<% request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%= BoardSession.sessionChkStr(request)%>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}

		//로그인 안한 경우에 로그인 페이지로 돌려보내 주는 java code 작성(BoardSession.java에 메서드 만들어두었으므로 삭제함.)
		
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
		//현재 글의 'bbsID'에 대한 게시글을 가져온 다음, 세션을 통해 작성자 본인이 맞는지 체크한다.
		BoardVO boardVO = new BoardDAO().getBoardVO(bbsID);
		//userID는 세션에 있는 값이고, boardVO.getUserID는 이글을 작성한 사람의 값이다.
		if (userID == null || !userID.equals(boardVO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			//동일하지 않다면 알럿창을 출력하고 돌려보내준다.
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");				
		//성공적으로 권한이 있는사람이라면 넘어간다.
		}else {
			//update페이지에서 글제목과 글내용이 넘어오는 부분인데 넘어온 값이 null이거나 빈칸인지 분석을 해서
			//한번더 거치고 갈 수 있게 해준다.
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				//정상적으로 글이 입력되었을때 성공적으로 수정하게 해 주는 소스코드를 작성하자.
				BoardDAO boardDAO = new BoardDAO();
				//인스턴스에 update로 접근을 해서 안에 글번호,제목,내용이 들어갈 수있게 만들어주면 정상적으로 작동이 되게된다.
				int result = boardDAO.update(bbsID ,request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				//오류가 발생했을때 띄워줄 메세지
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//성공한경우 다시 게시판 메인화면으로 돌아갈 수 있게 해준다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 성공했습니다')");
					script.println("location.href='bbs.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>