package utils;

public class BoardPage {
    public static String pagingStr(int totalCount, int pageSize, int blockPage,
            int pageNum, String reqUrl) {
        String pagingStr = "<ul class=\"pagination\" style=\"margin : 0;\">";

        // 전체 페이지 수 계산
        int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));

        // '이전 블록/ 첫 페이지 바로가기' 출력
        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
        if (pageTemp != 1) {
        	//첫페이지 << : &lt;&lt;
            pagingStr += "<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=1'>&lt;&lt;</a></li>";
            pagingStr += "&nbsp;";
            //이전불록 < : &lt;
			/*
			 * pagingStr += "	<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=" +
			 * (pageTemp - 1) + "'>&lt;</a></li>";
			 */
            pagingStr += "	<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=" + (pageTemp - 1)
            		+ "'>&lt;</a></li>";
        }

        // 각 페이지 번호 출력
        int blockCount = 1;
        while (blockCount <= blockPage && pageTemp <= totalPages) {
            if (pageTemp == pageNum) {
                // 현재 페이지 active
                pagingStr += "&nbsp;<li class=\"page-item active\"><a href='" + reqUrl + "?pageNum=" + pageTemp + "'>" + pageTemp + "</a></li>&nbsp;";
            } else {
                pagingStr += "&nbsp;<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=" + pageTemp
                             + "'>" + pageTemp + "</a></li>&nbsp;";
            }
            pageTemp++;
            blockCount++;
        }

        // '다음 블록/ 마지막 페이지 바로가기' 출력
        if (pageTemp <= totalPages) {
        	//다음블록 > : &gt;
            pagingStr += "<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=" + pageTemp
                         + "'>&gt;</a></li>";
            pagingStr += "&nbsp;";
            //마지막페이지 >> : &gt;&gt;;
            pagingStr += "<li class=\"page-item\"><a href='" + reqUrl + "?pageNum=" + totalPages
                         + "'>&gt;&gt;</a></li>";
        }
        pagingStr += "</ul>";

        return pagingStr;
    }
}
