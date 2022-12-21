<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String query = "select role from member where id=? and pw=sha2(?, 256);";


    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, id);
        pstmt.setString(2, pw);
        rs = pstmt.executeQuery();

        if (rs.next()) { // correct id & pw
            String role = rs.getString("role");
            if (role.equals("user")) {
                session.setAttribute("id", id);
                response.sendRedirect("login.jsp");
            }
            else { //if admin
                response.sendRedirect("adminPage.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?errorcode=1");
            // incorrect id or pw
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?errorcode=2");
        // unexpected error
    } finally {
        try {
            if (conn != null) conn.close();
            if (pstmt != null) pstmt.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
