<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="${pageContext.request.contextPath}/" />
<title>회원가입</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
body {
	font-family: '맑은 고딕', sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background: #f5f5f5;
}
.register-box {
	background: white;
	padding: 40px;
	width: 500px;
	border: 1px solid #ddd;
}
.register-box h2 {
	margin-bottom: 10px;
	font-size: 20px;
}
.required-msg {
	text-align: right;
	font-size: 12px;
	color: #c0392b;
	margin-bottom: 20px;
}
table { width: 100%; border-collapse: collapse; }
table tr td {
	padding: 8px 5px;
	font-size: 14px;
	vertical-align: top;
}
table tr td:first-child {
	width: 110px;
	color: #333;
	padding-top: 10px;
}
table tr td:first-child span { color: #c0392b; margin-right: 3px; }
.input-wrap {
	position: relative;
	display: flex;
	align-items: center;
}
input[type=text], input[type=password] {
	width: 100%;
	padding: 8px 60px 8px 8px;
	border: 1px solid #ddd;
	font-size: 14px;
}
.id-wrap { display: flex; gap: 5px; }
.id-wrap input { flex: 1; }
.btn-check {
	padding: 8px 12px;
	background: white;
	border: 1px solid #c0392b;
	color: #c0392b;
	cursor: pointer;
	font-size: 13px;
	white-space: nowrap;
}
.btn-check:hover { background: #f9f9f9; }
.guide-msg {
	font-size: 12px;
	margin-top: 5px;
	color: #aaa;
}
.guide-msg.ok { color: green; }
.guide-msg.fail { color: red; }
.btn-eye {
	position: absolute;
	right: 8px;
	background: none;
	border: none;
	cursor: pointer;
	font-size: 12px;
	color: #666;
	padding: 0;
	white-space: nowrap;
}
.btn-eye:hover { color: #333; }
.btn-wrap {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}
.btn-cancel {
	padding: 10px 30px;
	background: white;
	border: 1px solid #aaa;
	color: #333;
	cursor: pointer;
	font-size: 14px;
}
.btn-submit {
	padding: 10px 30px;
	background: #c0392b;
	border: none;
	color: white;
	cursor: pointer;
	font-size: 14px;
}
.btn-cancel:hover { background: #f5f5f5; }
.btn-submit:hover { background: #a93226; }
</style>
</head>
<body>
	<div class="register-box">
		<h2>회원정보 입력</h2>
		<p class="required-msg">* 표시는 반드시 입력하셔야 합니다.</p>
		<form action="user/register.do" method="post">
			<table>
				<tr>
					<td><span>*</span>아이디</td>
					<td>
						<div class="id-wrap">
							<input type="text" id="userId" name="userId" />
							<button type="button" class="btn-check" onclick="idCheck()">중복확인</button>
						</div>
						<p id="idMsg" class="guide-msg">한글, 특수문자를 제외한 5~15자 영문, 숫자로 입력해주세요.</p>
					</td>
				</tr>
				<tr>
					<td><span>*</span>비밀번호</td>
					<td>
						<div class="input-wrap">
							<input type="password" id="userPw" name="userPw" />
							<button type="button" class="btn-eye" onclick="togglePw('userPw', this)">표시</button>
						</div>
						<p id="pwMsg" class="guide-msg">숫자+영문자+특수문자 조합으로 10~25자리로 입력해주세요.</p>
					</td>
				</tr>
				<tr>
					<td><span>*</span>비밀번호 확인</td>
					<td>
						<div class="input-wrap">
							<input type="password" id="userPwCheck" />
							<button type="button" class="btn-eye" onclick="togglePw('userPwCheck', this)">표시</button>
						</div>
						<p id="pwCheckMsg" class="guide-msg"></p>
					</td>
				</tr>
				<tr>
					<td><span>*</span>이름</td>
					<td>
					<input type="text" name="userName" id="userName" />
					<p id="nameMsg" class="guide-msg">*이름은 공백 없이 들어갑니다.</p>
					</td>
				</tr>
			</table>
			<div class="btn-wrap">
				<button type="button" class="btn-cancel" onclick="history.back()">취소</button>
				<button type="submit" class="btn-submit" onclick="return validate()">가입</button>
			</div>
		</form>
	</div>
	<script>
		// 아이디 유효성 검사
		document.querySelector("#userId").addEventListener("input", function() {
			let userId = this.value.trim();
			let msg = document.querySelector("#idMsg");
			const idRegex = /^[a-zA-Z0-9]{5,15}$/;
			if (userId === "") {
				msg.className = "guide-msg";
				msg.innerText = "한글, 특수문자를 제외한 5~15자 영문, 숫자로 입력해주세요.";
			} else if (idRegex.test(userId)) {
				msg.className = "guide-msg ok";
				msg.innerText = "올바른 형식입니다.";
			} else {
				msg.className = "guide-msg fail";
				msg.innerText = "한글, 특수문자를 제외한 5~15자 영문, 숫자로 입력해주세요.";
			}
		});

		// 비밀번호 전체 조건 체크
		document.querySelector("#userPw").addEventListener("input", function() {
			let pw = this.value.trim();
			let msg = document.querySelector("#pwMsg");
			const pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-=\[\]{}|;':",.<>?])[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{}|;':",.<>?]{10,25}$/;
			if (pw === "") {
				msg.className = "guide-msg";
				msg.innerText = "숫자+영문자+특수문자 조합으로 10~25자리로 입력해주세요.";
			} else if (pwRegex.test(pw)) {
				msg.className = "guide-msg ok";
				msg.innerText = "사용 가능한 비밀번호입니다.";
			} else {
				msg.className = "guide-msg fail";
				msg.innerText = "숫자+영문자+특수문자 조합으로 10~25자리로 입력해주세요.";
			}
			checkPwMatch();
		});

		// 비밀번호 확인 일치 체크
		document.querySelector("#userPwCheck").addEventListener("input", checkPwMatch);

		function checkPwMatch() {
			let pw = document.querySelector("#userPw").value.trim();
			let pwCheck = document.querySelector("#userPwCheck").value.trim();
			let msg = document.querySelector("#pwCheckMsg");
			if (pwCheck === "") {
				msg.className = "guide-msg";
				msg.innerText = "";
			} else if (pw === pwCheck) {
				msg.className = "guide-msg ok";
				msg.innerText = "비밀번호가 일치합니다.";
			} else {
				msg.className = "guide-msg fail";
				msg.innerText = "비밀번호가 일치하지 않습니다.";
			}
		}

		// 비밀번호 표시/숨김
		function togglePw(id, btn) {
			let input = document.querySelector("#" + id);
			if (input.type === "password") {
				input.type = "text";
				btn.innerText = "숨김";
			} else {
				input.type = "password";
				btn.innerText = "표시";
			}
		}

		// 아이디 중복확인 (async/await)
		async function idCheck() {
			let userId = document.querySelector("#userId").value.trim();
			if (userId === "") {
				alert("아이디를 입력하세요.");
				return;
			}
			try {
				let response = await fetch("user/idCheck.do?userId=" + userId);
				let result = await response.text();
				let msg = document.querySelector("#idMsg");
				if (result == "0") {
					msg.className = "guide-msg ok";
					msg.innerText = "사용 가능한 아이디입니다.";
				} else {
					msg.className = "guide-msg fail";
					msg.innerText = "이미 사용 중인 아이디입니다.";
				}
			} catch (e) {
				alert("오류가 발생했습니다.");
			}
		}

		// 가입 버튼 유효성 검사
		function validate() {
			let userId = document.querySelector("#userId").value.trim();
			let userPw = document.querySelector("#userPw").value.trim();
			let userPwCheck = document.querySelector("#userPwCheck").value.trim();
			let userName = document.querySelector("#userName").value.replace(/\s/g, "");
			let idMsg = document.querySelector("#idMsg").innerText;
			const idRegex = /^[a-zA-Z0-9]{5,15}$/;
			const pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-=\[\]{}|;':",.<>?])[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{}|;':",.<>?]{10,25}$/;

			if (userId === "") {
				alert("아이디를 입력하세요."); return false;
			}
			if (!idRegex.test(userId)) {
				alert("아이디 형식이 올바르지 않습니다."); return false;
			}
			if (idMsg !== "사용 가능한 아이디입니다.") {
			     alert("아이디 중복확인을 해주세요."); return false;
			}
			if (userPw === "") {
				alert("비밀번호를 입력하세요."); return false;
			}
			if (!pwRegex.test(userPw)) {
				alert("비밀번호 형식이 올바르지 않습니다."); return false;
			}
			if (userPw !== userPwCheck) {
				alert("비밀번호가 일치하지 않습니다."); return false;
			}
			if (userName === "") {
				alert("이름을 입력해주세요."); return false;
			}
			document.querySelector("#userName").value = userName;
			//alert("이름은 " + userName.length);
			//return false;
			return true;
		}
	</script>
</body>
</html>