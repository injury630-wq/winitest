<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/"/>
    <title>게시글 수정</title>
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
        /* 파일 목록 */
        .file-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 5px 0;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }
        .btn-file-delete {
            padding: 3px 8px;
            background: #c0392b;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>게시판 수정</h2>
    <form action="board/editProc.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
        <input type="hidden" name="writerPw" value="${board.writerPw}"/>
        <table>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" value="${board.writerId}" readonly/>
                </td>
                <th>등록일</th>
                <td>
                    <input type="text" value="${board.regDate}" readonly/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>제목</th>
                <td colspan="3">
                    <input type="text" name="title" value="${board.title}"/>
                </td>
            </tr>
            <tr>
                <th><span class="required">*</span>내용</th>
                <td colspan="3">
                    <textarea name="content">${board.content}</textarea>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                	<div class="file-item" id="file-item-temp" style="display: none;">
                        <span class="file-name">
                        </span>
                        <button type="button" class="btn-file-delete">X</button>
                    </div>
                    <!-- 기존 파일 목록 -->
                    <div id="file-item-wrap">
                    <c:if test="${not empty fileList}">
                        <c:forEach var="file" items="${fileList}">
                            <div class="file-item">
                                <span>${file.fileName}
                                    [<fmt:formatNumber value="${file.fileSize}" pattern="#,###"/>byte]
                                </span>
                                <button type="button" class="btn-file-delete"
                                    onclick="deleteFile(${file.fileNo})">X</button>
                            </div>
                        </c:forEach>
                    </c:if>
                    </div>
                    <!-- 새 파일 추가 -->
                    <div style="margin-top: 10px;">
                        <input type="file" multiple name="uploadFile"/>
                        <span>shift 혹은 ctrl을 눌러 여러 파일 등록가능합니다.</span>
                    </div>
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
// 파일 개별 삭제
async function deleteFile(fileNo) {
    if(!confirm("파일을 삭제하시겠습니까?")) return;
    try {
        let response = await fetch("board/deleteFile.do?fileNo=" + fileNo);
        let result = await response.json();
        if(result.msg == "success") {
            alert("삭제됐습니다.");
            document.querySelector("#file-item-wrap").innerHTML = "";
            // 파일 목록 그리기
            for (let file of result.fileList) {
                let fileWrapTemp = document.querySelector("#file-item-temp").cloneNode(true);
                fileWrapTemp.removeAttribute("id");
                fileWrapTemp.removeAttribute("style");
                fileWrapTemp.querySelector('.file-name').innerHTML = file.fileName + "[" + file.fileSize.toLocaleString() + " byte]";
                fileWrapTemp.querySelector(".btn-file-delete").addEventListener("click", () => {
                    deleteFile(file.fileNo);
                });
                //${file.fileName} [${file.fileSize.toLocaleString()}byte]
                document.querySelector("#file-item-wrap").append(fileWrapTemp);
            }
            
        } else {
            alert("삭제에 실패했습니다.");
        }
    } catch(e) {
        alert("오류가 발생했습니다.");
    }
}

function validate() {
    let title = document.querySelector("input[name=title]").value.trim();
    let content = document.querySelector("textarea[name=content]").value.trim();
    if(title === "") { alert("제목을 입력하세요."); return false; }
    if(content === "") { alert("내용을 입력하세요."); return false; }
    return true;
}
</script>
</body>
</html>