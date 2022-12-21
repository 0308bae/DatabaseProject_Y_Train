<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%

    request.setCharacterEncoding("UTF-8");

    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String table = request.getParameter("table");
    String query = "select * from " + table + ";";
%>
<h3><%=table%></h3>
<table border="1" cellpadding="3" cellspacing="2">
<%  try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        ResultSetMetaData rsmd = rs.getMetaData();
        StringBuilder queryForInsert = new StringBuilder("insert into " + table + " values(");
        int cnt = rsmd.getColumnCount();
        int i;
        for (i = 1; i <= cnt; i++){
            if (rsmd.getColumnType(i) == Types.VARCHAR) {
                queryForInsert.append("\"" + (request.getParameter(rsmd.getColumnName(i))) + "\", ");
            } else {
                queryForInsert.append((request.getParameter(rsmd.getColumnName(i))) + ", ");
            }
        }
        queryForInsert.delete(queryForInsert.length()-2, queryForInsert.length());
        queryForInsert.append(");");
        System.out.println(queryForInsert.toString());


    }catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminTable.jsp?errorcode=1");
        // unexpected error
    } finally {
        try {
            if (conn != null) conn.close();
            if (stmt != null) stmt.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("adminPage.jsp");
    }
%>
</body>
</html>
