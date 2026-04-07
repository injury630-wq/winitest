package com.wini.winitest.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.wini.winitest.vo.BoardFileVO;
import com.wini.winitest.vo.BoardVO;
import com.wini.winitest.vo.SearchVO;

public interface BoardService {
	List<BoardVO> getBoardList(SearchVO searchVO) throws Exception;
	int getBoardTotalCount(SearchVO searchVO) throws Exception;
	void updateHit(int boardNo) throws Exception;
    BoardVO getBoardDetail(int boardNo) throws Exception;
    int deleteBoard(int boardNo) throws Exception;
	int updateBoard(BoardVO boardVO, List<MultipartFile> files) throws Exception;
	int insertReply(BoardVO boardVO, List<MultipartFile> files) throws Exception;
	int insertBoard(BoardVO boardVO, List<MultipartFile> files) throws Exception;
	List<BoardFileVO> getBoardFileList(int boardNo) throws Exception;
	BoardFileVO getBoardFileDetail(int fileNo) throws Exception;
	int deleteBoardFile(int fileNo) throws Exception;
}