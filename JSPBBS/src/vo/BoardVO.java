package vo;

public class BoardVO {
	
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsRegDate;
	private String bbsModDate;
	private String bbsContent;
	private String ofile; //원본파일명
	private String sfile; //저장된 파일명
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
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
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
