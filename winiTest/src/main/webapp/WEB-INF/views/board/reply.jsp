<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/"/>
    <title>답변글 등록</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: '맑은 고딕', sans-serif; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 40px auto; background: white; padding: 30px; border: 1px solid #ddd; }
        h2 { font-size: 22px; margin-bottom: 20px; border-left: 4px solid #c0392b; padding-left: 10px; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { width: 120px; padding: 10px; background: #f0f0f0; border: 1px solid #ddd; text-align: center; }
        td { padding: 8px; border: 1px solid #ddd; }
        .origin-area { background: #f9f9f9; color: #888; }
        input[type=text], input[type=password] {
            width: 100%; padding: 7px; border: 1px solid #ddd; font-size: 14px;
        }
        textarea {
            width: 100%; height: 300px; padding: 7px;
            border: 1px solid #ddd; font-size: 14px; resize: vertical;
        }
        .btn-area { text-align: center; margin-top: 20px; display: flex; justify-content: center; gap: 10px; }
        .btn-save {
            padding: 8px 30px; background: #c0392b; color: white;
            border: none; cursor: pointer; font-size: 14px;
        }
        .btn-cancel {
            padding: 8px 30px; background: white; color: #333;
            border: 1px solid #aaa; cursor: pointer; font-size: 14px;
            text-decoration: none;
        }
        .btn-save:hover { background: #a93226; }
        .btn-cancel:hover { background: #f5f5f5; }
        .required { color: #c0392b; margin-right: 3px; }
    </style>
</head>
<body>
<div class="container">
    <h2>답변글 등록</h2>

    <!-- 원글 정보 표시 -->
    <table style="margin-bottom: 20px;">
        <tr>
            <th>원글 제목</th>
            <td class="origin-area">${board.title}</td>
        </tr>
        <tr>
            <th>원글 내용</th>
            <td class="origin-area" style="min-height:100px; white-space:pre-wrap;">${board.content}</td>
        </tr>
    </table>

    <form action="board/reply.do" method="post" enctype="multipart/form-data">
        <!-- 답변글 작성에 필요한 원글 정보 hidden으로 전달 -->
        <input type="hidden" name="ref" value="${board.ref}"/>
        <input type="hidden" name="reLev" value="${board.reLev}"/>
        <input type="hidden" name="reSeq" value="${board.reSeq}"/>
        <table>
            <tr>
                <th><span class="required">*</span>작성자</th>
                <td>
                    <input type="text" name="writerId" value="${sessionScope.loginUser.userId}" readonly/>
                </td>
                <th><span class="required">*</span>비밀번호</th>
                <td>
                    <input type="password" name="writerPw" placeholder="비밀번호 입력"/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>제목</th>
                <td colspan="3">
                    <input type="text" name="title" value="Re: ${board.title}"/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>내용</th>
                <td colspan="3">
                    <textarea name="content" placeholder="내용 입력"></textarea>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                    <input type="file" multiple name="uploadFile"/>
                    <span>shift 혹은 ctrl을 눌러 여러 파일 등록가능합니다.</span>
                </td>
            </tr>
        </table>
        <div class="btn-area">
            <a href="board/detail.do?boardNo=${board.boardNo}" class="btn-cancel">취소</a>
            <button type="submit" class="btn-save" onclick="return validate()">저장</button>
        </div>
    </form>
</div>
<script>
function validate() {
    let writerPw = document.querySelector("input[name=writerPw]").value.trim();
    let title = document.querySelector("input[name=title]").value.trim();
    let content = document.querySelector("textarea[name=content]").value.trim();
    if(writerPw === "") { alert("비밀번호를 입력하세요."); return false; }
    if(title === "") { alert("제목을 입력하세요."); return false; }
    if(content === "") { alert("내용을 입력하세요."); return false; }
    return true;
}
</script>
</body>
</html>