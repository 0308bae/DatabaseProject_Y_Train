<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %>
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
    if (tables.length == 0){
        response.sendRedirect("adminPage.jsp?errorcode=1");
    }
    StringBuilder table = new StringBuilder();

    String foreignkey_query =
            "SELECT " +
                    "tc.table_name, kcu.column_name, " +
                    "kcu.referenced_table_name, kcu.referenced_column_name " +
                    "FROM " +
                    "information_schema.table_constraints tc " +
                    "JOIN " +
                    "information_schema.key_column_usage kcu " +
                    "ON " +
                    "tc.constraint_name = kcu.constraint_name " +
                    "WHERE " +
                    "constraint_type = 'FOREIGN KEY' AND tc.table_name IN (";
    for (String t : tables){
        table.append(t);
        table.append(", ");
        foreignkey_query += "\"" + t + "\", ";
    }
    table.delete(table.length()-2, table.length());
    foreignkey_query = foreignkey_query.substring(0, foreignkey_query.length()-2);
    foreignkey_query += ");";
    System.out.println(table);
    System.out.println(foreignkey_query);
%>
    <h3><%=table%></h3> 
    <table border="1" cellpadding="3" cellspacing="2">
<%  try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(foreignkey_query);

        StringBuilder query = new StringBuilder("select * from " + table + " where ");
        while(rs.next()){
            String name1 = rs.getString("TABLE_NAME");
            String attr1 = rs.getString("COLUMN_NAME");
            String name2 = rs.getString("REFERENCED_TABLE_NAME");
            String attr2 = rs.getString("REFERENCED_COLUMN_NAME");
            if (Arrays.asList(tables).contains(name2)){
                query.append(name1+"."+attr1+"="+name2+"."+attr2+"  and  ");
            }
        }
        query.delete(query.length()-7, query.length());
        query.append(";");
        System.out.println(query.toString());

        rs = stmt.executeQuery(query.toString());
        ResultSetMetaData rsmd = rs.getMetaData();
        int cnt = rsmd.getColumnCount();
        int i;
        for(i=1 ; i<=cnt ; i++){
%>          <th><%=rsmd.getColumnName(i)%></th>
<%      }
        while(rs.next()){
%>          <tr>
<%          for(i=1 ; i<=cnt ; i++){
%>              <td><%=rs.getString(rsmd.getColumnName(i))%></td>
<%          }
%>          </tr>
<%      }
%>
        </table>
        <form action="tableInsert.jsp" method="post">
<%      if(tables.length == 1){
%>          <br>
            <label for="table">table to insert : <%=table.toString()%></label>
            <input type="hidden" name="table" value="<%=table.toString()%>">
            <br>
            <label for="id">id</label>
            <select name="id">
<%          rs.beforeFirst();
            while(rs.next()){
%>              <option><%=rs.getString(rsmd.getColumnName(1))%></option>
<%          }
%>          </select>
<%      }
        else{
%>          <h5>insert와 update는 1개 테이블만 선택해야 가능합니다.</h5>
<%      }
        for(i=2 ; i<=cnt ; i++){
%>          <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>">
<%      }
%>      <br>
        <input type="submit" value="insert 실행">
        </form>
<%
    }catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminPage.jsp?errorcode=1");
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
</body>
</html>
