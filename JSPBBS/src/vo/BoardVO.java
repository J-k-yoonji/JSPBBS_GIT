package vo;

public class BoardVO {
	
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsRegDate;
	private String bbsModDate;
	private String bbsContent;
	private int bbsViewcount;
	private int boardID;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsRegDate() {
		return bbsRegDate;
	}
	public void setBbsRegDate(String bbsRegDate) {
		this.bbsRegDate = bbsRegDate;
	}
	public String getBbsModDate() {
		return bbsModDate;
	}
	public void setBbsModDate(String bbsModDate) {
		this.bbsModDate = bbsModDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsViewcount() {
		return bbsViewcount;
	}
	public void setBbsViewcount(int bbsViewcount) {
		this.bbsViewcount = bbsViewcount;
	}
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
}
