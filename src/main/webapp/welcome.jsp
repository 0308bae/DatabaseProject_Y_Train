<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입력 결과</title>
</head>
<body>
<%
    String user_mail = (String) session.getAttribute("user_name");
    String url = request.getHeader("referer");
%>
<h1>환영합니다! <%=user_mail%>님</h1>
<input type="button" value="돌아가기" onclick="location.href='<%=url%>'">
<%
    System.out.println(url);
%>
</body>
</html>