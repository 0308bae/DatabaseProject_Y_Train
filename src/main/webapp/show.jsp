<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project Homework #6</title>
</head>
<body>
<h2>2018253070 배재익</h2>
<%
    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String query = "select * from stations";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
%>
<p class="lead">
<hr>
<h3>stations</h3>
<table border="1" cellpadding="3" cellspacing="2">
    <th>id</th>
    <th>name</th>
    <th>location</th>
    <th>address</th>
    <th>tel</th>
    <th>noEmployees</th>
    <th>noTrains</th>
    <%
        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String location = rs.getString("location");
            String address = rs.getString("address");
            String tel = rs.getString("tel");
            String noEmployees = rs.getString("noEmployees");
            String noTrains = rs.getString("noTrains");
    %>
    <tr>
        <td><%=id%>
        </td>
        <td><%=name%>
        </td>
        <td><%=location%>
        </td>
        <td><%=address%>
        </td>
        <td><%=tel%>
        </td>
        <td><%=noEmployees%>
        </td>
        <td><%=noTrains%>
        </td>
    </tr>
    <%
        }
    %>
</table><br><hr>
<h3>trains</h3>
<table border="1" cellpadding="3" cellspacing="2">
    <th>id</th>
    <th>number</th>
    <th>description</th>
    <th>baseStationId</th>
    <th>typecode</th>
    <th>noVehicle</th>
    <th>yearStartOperation</th>
    <th>isOperation</th>
    <%
        query = "select * from trains";
        rs = stmt.executeQuery(query);
        while (rs.next()) {
            String id = rs.getString("id");
            String number = rs.getString("number");
            String description = rs.getString("description");
            String baseStationId = rs.getString("baseStationId");
            String typeCode = rs.getString("typeCode");
            String noVehicle = rs.getString("noVehicle");
            String yearStartOperation = rs.getString("yearStartOperation");
            String isOperation = rs.getString("isOperation");
    %>
    <tr>
        <td><%=id%>
        </td>
        <td><%=number%>
        </td>
        <td><%=description%>
        </td>
        <td><%=baseStationId%>
        </td>
        <td><%=typeCode%>
        </td>
        <td><%=noVehicle%>
        </td>
        <td><%=yearStartOperation%>
        </td>
        <td><%=isOperation%>
        </td>
    </tr>
    <%
        }
    %>
</table><br><hr>
<h3>typecodes</h3>
<table border="1" cellpadding="3" cellspacing="2">
    <th>id</th>
    <th>name</th>
    <th>description</th>
    <%
        query = "select * from typecodes";
        rs = stmt.executeQuery(query);
        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
    %>
    <tr>
        <td><%=id%>
        </td>
        <td><%=name%>
        </td>
        <td><%=description%>
        </td>
    </tr>
    <%
        }
    %>
</table>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</p><br><br>
<a href="index.jsp">돌아가기</a>
</body>
</html>
