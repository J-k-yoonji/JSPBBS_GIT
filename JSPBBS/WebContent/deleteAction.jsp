<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %>     
<%@ page import="vo.BoardVO"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>          
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>
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
		if (session.getAttribute("userID") != null) { //userID 이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID"); //userID에 해당 세션값을 넣어준다.
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
		if ( userID == null || !userID.equals(boardVO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			//동일하지 않다면 알럿창을 출력하고 돌려보내준다.
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");				
		//성공적으로 권한이 있는사람이라면 넘어간다.
		} else {
			try {
				String saveDirectory = application.getRealPath("/Uploads");  // 저장할 디렉터리
				BoardDAO boardDAO = new BoardDAO();

				String filename = boardDAO.getFileName(bbsID);
				
			    // 1. File 객체 생성
			    File file = new File(saveDirectory + File.separator + filename);
			    
			    // 해당 bbsID에 첨부파일 존재시 같이 삭제! 
				if (file.exists()) {
					file.delete();
				}
			    
				// 해당 bbsID에 관한 정보 모두 삭제!
				int result = boardDAO.delete(bbsID);
				
				//인스턴스에 update로 접근을 해서 안에 글번호,제목,내용이 들어갈 수있게 만들어주면 정상적으로 작동이 되게된다.
//				int result = boardDAO.delete(bbsID);
	
				//삭제 실패시
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//성공한경우 다시 게시판 메인화면으로 돌아갈 수 있게 해준다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 성공했습니다')");
					script.println("location.href='bbs.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
			catch (Exception e) {
			    e.printStackTrace();
			    request.setAttribute("errorMessage", "파일 업로드 오류");
			    request.getRequestDispatcher("write.jsp").forward(request, response);
			}
		
		}
	%>
</body>
</html>