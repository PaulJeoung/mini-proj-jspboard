<!-- 
	create : 2024-10-14
	author : paul jeoung
	file   : ViewPage.jsp
	title  : 파일 업로드 결과 확인 페이지
	desc   : MultipartRequest 를 이용한 저장 결과 출력
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File View Page</title>
<%
	String saveForder = "D:/lidia_J/eclipse-workspace/mini-proj-jspboard/src/main/webapp/FileStorage/";
	String encType = "UTF-8";
	int maxSize = 5 * 1024 * 1024;
	
	try {
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, saveForder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration params = multi.getParameterNames();
		
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = multi.getParameter(name);
			out.println(name + " = " + value + "<br/>");
		}
		
		Enumeration files = multi.getFileNames();
		
		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = multi.getFilesystemName(name);
			String original = multi.getOriginalFileName(name);
			String type = multi.getContentType(name);
			File f = multi.getFile(name);
			
			out.println("파라이터이름 : " + name + "<br/>");
			out.println("실제파일이름 : " + filename + "<br/>");
			out.println("저장된파일이름 : " + original + "<br/>");
			out.println("파일타입이름 : " + type + "<br/>");
			
			if (f != null) {
				out.println("크기 : " + f.length()/1000 + "kb <br/>");
			}
		}
	} catch (IOException e) {
		System.out.println(e);
	} catch (Exception e) {
		System.out.println(e);
	}
%>
</head>
<body>

</body>
</html>