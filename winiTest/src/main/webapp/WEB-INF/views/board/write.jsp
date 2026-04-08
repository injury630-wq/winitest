<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/"/>
    <title>게시글 등록</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: '맑은 고딕', sans-serif; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 40px auto; background: white; padding: 30px; border: 1px solid #ddd; }
        h2 { font-size: 22px; margin-bottom: 20px; border-left: 4px solid #c0392b; padding-left: 10px; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { width: 120px; padding: 10px; background: #f0f0f0; border: 1px solid #ddd; text-align: center; }
        td { padding: 8px; border: 1px solid #ddd; }
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
    <h2>게시판 등록</h2>
    <form action="board/write.do" method="post" encType="multipart/form-data">
    	<input type="text" name="searchKeyword" value="${searchVO.searchKeyword}">
    	<input type="text" name="searchType" value="${searchVO.searchType}">
        <table>
            <tr>
                <th><span class="required">*</span>작성자</th>
                <td>
                    <input type="text" name="writerId" value="${loginUser.userId}" required placeholder="작성자 입력"/>
                </td>
                <th><span class="required">*</span>비밀번호</th>
                <td>
                    <input type="password" name="writerPw" placeholder="비밀번호 입력"/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>제목</th>
                <td colspan="3">
                    <input type="text" name="title" placeholder="제목 입력"/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>내용</th>
                <td colspan="3">
                    <textarea name="content" placeholder="내용 입력"></textarea>
                </td>
            </tr>
            <tr>
                <th>첨부</th>
                <td colspan="3">
                    <input type="file" multiple name="uploadFile"/><span>shift 혹은 ctrl을 눌러 여러 파일 등록가능합니다.</span>
                </td>
            </tr>
        </table>
        <div class="btn-area">
            <a href="board/list.do" class="btn-cancel">취소</a>
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