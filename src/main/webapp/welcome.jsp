<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>�Է� ���</title>
</head>
<body>
<%
    String user_mail = (String) session.getAttribute("user_name");
    String url = request.getHeader("referer");
%>
<h1>ȯ���մϴ�! <%=user_mail%>��</h1>
<input type="button" value="���ư���" onclick="location.href='<%=url%>'">
<%
    System.out.println(url);
%>
</body>
</html>