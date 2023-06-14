package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.MemberVO;

public class MemberDAO {
	
	private Connection conn; //자바와 데이터	베이스를 연결
	private PreparedStatement pstmt; //쿼리문 준비 및 실행
	private ResultSet rs; // 결과값 받아오기

	//MemberDAO가 실행되면 자동으로 생성되는 부분
	//데이터베이스 연결이 이뤄지게 해주는 코드. 메서드마다 반복되는 코드를 여기에 넣으면 코드간소화 가능
	/**
	 * DB연결 기본 생성자
	 */
	public MemberDAO() {
		try {
			//본인 컴퓨터의 3306포트에 연결된 board DB에 접속
			String dbURL = "jdbc:mariadb://localhost:3306/board";
			//해당 DB 접속 ID
			String dbID = "root";
			//해당 DB 접속 PW
			String dbPassword = "1234";
			//mysql에 접속할 수 있는 driver를 찾을수 있게 해주는 코드 driver라는건 mysql에 접속할 수 있도록 매개체 역할을 해주는 라이브러리이다.
			//강의버전보다 한참 높은 버전의 디비를 써서 드라이버 주소가 좀다름
			Class.forName("org.mariadb.jdbc.Driver");
			//드라이버매니저에 위에서 미리 작성한 DB연결 정보를 넣어 접속이 완료되면, conn객체안에 접속된 정보가 담기게 된다.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			System.out.println("DB연결");
		
		} catch (Exception e) {
			//오류의 내용을 내부 콘솔에 띄우기 위한 함수이다.
			e.printStackTrace();
		}
	}

	//위는 실제로 maraidb에 접속을 하게 해주는 부분, 이제 실제로 로그인을 시도하는 하나의 메서드 구현. userID,userPassword를 매개변수로 입력 받아 메서드 호출.
	public int login(String userID, String userPassword) {
		//이제 입력받은 userID 와 PW가 일치하는지 확인을 하기위해서 db내에서 userID 값에 대한 PW를 조회하는 쿼리를 넣어준다. *1.해킹방지를 위해 중간에 ?를 넣어놓고
		String SQL = "SELECT userPassword FROM tbl_user WHERE userID = ?";
		//try,catch문으로 예외처리를 해주고
		try {
			//pstmt에 어떠한 정해진 sql문장을 데이터베이스에 삽입하는 형식으로 인스턴스를 가져온다.
			pstmt = conn.prepareStatement(SQL); 
			//*2.쿼리 중 userID = ? 에 해당하는 부분에 입력받은 userID를 넣어주는 것이다. 그니까 바로 쿼리문으로 드가면 해킹틈 생기니까 setString으로 한번 거치고간다. 2말2야
			pstmt.setString(1, userID);
			//이렇게 db에 넣을 쿼리문 셋팅이 끝났다. 실행한 결과를 rs에다가 담아준다.
			rs = pstmt.executeQuery();
			//이제 결과의 존재 여부에 따른 행동을 실행시켜주는 부분을 만들어 보자, 아이디가 존재할때
			if (rs.next()) {
				//만약 rs에 들어있는 userPassword값과 db내부의 userPassword값이 일치하면 login성공!
				if (rs.getString(1).equals(userPassword))
					//login 성공시 리턴값
					return 1;
			 else 
				 //아니면 비밀번호 미일치로 실행될시 리턴값 
				return 0;
			}
			// 아이디가 없을때 리턴값 (쿼리문은 실행되었지만 SELECT 결과값 rs.next()은 아예 나오지 않은 경우)
			return -1;
		//그 외의 예상 불가 예외는 catch로 잡아준다.
		} catch (Exception e) {
			//해당 예외 출력
			e.printStackTrace();
		}
		// 데이터베이스 오류시 리턴값
		return -2;
	//로그인 처리 메서드 작성 끝. 이제 로그인 로직 처리 페이지 loginAction.jsp 작성하러가기.
	}
	
	
	/*
	 * 회원가입 기능
	 */
	public int join(MemberVO memberVO) {
		String SQL = "INSERT INTO tbl_user VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberVO.getUserID());
			pstmt.setString(2, memberVO.getUserPassword());
			pstmt.setString(3, memberVO.getUserName());
			pstmt.setString(4, memberVO.getUserGender());
			pstmt.setString(5, memberVO.getUserEmail());
			pstmt.setString(6, memberVO.getUserRegDate());
			pstmt.setString(7, memberVO.getUserModDate());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	//회원가입 처리 메서드 작성 끝. 이제 회원가입 로직 처리 페이지 joinAction.jsp 작성하러가기.
	}

}
