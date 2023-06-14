<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.MemberVO"%>
<!-- 우리가 만든 페이지를 사용하기 위한 임폴트 -->
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 현재 페이지에서만 bean이 사용가능하게 해주는태그 -->
<jsp:useBean id="memberVO" class="vo.MemberVO" scope="session" />
<!-- 회원가입에는 javaBeans에 작성된 5가지 변수를 다 받아야 하기때문에 선언해준다.-->
<!-- jsp:useBean 의 id 속성값 "memberVO" -->
<jsp:setProperty name="memberVO" property="userID" />
<jsp:setProperty name="memberVO" property="userPassword" />
<jsp:setProperty name="memberVO" property="userName" />
<jsp:setProperty name="memberVO" property="userGender" />
<jsp:setProperty name="memberVO" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판</title>
</head>
<body>
	<%
	// 현재 세션 상태 체크
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	//
/* 	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}	 */
	
	//입력 안된 부분이 있을 시 회원가입 시에 사용자가 입력을 안한 모든 경우의 수를 입력해서 조건을 걸어주고,
	// jsp:useBean 의 id 속성값 "memberVO"
	if (memberVO.getUserID() == null || memberVO.getUserPassword() == null || memberVO.getUserName() == null
			|| memberVO.getUserGender() == null || memberVO.getUserEmail() == null) {
		//PrintWriter를 이용해서
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//팝업을 띄워주고,
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		//다시 돌려보낸다.
		script.println("history.back()");
		script.println("</script>");
	//입력이 다 되었다면?
	} else {
		//MemberDAO에서 만들었던 함수를 사용하기 위해서 인스턴스 생성
		MemberDAO memberDAO = new MemberDAO();
		//memberDAO에 있는 join함수 내의 각각의 변수들을 다입력 받아서 만들어진 memberVO인스턴스가 join함수를 실행하도록 명령으로 넣어준것이다.
		int result = memberDAO.join(memberVO);
		//이 경우는 이미 해당아이디가 존재하는 경우밖에 없다. PRIMARY KEY로 userID를 줬기때문에,
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			//회원가입 성공 시 세션을 부여하는 코드. (이후 각각 보여지는 화면이 다르게 함)
			session.setAttribute("userID", memberVO.getUserID());
			session.setAttribute("userName", memberVO.getUserName());
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			//회원가입 성공, 메인페이지로 이동.
			script.println("alert('회원가입 성공!');");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>