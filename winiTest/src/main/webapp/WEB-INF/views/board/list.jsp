<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="${pageContext.request.contextPath}/" />
<title>게시판 목록</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: '맑은 고딕', sans-serif;
	background: #f5f5f5;
}

.container {
	max-width: 1000px;
	margin: 40px auto;
	background: white;
	padding: 30px;
	border: 1px solid #ddd;
}

h2 {
	font-size: 22px;
	margin-bottom: 20px;
	border-left: 4px solid #c0392b;
	padding-left: 10px;
}

/* 검색 영역 */
.search-box {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 20px;
}

.search-row {
	display: flex;
	gap: 8px;
	margin-bottom: 8px;
}

.search-row select {
	padding: 7px;
	border: 1px solid #ddd;
	font-size: 14px;
}

.search-row input {
	flex: 1;
	padding: 7px;
	border: 1px solid #ddd;
	font-size: 14px;
}

.search-btn-row {
	text-align: center;
}

.btn-search {
	padding: 8px 30px;
	background: #c0392b;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 14px;
}

.btn-search:hover {
	background: #a93226;
}

/* 목록 영역 */
.total-count {
	font-size: 14px;
	margin-bottom: 8px;
}

.total-count span {
	font-weight: bold;
	color: #c0392b;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
}

thead tr {
	background: #f0f0f0;
	border-top: 2px solid #333;
}

th {
	padding: 10px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

td {
	padding: 10px;
	text-align: center;
	border-bottom: 1px solid #eee;
}

td.title {
	text-align: left;
	max-width: 280px;
}

td.title a {
	text-decoration: none;
	color: #333;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

td.title a:hover {
	color: #c0392b;
	text-decoration: underline;
}
/* 답변글 들여쓰기 */
.re-lev1 {
	padding-left: 20px;
}

.re-lev2 {
	padding-left: 40px;
}

tr:hover {
	background: #fafafa;
}
th, td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #eee;
    border-right: 1px solid #ddd; /* 세로선 추가 */
}

th:last-child, td:last-child {
    border-right: none; /* 마지막 열 오른쪽 선 제거 */
}

/* 페이징 영역 */
.paging {
	text-align: center;
	margin: 20px 0;
}

.paging a {
	display: inline-block;
	padding: 5px 10px;
	margin: 0 2px;
	border: 1px solid #ddd;
	color: #333;
	text-decoration: none;
	font-size: 13px;
}

.paging a:hover {
	background: #c0392b;
	color: white;
	border-color: #c0392b;
}

.paging a.active {
	background: #c0392b;
	color: white;
	border-color: #c0392b;
}

/* 버튼 영역 */
.btn-area {
	text-align: right;
	margin-top: 10px;
}

.btn-write {
	padding: 8px 20px;
	background: #c0392b;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 14px;
	text-decoration: none;
}

.btn-write:hover {
	background: #a93226;
}
</style>
</head>
<body>
	<div class="container">
		<a style="float: right;" href = "user/logout.do">로그아웃</a>
		<h2><a href="board/list.do" style="text-decoration: none; color: inherit">게시판 목록</a></h2>
		<!-- 검색 영역 -->
		<form action="board/list.do" method="get">
			<div class="search-box">
				<div class="search-row">
					<select name="searchType">
						<option value="">전체</option>
						<option value="title"
							<c:if test="${searchVO.searchType == 'title'}">selected</c:if>>제목</option>
						<option value="writer_id"
							<c:if test="${searchVO.searchType == 'writer_id'}">selected</c:if>>작성자</option>
					</select> <input type="text" name="searchKeyword"
						value="${searchVO.searchKeyword}" placeholder="검색어를 입력하세요." />
				</div>
				<div class="search-btn-row">
					<button type="submit" class="btn-search">검색</button>
				</div>
			</div>
		</form>

		<!-- 목록 영역 -->
		<p class="total-count">
			전체 : <span><fmt:formatNumber value="${searchVO.totalCount}"
					pattern="#,###" /></span>건
		</p>
		<table>
			<thead>
				<tr>
					<th style="width: 10%">순번</th>
					<th style="width: 30%">제목</th>
					<th style="width: 30%">작성자</th>
					<th style="width: 15%">등록일</th>
					<th style="width: 13%">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty boardList}">
						<tr>
							<td colspan="5">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="${boardList}" varStatus="status">
							<tr>
								<!--번호 = 전체 게시물 개수 - (현재 페이지 * 페이지당 게시물 개수) - 나열 인덱스 https://mag1c.tistory.com/132 -->
								<td>${searchVO.totalCount - (searchVO.currentPage - 1) * searchVO.pageSize - status.index}</td>
								<td class="title"><a
									href="board/detail.do?boardNo=${board.boardNo}"
									class="re-lev${board.reLev}"> <c:if test="${board.reLev > 0}">ㄴ</c:if> ${board.title}
								</a></td>
								<td>${board.writerId}</td>
								<td>${board.regDate}</td>
								<td>${board.hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<!-- 페이징 영역 -->
		<div class="paging">
				<a
					href="board/list.do?currentPage=1&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&lt;&lt;</a>
			<c:choose> 
				<c:when test="${1 >= searchVO.currentPage}">
				<a
					href="board/list.do?currentPage=1&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&lt;</a>
				</c:when> 
				<c:otherwise>
				<a
					href="board/list.do?currentPage=${searchVO.currentPage	 - 1}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&lt;</a>
				</c:otherwise> 
			</c:choose>

			<c:forEach var="i" begin="${searchVO.startPage}"
				end="${searchVO.endPage}">
				<a
					href="board/list.do?currentPage=${i}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}"
					class="${searchVO.currentPage == i ? 'active' : ''}">${i}</a>
			</c:forEach>

			<c:if test="${searchVO.next}">
			</c:if>
			<c:choose> 
				<c:when test="${searchVO.realEnd <= searchVO.currentPage}">
				<a
					href="board/list.do?currentPage=${searchVO.realEnd}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&gt;</a>
				<a
					href="board/list.do?currentPage=${searchVO.realEnd}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&gt;&gt;</a>
				</c:when> 
				<c:otherwise>
				<a
					href="board/list.do?currentPage=${searchVO.currentPage + 1}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&gt;</a>
				<a
					href="board/list.do?currentPage=${searchVO.realEnd}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&gt;&gt;</a>
				</c:otherwise> 
			</c:choose>
		</div>

		<!-- 버튼 영역 -->
		<div class="btn-area">
			<a href="board/write.do" class="btn-write">글쓰기</a>
		</div>
	</div>
</body>
<script>
	
</script>
</html>