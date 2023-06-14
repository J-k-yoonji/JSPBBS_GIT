<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.MemberVO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃 처리 페이지</title>
</head>
<body>
	    <%	// 현재 logoutAction 페이지로 온 회원의 세션을 빼앗도록 만들어 로그아웃 시켜준다.
		session.invalidate();		
		%>
		<script>
			//그 후 main.jsp로 돌려보내 주면 끝이다.
			location.href= 'main.jsp';
		</script>
</body>
</html>