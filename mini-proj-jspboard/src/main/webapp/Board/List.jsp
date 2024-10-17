<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	if (request.getParameter("keyWord")!=null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload")!=null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
			keyField = "";
		}
	}
	if (request.getParameter("nowPage")!=null) {
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
   .borderedLine {border: 1px dotted white;}
</style>
<link rel="stylesheet" href="styles.css">
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
		document.readFrm.action = "Read.jsp"
		document.readFrm.submit();
	}
	
	function check() {
		if (document.searchFrm.keyWord.value=="") {
			alert("검색어를 입력하세요");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>
</head>

<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
	<div align="center">
		<hr><h2>[Shake_it Funk Board]</h2>
		<p></p>
		<table align="center" width="80%">
			<tr>
				<td>
					Total : <%=totalRecord %> 게시글 (<%=nowPage %>/<%=totalPage %>Pages)
				</td>
			</tr>
		</table>
		<table class="borderedLine" align="center" width="80%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center" colspan="2">
					<%
						vlist = bMgr.getBoardList(keyField, keyWord, start, end);
						listSize = vlist.size();
							if(vlist.isEmpty()) {
								out.println("등록된 게시물이 없습니다");
							} else {
					%>
					<table border="0" width="100%" cellpadding="2" cellspacing="0">
						<tr><td colspan="5"><br/></td></tr>
						<tr align="center" height="120%">
							<td width="10%">번호</td>
							<td width="40%">제목</td>
							<td width="*">이름</td>
							<td width="*">날짜</td>
							<td width="*">조회수</td>
						</tr>
						<%
							for(int i=0; i<numPerPage; i++){
								if(i==listSize){
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
							<td align="center"><%=num %></td>
							<td align="left" style="color: #66ff66;">
							<%
								if(depth>0) {
									for (int j=0;j<depth;j++) {
										out.println("&nbsp;&nbsp;");
									}
								}
							%>
							<a href="javascript:read('<%=num %>')" style="color: #66aa00;"><%=subject %></a>
							</td>
							<td align="center"><%=name %></td>
							<td align="center"><%=regdate %></td>					
							<td align="center"><%=count %></td>	
						</tr>
						<% } %>
					</table>
					<% } %>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br/></td>
			</tr>
		</table>
		<table>
			<tr>
				<td style="color:white;">
				<!-- 페이징 및 블럭처리 시작 -->
				<%
					int pageStart = (nowBlock-1)*pagePerBlock+1;
					int pageEnd = ((pageStart+pagePerBlock)<totalPage) ? (pageStart+pagePerBlock) : totalPage+1;
					if(totalPage!=0) {
						if(nowBlock>1){
				%>
					<a href="javascript:block('<%=nowBlock%>')">prev...</a>
					<% } %> &nbsp;
					<%
						for ( ; pageStart<pageEnd; pageStart++){ 
					%>
					<a href="javascript:pageing('<%=pageStart %>')" style="color: #66ff66;">
					<%
						if(pageStart==nowPage) {
					%>
					
					<% } %>
					[<%=pageStart %>]
					<%
						if(pageStart==nowPage) { 
					%>
					<% } %></a>
					<% } %>&nbsp;
					<%
						if(totalBlock>nowBlock) {
					%>
					<a href="javascript:block('<%=nowBlock+1 %>')"style="color: #66ff66;">...next</a>
					<% } %>&nbsp;
					<% } %>
					<!-- 페이징 및 블록처리 종료 -->
				</td>
				<td align="right">
					<a href="Post.jsp" style="color: #66ff66;">[글쓰기]</a>
					<a href="javascript:list()" style="color: #66ff66;">[처음으로]</a>
				</td>
			</tr>
		</table>
		<hr>
		<form name="searchFrm" method="post" action="List.jsp">
			<table border="0" width="527" align="center" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<select name="keyField" size="1">
							<option value="name">이름</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
						</select>
						<input size="16" name="keyWord">
						<input type="button" value="찾기" onclick="javascript:check()">
						<input type="hidden" name="nowPage" value="1">
					</td>
				</tr>
			</table>
		</form>
		<table>
			<tr><td><br/></td><td></td><td></td></tr>
			<tr>
				<td align="right" colspan="3">
					<a style="color: #66ff66;" href="../Login/Logout.jsp">로그아웃</a>
				</td>
			</tr>
		</table>
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<input type="hidden" name=nowPage" value="1">
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