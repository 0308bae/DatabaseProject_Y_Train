<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>form �׽�Ʈ</title>
</head>
<body>
//todo
// �� ����� �α��θ� �����
<%
    if (session.getAttribute("id") == null){
%>      <a href="login.jsp">�α���</a>
<%  } else {
%>      <h2>�α��� ID : <%=session.getAttribute("id")%></h2>
        <a href="logout.jsp">�α׾ƿ�</a>
<%  }
%>
<div>
    <h1>Form (Get ���)</h1>
    <p>���� ���� ������ �����غ��ô�.</p>
</div>
<form action="result.jsp" method="get">
    <div>
        <label>�̸�</label><input name="name" type="text" />
    </div>
    <div>
        <label>����</label><br>
        <input type="radio" name="gender" value="male" checked> Male<br>
        <input type="radio" name="gender" value="female" > Female<br>
        <input type="radio" name="gender" value="other" > Other
    </div>
    <div>
        <label>����</label>
        <input name="age" type="number" min="1" max="80" value="10" required="">
    </div>
    <div>
        <label>�����ͺ��̽��� ���</label>
        <input type="checkbox" name="register">
    </div>
    <button type="submit">����</button>
</form>
<div>
    <h1>Form (Post ���)</h1>
    <p>���� ���� ������ �����غ��ô�.</p>
</div>
<form action="result.jsp" method="post">
    <div>
        <label>�̸�</label><input name="name" type="text" />
    </div>
    <div>
        <label>����</label><br>
        <input type="radio" name="gender" value="male" checked> Male<br>
        <input type="radio" name="gender" value="female" > Female<br>
        <input type="radio" name="gender" value="other" > Other
    </div>
    <div>
        <label>����</label>
        <input name="age" type="number" min="1" max="80" value="10" required="">
    </div>
    <div>
        <label>�����ͺ��̽��� ���</label>
        <input type="checkbox" name="register">
    </div>
    <button type="submit">����</button><br><br>
    <a href="show.jsp">�����ͺ��̽� Ȯ���ϱ�</a>
    <a href="manage.jsp">��-���� ���� Ȯ��</a>
    <a href="show_hq.jsp">���� ����</a>
</form>
</body>
</html>