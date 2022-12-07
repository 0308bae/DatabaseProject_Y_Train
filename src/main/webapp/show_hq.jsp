<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
<body>
<form action="show_hq.jsp" method="get">
    <label>검색할 본부명 : </label>
    <input type="text" name="query">
</form>
<%
    String target = null;
    if (request.getParameter("query") != null) {
        target = request.getParameter("query");
    }
    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    String query =
            "select * " +
                    "from headquarter as h " +
                    "where h.planet = ? ";
    String queryForAll = "select * from headquarter order by planet";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        if (target == null){
            stmt = conn.createStatement();
            rs = stmt.executeQuery(queryForAll);
        }
        else {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, target);
            rs = pstmt.executeQuery();
        }
%>
<hr>
<%
    String currPlanet = "";
    Boolean isNotFirst = false;
    while (rs.next()) {
        String h_id = rs.getString("id");
        String h_name = rs.getString("name");
        String h_planet = rs.getString("planet");
        String h_continent = rs.getString("continent");
        String h_manager = rs.getString("ManagerName");
        String h_budget = rs.getString("Budget");
        if (!currPlanet.equals(h_planet)) {
            if (isNotFirst) {
%>              </table><br><hr>
<%          }
            isNotFirst = true;
            currPlanet = h_planet;
%>          <h1><%=h_planet%></h1>
            <table border="1" cellpadding="3" cellspacing="2">
                <th>ID</th>
                <th>본부명</th>
                <th>행성</th>
                <th>대륙</th>
                <th>담당</th>
                <th>예산</th>
<%      }
%>      <tr>
            <td><%=h_id%></td>
            <td><%=h_name%></td>
            <td><%=h_planet%></td>
            <td><%=h_continent%></td>
            <td><%=h_manager%></td>
            <td><%=h_budget%></td>
        </tr>
<%      }
%>
    </table><br><hr>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (conn != null) conn.close();
            if (pstmt != null) pstmt.close();
            if (stmt != null) stmt.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</table><br><br>
<a href="index.jsp">돌아가기</a>
</body>
</html>
