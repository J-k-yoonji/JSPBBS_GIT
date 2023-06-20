package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import vo.BoardVO;

public class BoardDAO {
	
	private Connection conn; 
	private ResultSet rs;

	public BoardDAO() {
		try {
			String dbURL =  "jdbc:mariadb://localhost:3306/board";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	//실제로 글을 작성하는 write메서드.  Title,ID,Content 값을 받아와 메서드를 실행시킨다.
	public int write(String bbsTitle, String userID, String bbsContent) { 
		int result = 0;
		//BBS 테이블에 들어갈 인자 6개를 ?로 선언 해준다.
		String SQL = "INSERT INTO tbl_bbs (bbsTitle, userID, bbsContent) VALUES(?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext());
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, bbsContent);
			//INSERT같은 경우에는 성공했을때 0이상의 값을 반환하기 때문에 return을 이렇게 작성해준다.
			result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//데이터베이스 오류
		return -1; 
	}
	
	// 파일첨부 + 실제로 글을 작성하는 writeFileBbs메서드.  Title,ID,Content, ofile, sfile 값을 받아와 메서드를 실행시킨다.
	public int writeFileBbs(String bbsTitle, String userID, String bbsContent, String ofile, String sfile) { 
		int result = 0;
		//BBS 테이블에 들어갈 인자 6개를 ?로 선언 해준다.
		String SQL = "INSERT INTO tbl_bbs (bbsTitle, userID, bbsContent, ofile, sfile) VALUES(?, ?, ?, ? ,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext());
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, bbsContent);
			pstmt.setString(4, ofile);
			pstmt.setString(5, sfile);
			//INSERT같은 경우에는 성공했을때 0이상의 값을 반환하기 때문에 return을 이렇게 작성해준다.
			result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {			
			e.printStackTrace();
		}
		//데이터베이스 오류
		return -1; 
	}
	
