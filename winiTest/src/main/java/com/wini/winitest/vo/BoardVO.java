package com.wini.winitest.vo;

public class BoardVO {
	private int boardNo;
	private String title;
	private String content;
	private String writerId;
	private String writerPw;
	private int ref; // 글 그룹
	private int reLev; // 그룹내 계층
	private int reSeq; // 그룹내 순서
	private int hit;
	private String regDate;
	private String modiDate;

	public int getReSeq() {
		return reSeq;
	}

	public void setReSeq(int reSeq) {
		this.reSeq = reSeq;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getWriterPw() {
		return writerPw;
	}

	public void setWriterPw(String writerPw) {
		this.writerPw = writerPw;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getReLev() {
		return reLev;
	}

	public void setReLev(int reLev) {
		this.reLev = reLev;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModiDate() {
		return modiDate;
	}

	public void setModiDate(String modiDate) {
		this.modiDate = modiDate;
	}

}
