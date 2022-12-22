<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--  todo--%>
<%--  | connect               |--%>
<%--  | engineer              |--%>
<%--  | headquarter           |--%>
<%--  | line                  |--%>
<%--  | member                |--%>
<%--  | operation             |--%>
<%--  | stations              |--%>
<%--  | train                 |--%>
<%--  | traincode             |--%>
<%--  | vehicle               |--%>
<%--  drop down으로 insert/search, table 선택하고 버튼 눌러서 이동.--%>
<%
    if (request.getParameter("errorcode") != null && request.getParameter("errorcode").equals("1")){
%>      <h5>잘못된 사용입니다.</h5>
<%  } else if (request.getParameter("errorcode") != null && request.getParameter("errorcode").equals("2")){
%>      <h5>외래키 정책 위반.</h5>
<%  }else {
        if (session.getAttribute("id") != null){
%>          <h2>로그인 ID : <%=session.getAttribute("id")%></h2>
            <a href="logout.jsp">로그아웃</a>
<%      }
    }
%>


    <form action="adminTable.jsp" method="post">
        <h3>테이블 선택</h3>
        <label><input type="checkbox" name="table" value="connect" selected>connect</label>
        <label><input type="checkbox" name="table" value="engineer">engineer</label>
        <label><input type="checkbox" name="table" value="headquarter">headquarter</label>
        <label><input type="checkbox" name="table" value="line">line</label>
        <label><input type="checkbox" name="table" value="member">member</label>
        <label><input type="checkbox" name="table" value="operation">operation</label>
        <label><input type="checkbox" name="table" value="stations">stations</label>
        <label><input type="checkbox" name="table" value="train">train</label>
        <label><input type="checkbox" name="table" value="traincode">traincode</label>
        <label><input type="checkbox" name="table" value="vehicle">vehicle</label>
        <br>
        <label><input type="checkbox" name="join">Join result?</label>
        <input type="submit" value="이동하기">
        <input type="reset" value="Reset">
    </form>
    <a href="show_hq.jsp">행성별 정보 확인 및 행성 검색</a>
    <br>
    <a href="manage.jsp">본부별 역 정보 확인하기</a>
<%
    request.setCharacterEncoding("UTF-8");

    String jdbcDriver = "jdbc:mariadb://localhost:3306/ytrain_corp";
    String dbUser = "root";
    String dbPwd = "qjrjzld1!";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String query;
    String queryForMeta;
    queryForMeta = "select * from operation;";
    query = "select * from operation";
    Class.forName("org.mariadb.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
    stmt = conn.createStatement();
    rs = stmt.executeQuery(queryForMeta);
    ResultSetMetaData rsmd = rs.getMetaData();
    int cnt = rsmd.getColumnCount();
    int i;
    rs = stmt.executeQuery(query);

%>  <h3>operation</h3>
    <table border="1" cellpadding="3" cellspacing="2">
<%      for(i=1 ; i<=cnt ; i++){
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
</body>
</html>
