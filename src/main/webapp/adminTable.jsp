<%@ page import="java.sql.*" %>
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

    String[] tables = request.getParameterValues("table");
    StringBuilder table = new StringBuilder();
    for (String t : tables){
        table.append(t);
        table.append(", ");
    }
    table.delete(table.length()-2, table.length());
    System.out.println(table);
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
        int cnt = rsmd.getColumnCount();
        int i;
        for(i=1 ; i<=cnt ; i++){
%>          <th><%=rsmd.getColumnName(i)%></th>
<%      }
        while(rs.next()){
%>          <tr>
<%          for(i=1 ; i<=cnt ; i++){
%>              <th><%=rs.getString(rsmd.getColumnName(i))%></th>
<%          }
%>          </tr>
<%      }
    }catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp");
        // unexpected error
    } finally {
        try {
            if (conn != null) conn.close();
            if (stmt != null) stmt.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
    </table>
</body>
</html>
