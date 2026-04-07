<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${pageContext.request.contextPath}/"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인화면</title>
</head>
<script>
//window.location.replace(`${pageContext.request.contextPath}/user/login.do`);
</script>
<body>
<div><a href="user/login.do">로그인</a></div>
<p><a href="board/list.do">게시글</a></p>
<h3>게시글은 로그인이 필요합니다.</h3>

서버정보 
<%=application.getServerInfo() %>
<hr>
서블릿정보
<%=application.getMajorVersion()%>.<%= application.getMinorVersion() %>
<hr>
JSP정보
<%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>

</body>
</html>
