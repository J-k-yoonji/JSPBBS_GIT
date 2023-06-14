<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.MemberVO"%>
<!-- 앞서 만들었던 dao.MemberDAO의 객체를 사용하기위해 선언 -->
<%@ page import="dao.MemberDAO" %>
<!-- 자바스크립트 문장을 작성하게해주는 내부라이브러리-->
<%@ page import="java.io.PrintWriter" %>
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 로그인 페이지에서 넘겨준 MemberVO정보를 받아서, 한명의 회원정보를 담기위해 전에만든 자바빈즈 클래스를 사용하게 해주는 액션태그 --> 
<!-- 자바빈즈가 저장될 영역을 session으로 설정해 사용자가 웹브라우저를 닫을때까지 정보사용을 선언-->
<jsp:useBean id="memberVO" class="vo.MemberVO" scope="session" /> 
<!-- 위에서 생성한 자바빈즈에 아래의 방식으로 멤버변수(property) 값을 설정. login.jsp의 폼의 name과 일치시켜주기 -->
<!-- 이렇게 하면  login.jsp의 폼을 통해 loginAction.jsp 안으로 전송된 폼값 데이터들이 자바빈즈에 저장된다! -->
<jsp:setProperty name = "memberVO" property = "userID" />
<jsp:setProperty name = "memberVO" property = "userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 처리 페이지</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
/* 		
		if (userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		 */
				
		//이제 넘어온 userID와 PW 값을 memberVO에서 꺼내서  memberDAO.login 메서드를 호출하는 데에 사용해보자. MemberDAO인스턴스 생성
		MemberDAO memberDAO = new MemberDAO();
		//memberDAO 에서 만들었던 login(userID,userPW)메서드를 실행하고, 그 리턴값을 result에 담는다.
		int result = memberDAO.login(memberVO.getUserID(), memberVO.getUserPassword());
		//login메서드에서 return값이 1이라면 
		if (result == 1){
			//로그인 성공 시 세션을 부여하는 코드. (이후 각각 보여지는 화면이 다르게 함)
			session.setAttribute("userID", memberVO.getUserID());
			session.setAttribute("userName", memberVO.getUserName());
			//하나의 스크립트 문장을 넣어줄 수있도록 한다.
			PrintWriter script = response.getWriter();
			//println으로 접근해서 스크립트 문장을 유동적으로 실행 할 수 있게한다.
			script.println("<script>");
			script.println("alert('로그인 성공!');");
			//메인 페이지로 넘겨주는 선언을 해주고,
			script.println("location.href = 'main.jsp'");
			//스크립트 태그를 닫아준다.
			script.println("</script>");
		}
		//비밀번호가 틀릴때
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.');");
			//이전 페이지로 사용자를 다시 돌려보내는 함수이다.
			script.println("history.back()");
			script.println("</script>");
		}
		//아이디가 없을때
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.');");
			script.println("history.back()");
			script.println("</script>");
		}
		//db연결 오류
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
</body>
</html>