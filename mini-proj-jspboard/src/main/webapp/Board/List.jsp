<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean"%>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 15;
	int totalPage = 0;
	int totalBlock = 0;
	int nowPage = 1;
	int nowBlock = 1;
	int start = 0;
	int end = 10;
	int listSize = 0;
	
	String keyWord = "";
	String keyField = "";
	
	Vector<BoardBean> vlist = null;
	
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null) {
		if (request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
<style>
    body {
        background-color: #f0f0f0;
        color: #333;
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 20px;
    }
    h2 {
        color: #4CAF50;
        text-align: center;
    }
    .table-container {
        width: 80%;
        margin: auto;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }
    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    a {
        color: #4CAF50;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
    .pagination {
        text-align: center;
        margin: 20px 0;
    }
    .search-container {
        text-align: center;
        margin: 20px 0;
    }
    input[type="text"], select {
        padding: 10px;
        margin: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    input[type="button"], input[type="submit"], input[type="reset"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    input[type="button"]:hover, input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #45a049;
    }
</style>
<script type="text/javascript">
	function list() {
		document.listFrm.action = "List.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value) {
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (value-1) + 1;
		document.readFrm.submit();
	}
	
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "Read.jsp";
		document.readFrm.submit();
	}
	
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>
</head>

<body>
	<div class="table-container">
		<p>
		<a href="../Vote/poll-list.jsp" style="color: #007b00; text-decoration: none; padding: 10px 15px; border: 0px dotted #ff7bff; border-radius: 5px; transition: background-color 0.3s;">투표 게시판으로 이동</a>
		</p>
		
		<hr>
		<h2>[Shake_it Funk Board]</h2>
		<p>Total : <%=totalRecord %> 게시글 (<%=nowPage %>/<%=totalPage %> Pages)</p>
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			<%
				vlist = bMgr.getBoardList(keyField, keyWord, start, end);
				listSize = vlist.size();
				if (vlist.isEmpty()) {
					out.println("<tr><td colspan='5'>등록된 게시물이 없습니다</td></tr>");
				} else {
					for (int i = 0; i < numPerPage; i++) {
						if (i == listSize) {
							break;
						}
						BoardBean bean = vlist.get(i);
						int num = bean.getNum();
						String name = bean.getName();
						String subject = bean.getSubject();
						String regdate = bean.getRegdate();
						int depth = bean.getDepth();
						int count = bean.getCount();
			%>
			<tr>
				<td><%=num %></td>
				<td style="text-align:left;">
					<%
						if (depth > 0) {
							for (int j = 0; j < depth; j++) {
								out.print("&nbsp;&nbsp;");
							}
						}
					%>
					<a href="javascript:read('<%=num %>')"><%=subject %></a>
				</td>
				<td><%=name %></td>
				<td><%=regdate %></td>
				<td><%=count %></td>
			</tr>
			<%
					}
				}
			%>
		</table>

		<div class="pagination">
			<%
				int pageStart = (nowBlock - 1) * pagePerBlock + 1;
				int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? (pageStart + pagePerBlock) : totalPage + 1;
				if (totalPage != 0) {
					if (nowBlock > 1) {
			%>
			<a href="javascript:block('<%=nowBlock%>')">prev...</a>
			<%
					}
					for (; pageStart < pageEnd; pageStart++) {
			%>
			<a href="javascript:pageing('<%=pageStart %>')">[<%=pageStart %>]</a>
			<%
					}
					if (totalBlock > nowBlock) {
			%>
			<a href="javascript:block('<%=nowBlock + 1 %>')">...next</a>
			<%
					}
				}
			%>
		</div>

		<div class="search-container">
			<form name="searchFrm" method="post" action="List.jsp">
				<select name="keyField">
					<option value="name">이름</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select>
				<input size="16" name="keyWord" placeholder="검색어 입력">
				<input type="button" value="찾기" onclick="check()">
				<input type="hidden" name="nowPage" value="1">
			</form>
		</div>

		<div style="text-align: right;">
			<a href="Post.jsp">[글쓰기]</a>
			<a href="javascript:list()">[처음으로]</a>
		</div>
		<hr>
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<input type="hidden" name="nowPage" value="1">
		</form>
		<form name="readFrm" method="get">
			<input type="hidden" name="num">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>
</body>
</html>
