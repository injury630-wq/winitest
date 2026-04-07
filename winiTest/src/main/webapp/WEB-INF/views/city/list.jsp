<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>City 목록</title>
</head>
<body>
    <h2>City 목록</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>이름</th>
            <th>국가코드</th>
            <th>지역</th>
            <th>인구</th>
        </tr>
        <c:forEach var="city" items="${cityList}">
        <tr>
            <td>${city.id}</td>
            <td>${city.name}</td>
            <td>${city.countryCode}</td>
            <td>${city.district}</td>
            <td>${city.population}</td>
        </tr>
        </c:forEach>
    </table>
</body>
</html>