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

    String table = request.getParameter("table");
    String function = request.getParameter("function");
    String query = "select * from " + table + ";";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        ResultSetMetaData rsmd = rs.getMetaData();
        if ("insert".equals(function)){
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
            stmt.executeUpdate(queryForInsert.toString());
            if (request.getParameter("u") != null && request.getParameter("u").equals("y")){
                request.getRequestDispatcher("userTable.jsp").forward(request, response);
            }
            else{
                request.getRequestDispatcher("adminTable.jsp").forward(request, response);
            }
        } else if("update".equals(function)){
            StringBuilder queryForUpdate = new StringBuilder("update " + table + " set ");
            int cnt = rsmd.getColumnCount();
            int i;
            for (i = 2; i <= cnt; i++){
                if (rsmd.getColumnType(i) == Types.VARCHAR) {
                    queryForUpdate.append(rsmd.getColumnName(i) + "=\"" + (request.getParameter(rsmd.getColumnName(i))) + "\", ");
                } else {
                    queryForUpdate.append(rsmd.getColumnName(i) + "=" + (request.getParameter(rsmd.getColumnName(i))) + ", ");
                }
            }
            queryForUpdate.delete(queryForUpdate.length()-2, queryForUpdate.length());
            queryForUpdate.append(" where " + rsmd.getColumnName(1) + "=" + (request.getParameter(rsmd.getColumnName(1))));
            queryForUpdate.append(";");
            stmt.executeUpdate(queryForUpdate.toString());
        } else if("delete".equals(function)){
            StringBuilder queryForDelete = new StringBuilder("delete from " + table + " where id=");
            queryForDelete.append(request.getParameter("id") + ";");
            stmt.executeUpdate(queryForDelete.toString());
        } else if("search".equals(function)){
            request.setAttribute("table", table);
            int cnt = rsmd.getColumnCount();
            for (int i = 1; i <= cnt; i++){
                if (request.getParameter(rsmd.getColumnName(i)) != null && !request.getParameter(rsmd.getColumnName(i)).equals("")){
                    request.setAttribute(rsmd.getColumnName(i), request.getParameter(rsmd.getColumnName(i)));
                }
            }
            request.getRequestDispatcher("adminTable.jsp?q=y").forward(request, response);
        }
    }catch (SQLIntegrityConstraintViolationException e) {
        e.printStackTrace();
        response.sendRedirect("adminPage.jsp?errorcode=2");
        // foreign key error
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
</body>
</html>
