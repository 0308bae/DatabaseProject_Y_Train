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
    try {
        String isJoin = request.getParameter("join");
        String[] tables = request.getParameterValues("table");
        if (tables == null || tables.length == 0){
            isJoin = request.getAttribute("join").toString();
            tables = new String[]{request.getAttribute("table").toString()};
        }
        if (isJoin != null){
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
%>
            <h3>Foreign Key Information</h3>
            <table border="1" cellpadding="3" cellspacing="2">
<%
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(foreignkey_query);
            ResultSetMetaData rsmd = rs.getMetaData();
            int cnt = rsmd.getColumnCount();
            int i;
            for(i=1 ; i<=cnt ; i++){
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
            </table><br><br><hr>
            <h3><%=table%></h3>
            <table border="1" cellpadding="3" cellspacing="2">
<%
            StringBuilder query = new StringBuilder("select ");

            for (String t : tables){
                String queryForMeta = "select * from " + t + ";";
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(queryForMeta);
                rsmd = rs.getMetaData();
                cnt = rsmd.getColumnCount();
                for(i=1 ; i<=cnt ; i++){
                    query.append(t + "." + rsmd.getColumnName(i)+ " " + t+"_"+rsmd.getColumnName(i) + ", ");
                }
            }
            query.delete(query.length()-2, query.length());
            System.out.println(query);

            query.append(" from " + table + " where ");
            rs = stmt.executeQuery(foreignkey_query);
            rs.beforeFirst();
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
            System.out.println(query);

            rs = stmt.executeQuery(query.toString());
            rsmd = rs.getMetaData();
            cnt = rsmd.getColumnCount();
            String target = "";
            Integer index = -1;
            for(i=1 ; i<=cnt ; i++){
                if (rsmd.getColumnName(i).equals("id")){
                    index++;
                    target=tables[index];
                }
%>              <th><%=target.charAt(0) + "_" + rsmd.getColumnName(i)%></th>
<%          }
            while(rs.next()){
%>              <tr>
<%
                index = -1;
                for(i=1 ; i<=cnt ; i++){
                    if (rsmd.getColumnName(i).equals("id")){
                        index++;
                        target=tables[index];
                    }
%>                  <td><%=rs.getString(target + "_" + rsmd.getColumnName(i))%></td>
<%              }
%>              </tr>
<%          }
%>
            </table>
            <h5>Insert, Update, Delete, Search는 Join을 선택하지 않아야 가능합니다.</h5>
<%
        } else {
            String query;
            String queryForMeta;
            for (String table : tables){
                queryForMeta = "select * from " + table + ";";
                query = "select * from " + table;
                if ("y".equals(request.getParameter("q"))){
                    query += " where ";
                }
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(queryForMeta);
                ResultSetMetaData rsmd = rs.getMetaData();
                int cnt = rsmd.getColumnCount();
                int i;
                for(i=1 ; i<=cnt ; i++){
                    if (request.getAttribute(rsmd.getColumnName(i)) != null){
                        if (rsmd.getColumnType(i) == Types.VARCHAR) {
                            query += rsmd.getColumnName(i) + "=\"" + request.getParameter(rsmd.getColumnName(i)) + "\" and ";
                        } else {
                            query += rsmd.getColumnName(i) + "=" + request.getParameter(rsmd.getColumnName(i)) + " and ";
                        }
                    }
                }
                if ("y".equals(request.getParameter("q"))){
                    query = query.substring(0, query.length()-5);
                }
                query +=";";
                System.out.println(query);
                rs = stmt.executeQuery(query);
%>              <h3><%=table%></h3>
                <table border="1" cellpadding="3" cellspacing="2">
<%                  for(i=1 ; i<=cnt ; i++){
%>                      <th><%=rsmd.getColumnName(i)%></th>
<%                  }
                    while(rs.next()){
%>                      <tr>
<%                      for(i=1 ; i<=cnt ; i++){
%>                          <td><%=rs.getString(rsmd.getColumnName(i))%></td>
<%                      }
%>                      </tr>
<%                  }
                String queryForCount = "select count(*) from " + table + ";";
                rs = stmt.executeQuery(queryForCount);
                rs.next();
                Integer count = rs.getInt("count(*)");
%>
                </table>

                <form action="tableInsert.jsp" method="post">
                    <br>
                    <label>current table : <%=table.toString()%></label>
                    <input type="hidden" name="table" value="<%=table.toString()%>">
                    <br>
<%                  for (i=1 ; i<=cnt ; i++){
                        if (rsmd.getColumnName(i).equals("id")) {
%>                          <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>" value="<%=count+1%>">
<%                      }
                        else{
%>                          <input type="text" name="<%=rsmd.getColumnName(i)%>" placeholder="<%=rsmd.getColumnName(i)%>">
<%                      }
                    }
%>              <br>
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
<%          }
        }
%>
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
            response.sendRedirect("adminPage.jsp?errorcode=1");
        }
    }
%>
<a href="adminPage.jsp">돌아가기</a>
</body>
</html>
