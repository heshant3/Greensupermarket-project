<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    if(request.getSession(false) != null){
        request.getSession(false).invalidate();
    }

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user")) {
                cookie.setValue(null);
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                break;
            }
        }
    }

    response.sendRedirect("login.jsp");
%>
