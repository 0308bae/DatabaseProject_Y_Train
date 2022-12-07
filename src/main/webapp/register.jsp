<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        String jdbcDriver = "jdbc:mariadb://localhost:3306/bookstore";
        String dbUser = "root";
        String dbPwd = "qjrjzld1!";

        Connection conn = null;
        Statement stmt = null;

        String name = (String) session.getAttribute("name");
        int age = (Integer) session.getAttribute("age");
        String gender = (String) session.getAttribute("gender");
        String insert_value_single =
                "insert into persons(name, age, gender) " +
                        "values('"+name+"',"+age+",'"+gender+"');";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println(" 드라이버 로딩 오류 : " + e.getMessage());
            e.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
            stmt = conn.createStatement();
            stmt.executeUpdate(insert_value_single);
    %>
    <h1>성공</h1>
    <p>
        성공적으로 데이터베이스에 등록하였습니다.
    </p>
    <p class="lead">
        수행한 SQL Statement :
        <%=insert_value_single%>
        <%
            System.out.println("Success");
            }
            catch (Exception e){
                e.printStackTrace();
            }
            finally {
                try {
                    stmt.close();
                    conn.close();
                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            }
        %>
    </p>

</body>
</html>
