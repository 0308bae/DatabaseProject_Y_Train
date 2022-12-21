<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--  todo--%>
<%--  | connect               |--%>
<%--  | engineer              |--%>
<%--  | headquarter           |--%>
<%--  | line                  |--%>
<%--  | member                |--%>
<%--  | operation             |--%>
<%--  | stations              |--%>
<%--  | train                 |--%>
<%--  | traincode             |--%>
<%--  | vehicle               |--%>
<%--  drop down으로 insert/search, table 선택하고 버튼 눌러서 이동.--%>
<%
    if (request.getParameter("errorcode") != null && request.getParameter("errorcode").equals("1")){
%>          <h5>잘못된 사용입니다.</h5>
<%      }
%>

<form action="adminTable.jsp" method="post">
    <h3>테이블 선택</h3>
    <label><input type="checkbox" name="table" value="connect" selected>connect</label>
    <label><input type="checkbox" name="table" value="engineer">engineer</label>
    <label><input type="checkbox" name="table" value="headquarter">headquarter</label>
    <label><input type="checkbox" name="table" value="line">line</label>
    <label><input type="checkbox" name="table" value="member">member</label>
    <label><input type="checkbox" name="table" value="operation">operation</label>
    <label><input type="checkbox" name="table" value="stations">stations</label>
    <label><input type="checkbox" name="table" value="train">train</label>
    <label><input type="checkbox" name="table" value="traincode">traincode</label>
    <label><input type="checkbox" name="table" value="vehicle">vehicle</label>
    <br>
    <input type="submit" value="이동하기">
    <input type="reset" value="Reset">
</form>
<%--  insert 기능 모든 테이블--%>
<%--  search 기능 모든 테이블--%>
<%--  update 기능 모든 테이블 -> search랑 연동--%>
<%--  delete 기능 모든 테이블 -> search랑 연동--%>
</body>
</html>
