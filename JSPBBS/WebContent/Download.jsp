<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.File"%>
<!-- 바이트 단위 입출력을 위한 최상위 입출력 스트림 클래스. 바이트 단위는 그림, 문자 등 모든 종류의 데이터를 주고 받을 수 있다. -->
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // /Uploads 폴더의 물리적경로, 저장된 파일명, 원본파일명을 매개변수로 받아 변수에 저장함.
String saveDirectory = application.getRealPath("/Uploads");
String saveFilename = request.getParameter("sName");
String originalFilename = request.getParameter("oName");

try {
    // 해당 파일을 찾아서 입력스트림(다른 매체로부터 바이트로 데이터를 읽어올 때 사용) 생성
    File file = new File(saveDirectory, saveFilename);  
    InputStream inStream = new FileInputStream(file);
    
    // 한글 파일명 깨짐 방지를 위해 웹 브라우저의 종류를 알아냄.
    String client = request.getHeader("User-Agent");
    // 주어진 값과 일치하는 값이 없으면 -1을 반환
    if (client.indexOf("WOW64") == -1) {
        originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
    } //인터넷익스플로러일 경우 아래와 같이 원본파일명을 바이트배열로 변환 후 문자열을 재생성.
    else {  
        originalFilename = new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");
    }
   
    // 파일 다운로드용 응답 헤더 설정 
    response.reset();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", 
                       "attachment; filename=\"" + originalFilename + "\"");
    response.setHeader("Content-Length", "" + file.length() );
    
    // 새로운 출력스트림 생성을 위해 초기화. JSP가 열린 상태에서 다운로드를 위해 또다른 JSP를 열면 출력스트림이 중복으로 생성되어 예외가 발생하므로 초기화. 
    out.clear();  
    
    // response 내장 객체로부터 새로운 출력 스트림 생성. 다른 매체에 바이트로 데이터를 쓸 때 사용
    OutputStream outStream = response.getOutputStream();  

    // 출력 스트림에 파일 내용 출력
    byte b[] = new byte[(int)file.length()];
    int readBuffer = 0;    
    // read() :  데이터를 읽고 (주어진 바이트 배열의 길이만큼 읽음) 0~255 사이값을 int 타입으로 반환, 더 이상 입력 스트림으로부터 바이트를 읽을 수 없다면 -1을 리턴.
    while ( (readBuffer = inStream.read(b)) > 0 ) {
        // write(byte[] data, int off, int len) 을 이용하면 효율적으로 1바이트 이상을 한 번에 전송할 수 있다.
    	//입력 스트림으로부터 len개의 바이트를 읽고, 매개값으로 주어진 바이트 배열 b[off]부터 len개까지 저장
        //메소드 종료 시에 읽은 바이트 수인 len 개를 리턴하고, 실제로 읽은 바이트 수가 len개보다 작을 경우 읽은 수 만큼 리턴
        outStream.write(b, 0, readBuffer);
    }

    // 입/출력 스트림 닫음
    inStream.close(); 
    outStream.close();
}
catch (FileNotFoundException e) {
    e.printStackTrace();
    System.out.println("파일을 찾을 수 없습니다.");
}
catch (Exception e) {
	e.printStackTrace();
    System.out.println("예외가 발생했습니다.");
}
%>