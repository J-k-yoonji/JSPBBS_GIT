package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardSession {
    public static String sessionChkStr(HttpServletRequest request) {
    	String sessionChkStr = "";
    	
    	HttpSession session = request.getSession();
 //   	HttpServletResponse response;

		//로그인한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null ;
		
//		boolean sNew = session.isNew();
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			System.out.println("true");
		} 
		//로그인 안한 경우에 로그인 페이지로 돌려보내 주는 java code 작성
		else {
			sessionChkStr += "<script>";
			sessionChkStr += "alert('로그인을 하세요.');";
			sessionChkStr += "location.href = 'login.jsp'";
			sessionChkStr += "</script>";
			System.out.println("false");
			System.out.println(sessionChkStr);
		}

        return sessionChkStr;
    }
}

