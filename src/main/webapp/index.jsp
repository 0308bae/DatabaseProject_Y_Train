<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    if (session.getAttribute("id") == null){
        if (request.getParameter("errorcode") != null){
            if (request.getParameter("errorcode").equals("1")){
%>              <h5>아이디 또는 패스워드가 잘못 입력되었습니다.</h5>
<%          }
            else if (request.getParameter("errorcode").equals("2")){
%>              <h5>알 수 없는 에러가 발생했습니다. 다시 시도해주세요.</h5>
<%          }
            else if (request.getParameter("errorcode").equals("3")){
%>              <h5>엔지니어로 등록되지 않은 사용자입니다. 관리자에게 문의하세요.</h5>
<%          }
        }
%>
<form action="login_check.jsp" method="post">
    아이디:<input type="text" name="id"><br/>
    비밀번호:<input type="password" name="pw"><br/>
    <input type="submit" value="로그인"><br/>
</form>
<%  }
    else {
        if (session.getAttribute("id") == null){
%>          <a href="login.jsp">로그인</a>
<%      } else {
%>          <h2>로그인 ID : <%=session.getAttribute("id")%></h2>
            <a href="logout.jsp">로그아웃</a>
<%      }

    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String query = "select * " +
            "from engineer as e, headquarter as h " +
            "where e.Headquater_id = h.id " +
            "and member_id=?;";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, session.getAttribute("id").toString());
        rs = pstmt.executeQuery();

        if (rs.next()) {
            Long id = rs.getLong("e.id");
            int year = rs.getInt("e.year");
            String variety = rs.getString("e.variety");
            int amount = rs.getInt("e.amount");

            String h_name = rs.getString("h.name");
            String h_planet = rs.getString("h.planet");
            String h_continent = rs.getString("h.continent");
            String h_manager = rs.getString("h.ManagerName");
            String h_budget = rs.getString("h.Budget");
%>
<h2>내 정보</h2>
<table border="1" cellpadding="3" cellspacing="2">
    <th>아이디</th>
    <th>입사 연도</th>
    <th>직종</th>
    <th>연봉</th>
    <tr>
        <td><%=id%></td>
        <td><%=year%></td>
        <td><%=variety%></td>
        <td><%=amount%></td>
    </tr>
</table><br><hr>
<h2>소속 본부</h2>
<table border="1" cellpadding="3" cellspacing="2">
    <th>본부명</th>
    <th>행성</th>
    <th>대륙</th>
    <th>담당</th>
    <th>예산</th>
    <tr>
        <td><%=h_name%></td>
        <td><%=h_planet%></td>
        <td><%=h_continent%></td>
        <td><%=h_manager%></td>
        <td><%=h_budget%></td>
    </tr>
</table>
<a href="userTable.jsp">운행기록하기</a>
<%              }
else { // 엔지니어로 등록되지 않은 사용자
    response.sendRedirect("index.jsp?errorcode=3");
}
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (conn != null) conn.close();
        if (pstmt != null) pstmt.close();
        if (rs != null) rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}
%>
</body>
</html>
