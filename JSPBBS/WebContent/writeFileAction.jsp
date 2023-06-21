<!-- 실제로 글쓰기를 눌러서 글을 작성해 주는 페이지 -->
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %> 	
<%@ page import="vo.BoardVO"%>	
<%@ page import="dao.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>
<!-- 하나의 게시글 정보를 담을 수 있게 Bbs자바빈즈를 사용-->
<% BoardVO boardVO = new BoardVO(); %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 처리</title>
</head>
<body>
<%= BoardSession.sessionChkStr(request)%>
<%
String saveDirectory = application.getRealPath("/Uploads");  // 저장할 디렉터리
int maxPostSize = 30 * 1024 * 1024;  // 파일 최대 크기(30MB)
String encoding = "UTF-8";  // 인코딩 방식

//현재 세션 상태 체크
String userID = null;
if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
	userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
}

try {
    // 1. MultipartRequest 객체 생성
    MultipartRequest mr = new MultipartRequest(request, saveDirectory,
                                               maxPostSize, encoding);

    // 2. 새로운 파일명 생성
    String fileName = mr.getFilesystemName("ofile");  // 현재 파일 이름
    String ext = fileName.substring(fileName.lastIndexOf("."));  // 파일 확장자
    String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    String newFileName = now + ext;  // 새로운 파일 이름("업로드일시.확장자")

    // 3. 파일명 변경
    File oldFile = new File(saveDirectory + File.separator + fileName);
    File newFile = new File(saveDirectory + File.separator + newFileName);
    oldFile.renameTo(newFile);

    // 4. 다른 폼값 받기
    String bbsTitle = mr.getParameter("bbsTitle");
    String bbsContent = mr.getParameter("bbsContent");

    // 5. DTO 생성
    boardVO.setBbsTitle(bbsTitle);
    boardVO.setOfile(fileName);
    boardVO.setSfile(newFileName);

    // 6. DAO를 통해 데이터베이스에 반영
    BoardDAO boardDAO = new BoardDAO();
    boardDAO.writeFileBbs(bbsTitle, userID, bbsContent, fileName, newFileName);

    // 7. 파일 목록 JSP로 리디렉션
    response.sendRedirect("bbs.jsp");
}
catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "파일 업로드 오류");
    request.getRequestDispatcher("write.jsp").forward(request, response);
}
%>
</body>
</html>