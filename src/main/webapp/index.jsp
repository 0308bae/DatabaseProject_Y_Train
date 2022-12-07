<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>form 테스트</title>
</head>
<body>
//todo
// 다 지우고 로그인만 남기기
<%
    if (session.getAttribute("id") == null){
%>      <a href="login.jsp">로그인</a>
<%  } else {
%>      <h2>로그인 ID : <%=session.getAttribute("id")%></h2>
        <a href="logout.jsp">로그아웃</a>
<%  }
%>
<div>
    <h1>Form (Get 방식)</h1>
    <p>폼을 통해 데이터 전송해봅시다.</p>
</div>
<form action="result.jsp" method="get">
    <div>
        <label>이름</label><input name="name" type="text" />
    </div>
    <div>
        <label>성별</label><br>
        <input type="radio" name="gender" value="male" checked> Male<br>
        <input type="radio" name="gender" value="female" > Female<br>
        <input type="radio" name="gender" value="other" > Other
    </div>
    <div>
        <label>나이</label>
        <input name="age" type="number" min="1" max="80" value="10" required="">
    </div>
    <div>
        <label>데이터베이스에 등록</label>
        <input type="checkbox" name="register">
    </div>
    <button type="submit">전송</button>
</form>
<div>
    <h1>Form (Post 방식)</h1>
    <p>폼을 통해 데이터 전송해봅시다.</p>
</div>
<form action="result.jsp" method="post">
    <div>
        <label>이름</label><input name="name" type="text" />
    </div>
    <div>
        <label>성별</label><br>
        <input type="radio" name="gender" value="male" checked> Male<br>
        <input type="radio" name="gender" value="female" > Female<br>
        <input type="radio" name="gender" value="other" > Other
    </div>
    <div>
        <label>나이</label>
        <input name="age" type="number" min="1" max="80" value="10" required="">
    </div>
    <div>
        <label>데이터베이스에 등록</label>
        <input type="checkbox" name="register">
    </div>
    <button type="submit">전송</button><br><br>
    <a href="show.jsp">데이터베이스 확인하기</a>
    <a href="manage.jsp">역-본부 정보 확인</a>
    <a href="show_hq.jsp">본부 관리</a>
</form>
</body>
</html>