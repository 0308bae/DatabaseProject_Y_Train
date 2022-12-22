<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs;

    String query =
            "select * " +
            "from stations as s, " +
            "     headquarter as h " +
            "where s.Headquater_id = h.id " +
            "order by h.id;";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
%>
<p class="lead">
<hr>
    <%
        int index = 0;
    %>
    <%
        while (rs.next()){
            int h_id = rs.getInt("h.id");
            if (index != h_id){
                index = h_id;
                String h_name = rs.getString("h.name");
                String h_planet = rs.getString("planet");
                String h_continent = rs.getString("continent");
                String h_manager= rs.getString("h.ManagerName");
                String h_budget = rs.getString("h.Budget");
                if(index != 1){
                    %>
                    </table><br><hr>
                    <%
                }
                %>
                <h3>본부명 : <%=h_name%></h3>
                <div style="display: flex">
                    <div style="padding: 5px">본부 정보 : </div>
                    <div style="padding: 5px">행성 - <%=h_planet%>,</div>
                    <div style="padding: 5px">대륙 - <%=h_continent%>,</div>
                    <div style="padding: 5px">담당 - <%=h_manager%>,</div>
                    <div style="padding: 5px">예산 - <%=h_budget%>,</div>
                </div>
                <table border="1" cellpadding="3" cellspacing="2">
                    <th>역이름</th>
                    <th>주소</th>
                    <th>전화번호</th>
                    <th>담당자</th>
                    <th>예산</th>
                <%
            }
            String s_name = rs.getString("s.name");
            String s_address = rs.getString("address");
            String s_tel = rs.getString("Tel");
            String s_manager = rs.getString("s.ManagerName");
            String s_budget = rs.getString("s.Budget");
            %>
            <tr>
                <td><%=s_name%>
                </td>
                <td><%=s_address%>
                </td>
                <td><%=s_tel%>
                </td>
                <td><%=s_manager%>
                </td>
                <td><%=s_budget%>
                </td>
            </tr>
            <%
        }
    %>
    </table><br><hr>
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
<a href="adminPage.jsp">돌아가기</a>
</body>
</html>
