<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>�Է� ���</title>
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
        <h1>���</h1>
        <p>���۵� ������ ������ �����ϴ�.</p>
        <p>
            �̸� :
            <%=name%>
        </p>
        <p>
            ���� :
            <%=age%>
        </p>
        <p>
            ���� :
            <%=gender%>
        </p>
    </div>
    <%
        } catch (NumberFormatException e) {
    %>
    <h1>�̷� !</h1>
    <p>
        �ùٸ� ������ �Է����ּ���..
    </p>
    <%
        }
    %>
</body>
</html>