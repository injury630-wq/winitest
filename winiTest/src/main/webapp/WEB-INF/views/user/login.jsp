<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/"/>
    <title>로그인</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: '맑은 고딕', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #f5f5f5;
        }
        .login-box {
            background: white;
            padding: 40px;
            width: 400px;
            border: 1px solid #ddd;
        }
        .login-box h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            font-size: 14px;
        }
        .form-group input::placeholder { color: #aaa; }
        .btn-login {
            width: 100%;
            padding: 12px;
            background: #c0392b;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-login:hover { background: #a93226; }
        .register-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
        .register-link a {
            color: #333;
            text-decoration: none;
        }
        .register-link a:hover { text-decoration: underline; }
        .error-msg {
            color: red;
            font-size: 13px;
            text-align: center;
            margin-bottom: 10px;
        }
        .success-msg {
            color: green;
            font-size: 13px;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>로그인</h2>

        <c:if test="${param.error == '1'}">
            <p class="error-msg">아이디 또는 비밀번호가 틀렸습니다.</p>
        </c:if>

        <c:if test="${param.join == '1'}">
            <p class="success-msg">회원가입이 완료됐습니다. 로그인해주세요.</p>
        </c:if>

        <form action="user/login.do" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="userId" placeholder="아이디"/>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="userPw" placeholder="비밀번호"/>
            </div>
            <button type="submit" class="btn-login">로그인</button>
        </form>
        <div class="register-link">
            <a href="user/register.do">회원가입</a>
        </div>
    </div>
</body>
</html>