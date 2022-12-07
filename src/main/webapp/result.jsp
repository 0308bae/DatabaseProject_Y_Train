<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입력 결과</title>
</head>
<body>
<%
    try {
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String redirect = null;
        String trigger_name = "james";

        if (name.equals(trigger_name)) {
            session.setAttribute("user_name", name);
            redirect = "welcome.jsp";
        }
        String insert = request.getParameter("register");

        if (insert != null && insert.equals("on")) {
            session.setAttribute("age", age);
            session.setAttribute("name", name);
            session.setAttribute("gender", gender);
            redirect = "register.jsp";
        }
        if (redirect != null)
            response.sendRedirect(redirect);
%>
    <div>
        <h1>결과</h1>
        <p>전송된 내용은 다음과 같습니다.</p>
        <p>
            이름 :
            <%=name%>
        </p>
        <p>
            나이 :
            <%=age%>
        </p>
        <p>
            성별 :
            <%=gender%>
        </p>
    </div>
    <%
        } catch (NumberFormatException e) {
    %>
    <h1>이런 !</h1>
    <p>
        올바른 정보를 입력해주세요..
    </p>
    <%
        }
    %>
</body>
</html>