	//글 목록 가져오는 getList 메서드. ArrayList<BoardVO>에 글정보들을 담아 반환해줌.
	public ArrayList<BoardVO> getList() {
		//BoardVO 클래스에서 나오는 인스턴스를 보관할 수 있는 list를 하나만들어서 new ArrayList<BoardVO>();를 담아준다.
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		//최신글이 제일 위로 오도록 정렬.
		String SQL = "SELECT * FROM tbl_bbs ORDER BY bbsID DESC ";
		try { 
			Statement stmt = conn.createStatement(); // 쿼리문을 실행하기 위해 Statement객체 생성.
			rs = stmt.executeQuery(SQL); // SELECT쿼리문을 실행시 사용, 실행결과는 ResultSet객체로 반환
			
			//반복해서 커서를 이동시켜 rs.next()에 결과값이 있을 경우, 결과값들을 한행씩 boardVO 인스턴스에 저장.
			while(rs.next()) {
				//결과값을 담을 boardVO 인스턴스 생성
				BoardVO boardVO = new BoardVO();
				//만든 boardVO인스턴스 안에 쿼리문을 실행한 결과 데이터인 rs의 값들을 다 담아서
				boardVO.setBbsID(rs.getInt("bbsID")); //글 고유번호
				boardVO.setBbsTitle(rs.getString("bbsTitle")); //글제목
				boardVO.setUserID(rs.getString("userID")); //글작성자아이디
				boardVO.setBbsContent(rs.getString("bbsContent")); //글내용
				boardVO.setBbsRegDate(rs.getString("bbsRegDate")); //글작성일
				boardVO.setBbsViewcount(rs.getInt("bbsViewcount")); //글조회수

				//게시글데이터가 한행씩 담긴 boardVO인스턴스를 메서드 반환값인 list(글전체 목록)에 담아준다.
				list.add(boardVO);
				System.out.println("getList 호출1 : " + boardVO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//게시글 전체 목록을 출력한다.
		System.out.println("getList 호출2 : " + list);
		return list;
	}
	
	// 전체 게시글 수 구하는 메서드
	public int getTotal() {
		int result = 0;
		
		String SQL = "SELECT COUNT(*) AS total FROM tbl_bbs ";
		
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			
			if(rs.next()) {
				result = rs.getInt("total");
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return result;
	}
	
	// 페이징 + 글 목록 가져오는 getList 메서드. ArrayList<BoardVO>에 글정보들을 담아 반환해줌.
	public ArrayList<BoardVO> getListPage(int startRow, int pageSize) {
		//BoardVO 클래스에서 나오는 인스턴스를 보관할 수 있는 list를 하나만들어서 new ArrayList<BoardVO>();를 담아준다.
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		//최신글이 제일 위로 오도록 정렬. 0,4 : 1번쨰 레코드부터 4개!
		String SQL = "SELECT * FROM tbl_bbs ORDER BY bbsID DESC  LIMIT ?, ? "; 
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 쿼리문을 실행하기 위해 Statement객체 생성.
			
			pstmt.setInt(1, startRow -1 ); // 시작행-1 (시작 row 인덱스 번호)
			pstmt.setInt(2, pageSize); // 페이지크기 (한번에 출력되는 수)
			
			rs = pstmt.executeQuery(); // SELECT쿼리문을 실행시 사용, 실행결과는 ResultSet객체로 반환
			
			//반복해서 커서를 이동시켜 rs.next()에 결과값이 있을 경우, 결과값들을 한행씩 boardVO 인스턴스에 저장.
			while(rs.next()) {
				//결과값을 담을 boardVO 인스턴스 생성
				BoardVO boardVO = new BoardVO();
				//만든 boardVO인스턴스 안에 쿼리문을 실행한 결과 데이터인 rs의 값들을 다 담아서
				boardVO.setBbsID(rs.getInt("bbsID")); //글 고유번호
				boardVO.setBbsTitle(rs.getString("bbsTitle")); //글제목
				boardVO.setUserID(rs.getString("userID")); //글작성자아이디
				boardVO.setBbsContent(rs.getString("bbsContent")); //글내용
				boardVO.setBbsRegDate(rs.getString("bbsRegDate")); //글작성일
				boardVO.setBbsViewcount(rs.getInt("bbsViewcount")); //글조회수
				
				//게시글데이터가 한행씩 담긴 boardVO인스턴스를 메서드 반환값인 list(글전체 목록)에 담아준다.
				list.add(boardVO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//게시글 전체 목록을 출력한다.
		return list;
	}
	
	
	//하나의 게시글을 보여주는 메서드. 매개변수로 넘어온 'bbsID'에 데이터가 존재한다면 그 데이터에 맞는 'BoardVO'인스턴스를 생성하고 해당 내용들을 모두 불러와 정보를 리턴해주는 메서드. 
	public BoardVO getBoardVO(int bbsID) {
		//하나의 게시글데이터(반환값)을 담을 boardVO 인스턴스 생성
		BoardVO boardVO = new BoardVO(); 
		//쿼리문 준비
		String SQL = "SELECT * FROM tbl_bbs " + " WHERE bbsID = ? ";
		
		try {
			// 물음표 (인파라미터)있는 쿼리 실행 시 사용!
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // 여기()안은 꼭 비워둘 것!
			
			//  커서를 이동시켜 rs.next()에 결과값이 있을 경우 결과값들을 한행씩 boardVO 인스턴스에 저장. (반복은x)
			if(rs.next()) {
				//만든 boardVO인스턴스 안에 쿼리문을 실행한 결과 데이터인 rs의 값들을 다 담아서
				boardVO.setBbsID(rs.getInt("bbsID")); //글 고유번호
				boardVO.setBbsTitle(rs.getString("bbsTitle")); //글제목
				boardVO.setUserID(rs.getString("userID")); //글작성자아이디
				boardVO.setBbsContent(rs.getString("bbsContent")); //글내용
				boardVO.setOfile(rs.getString("Ofile")); //글내용
				boardVO.setSfile(rs.getString("Sfile")); //글내용
				boardVO.setBbsRegDate(rs.getString("bbsRegDate")); //글작성일
				boardVO.setBbsViewcount(rs.getInt("bbsViewcount")); //글조회수
				


				System.out.println("getBoardVO 호출 : " + boardVO);

				//해당 bbsID의 글정보가 담긴 boardVO인스턴스를 반환.
				return boardVO;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//해당글이 (bbsID가) 존재하지 않으면 null반환.
		return null;
	}
	
	// 특정한 번호의 매개변수로 들어온 제목과 번호로 바꿔치기 해주는 함수를 만든다.
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		int result = 0;
		//Table 내부에서 WHERE bbs ID 특정한 내부의 ID값에 대한 Title과 Content를 바꿔주겠다는 쿼리를 작성
		String SQL = "UPDATE tbl_bbs SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			//성공적 실행이 되면 0이상의 값이 반환되기때문에 바로실행
			result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 나머지는 데이터베이스 오류
	}

	//delete함수를 사용하는 jsp에서 bbsID값을 받아와서,
	public int delete(int bbsID) {
		int result = 0;
		//db내부에 bbsAvailable을 0으로 바꿈으로써 사용자 입장에서는 삭제가 되었다고 볼 수있다.
		//하지만 db내부에는 삭제된 글도 남아있다.
		String SQL = "DELETE FROM tbl_bbs WHERE bbsID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//bbsID값에 해당하는 글을 삭제.
			pstmt.setInt(1, bbsID);
			//결과가 무사히 성공을 했다면 영향받은 행의 수를 반환하므로
			result = pstmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 나머지는 데이터베이스 오류
	}	
	
	// 삭제할 파일명 가져오는 메서드
	public String getFileName(int bbsID) {
		String fileName = null;
		
		String SQL = "SELECT sfile FROM tbl_bbs WHERE bbsID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//bbsID값에 해당하는 글을 삭제.
			pstmt.setInt(1, bbsID);
			//결과가 무사히 성공을 했다면 영향받은 행의 수를 반환하므로
			rs = pstmt.executeQuery();
			if(rs.next()) {
				fileName = rs.getString("sfile");
				System.out.println(fileName);
			}
	
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fileName; 
	}	

}
