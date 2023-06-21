<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.BoardSession" %>     
<%@ page import="utils.FileUtil" %>     
<%@ page import="vo.BoardVO"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>      
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<!-- 하나의 게시글 정보를 담을 수 있게 Bbs자바빈즈를 사용-->
<% BoardVO boardVO = new BoardVO(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

    // 파일 업로드 외 처리 
    // 수정된 첨부파일 내용을 매개변수에서 얻어옴
    String prevOfile = mr.getParameter("prevOfile");
    String prevSfile = mr.getParameter("prevSfile");
    
    String bbsTitle = mr.getParameter("bbsTitle");
    String bbsContent = mr.getParameter("bbsContent");
    
    
    
    // 2. 새로운 파일명 생성
//    String fileName = mr.getFilesystemName("ofile");  // 현재 파일 이름
//    String ext = fileName.substring(fileName.lastIndexOf("."));  // 파일 확장자
//    String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
//    String newFileName = now + ext;  // 새로운 파일 이름("업로드일시.확장자")

    // 3. 파일명 변경
//    File oldFile = new File(saveDirectory + File.separator + fileName);
//    File newFile = new File(saveDirectory + File.separator + newFileName);
//    oldFile.renameTo(newFile);

    int bbsID = 0;
    // 4. 다른 폼값 받기
	//update페이지에서 넘겨준 bbsID를 들고오는 소스 코드
	if (mr.getParameter("bbsID") != null) {
		//받은 bbsID를 정수형으로 반환해서 bbsID 인스턴스에 저장    
   		bbsID = Integer.parseInt(mr.getParameter("bbsID"));
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
	
    // 5. VO 생성
    boardVO.setBbsID(bbsID);
    boardVO.setBbsTitle(bbsTitle);
    boardVO.setBbsContent(bbsContent);

    // 원본 파일명과 저장된 파일 이름 설정
    String fileName = mr.getFilesystemName("ofile");
    if (fileName != null) {
        // 첨부 파일이 있을 경우 파일명 변경
        System.out.println("새로운 첨부 파일이 있을 경우");
        // 새로운 파일명 생성
        String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
        String ext = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = now + ext;

        // 파일명 변경
        File oldFile = new File(saveDirectory + File.separator + fileName);
        File newFile = new File(saveDirectory + File.separator + newFileName);
        oldFile.renameTo(newFile);

        // DTO에 저장
        boardVO.setOfile(fileName);  // 원래 파일 이름
        boardVO.setSfile(newFileName);  // 서버에 저장된 파일 이름
        System.out.println("fileName : " + fileName);
        

        // 해당 bbsID에 기존 첨부파일 존재시 삭제!
        // 기존 파일 삭제
        FileUtil.deleteFile(request, "/Uploads", prevSfile);
        
    }
    else {
        // 첨부 파일이 없으면 기존 이름 유지
        System.out.println("새로운 첨부 파일이 없을 경우");
        System.out.println("prevOfile : " + prevOfile);
        boardVO.setOfile(prevOfile);
        boardVO.setSfile(prevSfile);
    }

    //
    // 6. DAO를 통해 데이터베이스에 반영
    BoardDAO boardDAO = new BoardDAO();
    boardDAO.updateFileBbs(boardVO);

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