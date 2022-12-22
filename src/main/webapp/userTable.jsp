<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
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
    try {
        String[] tables = {"train", "engineer", "traincode", "operation"};
        if (tables == null || tables.length == 0){
            tables = new String[]{request.getAttribute("table").toString()};
        }

        String query;
        String queryForMeta;
        String ID = null;
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        for (String table : tables){
            queryForMeta = "select * from " + table + ";";
            String queryForEngineer = "select * from engineer where member_id=\""+ session.getAttribute("id") +"\";";
            rs = stmt.executeQuery(queryForEngineer);

            while (rs.next()){
                ID = rs.getString("id");
            }

            rs = stmt.executeQuery(queryForMeta);
            ResultSetMetaData rsmd = rs.getMetaData();
            int cnt = rsmd.getColumnCount();
            int i;

            query = "select * from " + table + ";";
            rs = stmt.executeQuery(query);
%>          <h3><%=table%></h3>
            <table border="1" cellpadding="3" cellspacing="2">
<%          for(i=1 ; i<=cnt ; i++){
%>              <th><%=rsmd.getColumnName(i)%></th>
<%          }
            while(rs.next()){
%>              <tr>
<%              for(i=1 ; i<=cnt ; i++){
%>                  <td><%=rs.getString(rsmd.getColumnName(i))%></td>
<%              }
%>              </tr>
<%          }
%>
            </table>
<%      }
%>
        <form action="tableInsert.jsp?u=y" method="post">
            <br>
            <label>current table : operation</label>
            <input type="hidden" name="table" value="operation">
            <br>
<%
            String queryForCount = "select count(*) from operation where engineer_id=\"" + ID +"\";";
            rs = stmt.executeQuery(queryForCount);
            rs.next();
            String count = rs.getString("count(*)");
            queryForMeta = "select * from operation where engineer_id=\"" + ID +"\";";

            rs = stmt.executeQuery(queryForMeta);
            ResultSetMetaData rsmd = rs.getMetaData();
            int cnt = rsmd.getColumnCount();
            for (int i=1 ; i<=cnt ; i++){
                if (rsmd.getColumnName(i).equals("id")) {
%>                  <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=count%>" disabled>
                    <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=count%>" hidden>
<%              }
                else if (rsmd.getColumnName(i).equals("updatetime")) {
%>                  <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=LocalDateTime.now()%>" disabled>
                    <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=LocalDateTime.now()%>" hidden>
<%              }
                else if (rsmd.getColumnName(i).equals("engineer_id")) {
%>                  <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=ID%>"disabled>
                    <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=ID%>"hidden>
<%              }
                else{
%>                  <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>">
<%              }
            }
%>          <br>
            <select name ="function">
                <option value="insert" selected>insert</option>
                <option value="update">update</option>
                <option value="delete">delete</option>
                <option value="search">search</option>
            </select>
            <input type="submit" value="실행">
            <h5>* delete는 id만 입력해도 가능합니다.</h5>
            <h5>* search는 원하는 데이터만 입력해도 가능합니다.</h5>
            <hr>
        </form>
<%
    } catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("index.jsp?errorcode=1");
    // unexpected error
    } finally {
        try {
            if (conn != null) conn.close();
            if (stmt != null) stmt.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?errorcode=1");
        }
    }
%>
<br>
<a href="index.jsp">돌아가기</a>
</body>
</html>
