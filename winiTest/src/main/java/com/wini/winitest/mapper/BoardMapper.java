package com.wini.winitest.mapper;

import java.util.List;

import com.wini.winitest.vo.BoardFileVO;
import com.wini.winitest.vo.BoardVO;
import com.wini.winitest.vo.SearchVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
    // 게시글
	List<BoardVO> getBoardList(SearchVO searchVO) throws Exception;
	int getBoardTotalCount(SearchVO searchVO) throws Exception;
    BoardVO getBoardDetail(int boardNo) throws Exception; //상세 조회
    int insertBoard(BoardVO boardVO) throws Exception;
    int updateBoard(BoardVO boardVO) throws Exception;
    int deleteBoard(int boardNo) throws Exception;
    int updateHit(int boardNo) throws Exception;

    int updateRef(int boardNo) throws Exception;
    int updateReSeq(BoardVO boardVO) throws Exception; // 그룹 순서

    // 첨부파일
    int insertBoardFile(BoardFileVO boardFileVO) throws Exception; //파일 등록
    List<BoardFileVO> getBoardFileList(int boardNo) throws Exception; //파일 목록 조회
    BoardFileVO getBoardFileDetail(int fileNo) throws Exception;
    int deleteBoardFile(int fileNo) throws Exception;
    int deleteBoardFileAll(int boardNo) throws Exception;
	
}