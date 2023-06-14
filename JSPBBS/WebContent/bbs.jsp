<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!-- BbsDAO 함수를 사용하기때문에 가져오기 -->
<%@ page import="dao.BoardDAO" %>
<!-- DAO쪽을 사용하면 당연히 javaBeans도 사용되니 들고온다.-->
<%@ page import="vo.BoardVO" %>
<!-- ArrayList같은 경우는 게시판의 목록을 가져오기위해 필요한 것 -->
<%@ page import="java.util.ArrayList" %>    
<!-- 건너오는 모든 데이터를 UTF-8로 받기위해 설정 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
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
<!-- 내비게이션 바  -->
	
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
                	//게시글을 담을 인스턴스
                    BoardDAO boardDAO = new BoardDAO();
                	//list 생성 그 값은 현재의 페이지에서 가져온 리스트 게시글목록
                    ArrayList<BoardVO> list = boardDAO.getList();
                    //가져온 목록을 하나씩 출력하도록 선언한다..
                	for(int i = 0; i < list.size(); i++)
                    {
                %>
                <!-- 실제 데이터를 사용자에게 보여주는 부분 -->
                    <tr>
                    	<!-- 현재의 게시글에 대한 정보를 하나씩 데이터를 데이터베이스에서 불러와서 보여준다. -->
                        <td><%=list.get(i).getBbsID() %></td>
                        <!-- 제목을 눌렀을때는 해당 게시글의 내용을 보여주는 페이지로 이동해야하기때문에
                         view.jsp페이지로 해당 게시글번호를 매개변수로 보내서 처리한다. href="주소?변수명 = 값! 이런식으로 처리를 해준다.-->
                        <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
                        <td><%=list.get(i).getUserID() %></td>
                        <td><%=list.get(i).getBbsViewcount() %></td>
                        <!--날짜 데이터를 가져오는것은 substring(index,index) 함수는 DB내부에서 필요한 정보만 잘라서 들고오게 해 주는 함수-->
                        <td><%=list.get(i).getBbsRegDate().substring(0,11) + list.get(i).getBbsRegDate().substring(11, 13) + "시" 
                        + list.get(i).getBbsRegDate().substring(14,16) + "분" %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>       
            <!-- 테이블 자체는 글의 목록을 보여주는 역할뿐. 글을 작성할 수 있는 화면으로 넘어갈 수 있게 버튼 추가 -->
            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
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