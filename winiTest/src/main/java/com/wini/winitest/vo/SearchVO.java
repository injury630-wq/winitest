package com.wini.winitest.vo;

public class SearchVO {

    // 검색 관련
    private String searchType;      // 검색조건
    private String searchKeyword;   // 검색어

    // 페이징 관련
    private int currentPage;        // 현재 페이지
    private int pageSize;           // 페이지당 출력 행수 (기본 10)
    private int totalCount;         // 총 데이터 수
    private int viewPage;           // 화면에 보여줄 페이지 개수 (기본 10)
    private int startPage;          // 시작 페이지
    private int endPage;            // 마지막 페이지
    private int realEnd;            // 실제 마지막 페이지
    private boolean next;           // 다음 페이지 여부
    private boolean prev;           // 이전 페이지 여부

    // 기본값 설정
    public SearchVO() {
        this.currentPage = 1;
        this.pageSize = 10;
        this.viewPage = 10;
    }

    // DB 조회 시작 행 계산
    public int getStartRow() {
        return (currentPage - 1) * pageSize;
    }

    // 페이징 계산
    public void calcPaging() {
        this.endPage = (int)(Math.ceil((double) currentPage / viewPage) * viewPage);
        this.startPage = this.endPage - (viewPage - 1);
        this.realEnd = (int)(Math.ceil((double) totalCount / pageSize));
        this.realEnd = this.realEnd == 0 ? startPage : this.realEnd;
        this.endPage = this.endPage > this.realEnd ? this.realEnd : this.endPage;
        this.prev = this.startPage > 1;
        this.next = this.endPage < this.realEnd;
    }

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getViewPage() {
		return viewPage;
	}

	public void setViewPage(int viewPage) {
		this.viewPage = viewPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getRealEnd() {
		return realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

    
}