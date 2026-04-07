<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/"/>
    <title>게시글 조회</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: '맑은 고딕', sans-serif; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 40px auto; background: white; padding: 30px; border: 1px solid #ddd; }
        h2 { font-size: 22px; margin-bottom: 20px; border-left: 4px solid #c0392b; padding-left: 10px; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { width: 120px; padding: 10px; background: #f0f0f0; border: 1px solid #ddd; text-align: center; }
        td { padding: 10px; border: 1px solid #ddd; word-break: break-all; }
        .content-area { min-height: 200px; white-space: pre-wrap; }
        .btn-area { display: flex; justify-content: space-between; margin-top: 20px; align-items: center; }
        .btn-left { display: flex; gap: 10px; }
        .btn-right { display: flex; gap: 10px; align-items: center; }
        .btn {
            padding: 8px 20px; border: none; cursor: pointer;
            font-size: 14px; text-decoration: none; display: inline-block;
        }
        .btn-list { background: #888; color: white; }
        .btn-reply { background: #2980b9; color: white; }
        .btn-edit { background: #27ae60; color: white; border: none; cursor: pointer; }
        .btn-delete { background: #c0392b; color: white; }
        .btn:hover { opacity: 0.85; }
        .pw-input {
            padding: 7px; border: 1px solid #ddd;
            font-size: 14px; width: 150px;
        }
        .error-msg { color: red; font-size: 13px; margin-top: 8px; }
    </style>
</head>
<body>
<div class="container">
    <h2>게시판 조회</h2>
    <table>
        <tr>
            <th>제목</th>
            <td colspan="3">${board.title}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.writerId}</td>
            <th>등록일</th>
            <td>${board.regDate}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td colspan="3">${board.hit}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="3" class="content-area">${board.content}</td>
        </tr>
		<tr>
		    <th>첨부파일</th>
		    <td colspan="3">
		        <c:choose>
		            <c:when test="${empty fileList}">
		                첨부파일 없음
		            </c:when>
		            <c:otherwise>
		                <c:forEach var="file" items="${fileList}">
		                    <div>
		                        <a href="board/download.do?fileNo=${file.fileNo}">
		                            ${file.fileName}
		                        </a>
		                        [<fmt:formatNumber value="${file.fileSize}" pattern="#,###" /> byte]
		                    </div>
		                </c:forEach>
		            </c:otherwise>
		        </c:choose>
		    </td>
		</tr>
    </table>

    <c:if test="${param.pwError == '1'}">
        <p class="error-msg">비밀번호가 틀렸습니다.</p>
    </c:if>

    <!-- 삭제용 hidden form -->
    <form id="deleteForm" method="post" action="board/delete.do">
        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
        <input type="hidden" id="writerPwHidden" name="writerPw" value=""/>
    </form>

    <!-- 수정용 hidden form -->
    <form id="editForm" method="post" action="board/edit.do">
        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
        <input type="hidden" id="editPwHidden" name="writerPw" value=""/>
    </form>

    <div class="btn-area">
        <div class="btn-left">
            <a href="board/list.do" class="btn btn-list">목록</a>
        </div>
        <div class="btn-right">
            <input type="password" id="writerPw" class="pw-input" placeholder="비밀번호 입력"/>
            <button class="btn btn-edit" onclick="goEdit()">수정</button>
            <button class="btn btn-delete" onclick="goDeleteProc()">삭제</button>
            <!-- 수정_백엔드에서 등록못하게 막아야함 -->
            <c:if test ="${board.reLev < 2}"><a href="board/reply.do?boardNo=${board.boardNo}" class="btn btn-reply">답변등록</a></c:if>
        </div>
    </div>
</div>
<script>
function goDeleteProc() {
    let pw = document.querySelector("#writerPw").value.trim();
    if(pw === "") { alert("비밀번호를 입력하세요."); return; }
    if(confirm("삭제하시겠습니까?")) {
        document.querySelector("#writerPwHidden").value = pw;
        document.querySelector("#deleteForm").submit();
    }
}

function goEdit() {
    let pw = document.querySelector("#writerPw").value.trim();
    if(pw === "") { alert("비밀번호를 입력하세요."); return; }
    document.querySelector("#editPwHidden").value = pw;
    document.querySelector("#editForm").submit();
}
</script>
</body>
</html>