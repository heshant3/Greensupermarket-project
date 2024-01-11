<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
     session = request.getSession();

    session.invalidate();

    response.sendRedirect("index.jsp");
%>
