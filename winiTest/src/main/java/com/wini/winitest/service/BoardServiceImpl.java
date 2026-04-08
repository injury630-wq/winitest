package com.wini.winitest.service;

import java.io.File;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.wini.winitest.mapper.BoardMapper;
import com.wini.winitest.vo.BoardFileVO;
import com.wini.winitest.vo.BoardVO;
import com.wini.winitest.vo.SearchVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

    @Resource(name = "boardMapper")
    private BoardMapper boardMapper;

    // 파일 업로드 경로
    private static final String UPLOAD_PATH = "C:/upload/board/";

    // 게시글 목록 조회 (페이징, 검색 포함)
    @Override
    public List<BoardVO> getBoardList(SearchVO searchVO) throws Exception {
        int totalCount = boardMapper.getBoardTotalCount(searchVO);
        searchVO.setTotalCount(totalCount);
        searchVO.calcPaging();
        return boardMapper.getBoardList(searchVO);
    }

    // 게시글 전체 건수 조회
    @Override
    public int getBoardTotalCount(SearchVO searchVO) throws Exception {
        return boardMapper.getBoardTotalCount(searchVO);
    }

    // 게시글 상세 조회
    @Override
    public BoardVO getBoardDetail(int boardNo) throws Exception {
        return boardMapper.getBoardDetail(boardNo);
    }

    // 조회수 증가
    @Override
    public void updateHit(int boardNo) throws Exception {
        boardMapper.updateHit(boardNo);
    }

    // 파일 저장 (공통 메서드 - 등록/수정/답변글에서 공통으로 사용)
    private void saveFiles(List<MultipartFile> files, int boardNo) throws Exception {
        if(files == null || files.isEmpty()) return;
        // 업로드 폴더 없으면 자동 생성
        File dir = new File(UPLOAD_PATH);
        if(!dir.exists()) dir.mkdirs();
        for(MultipartFile file : files) {
            if(file.isEmpty()) continue;
            // 원본 파일명
            String originalName = file.getOriginalFilename();
            // UUID로 저장명 생성 (같은 이름 파일 덮어쓰기 방지)
            String uuid = UUID.randomUUID().toString();
            String saveName = uuid + "_" + originalName;
            String savePath = UPLOAD_PATH + saveName;
            // 서버 디스크에 파일 저장
            file.transferTo(new File(savePath));
            // DB에 파일 정보 저장
            BoardFileVO boardFileVO = new BoardFileVO();
            boardFileVO.setBoardNo(boardNo);
            boardFileVO.setFileName(originalName); // 화면 표시용 원본명
            boardFileVO.setFilePath(savePath);     // 실제 저장 경로
            boardFileVO.setFileSize(file.getSize()); // 파일 크기(byte)
            boardMapper.insertBoardFile(boardFileVO);
        }
    }

    // 게시글 등록 (파일 포함)
    // 게시글 등록 실패시 파일도 롤백
    @Transactional
    @Override
    public int insertBoard(BoardVO boardVO, List<MultipartFile> files) throws Exception {
        // 게시글 INSERT
        int result = boardMapper.insertBoard(boardVO);
        // 원글이면 ref = 자신의 board_no로 업데이트
        if(boardVO.getRef() == 0) {
            boardMapper.updateRef(boardVO.getBoardNo());
            boardVO.setRef(boardVO.getBoardNo());
        }
        // 파일 저장
        saveFiles(files, boardVO.getBoardNo());
        return result;
    }

    // 게시글 수정
    @Transactional
    @Override
    public int updateBoard(BoardVO boardVO, List<MultipartFile> files) throws Exception {
        // 게시글 UPDATE
        int result = boardMapper.updateBoard(boardVO);
        // 파일 저장
        saveFiles(files, boardVO.getBoardNo());
        return result;
    }

    // 게시글 삭제
    @Transactional
    @Override
    public int deleteBoard(int boardNo) throws Exception {
        boardMapper.deleteBoardFileAll(boardNo); // 파일 DB 먼저 삭제
        return boardMapper.deleteBoard(boardNo); // 게시글 DB 삭제
    }

    // 답변글 등록 (파일 포함)
    // re_seq 업데이트 후 답변글 삽입
    @Transactional
    @Override
    public int insertReply(BoardVO boardVO, List<MultipartFile> files) throws Exception {
        // 답변 대상 글의 re_seq보다 큰 값들 +1 업데이트
        boardMapper.updateReSeq(boardVO);
        // 답변글 depth, 순서 설정
        boardVO.setReLev(boardVO.getReLev() + 1);
        boardVO.setReSeq(boardVO.getReSeq() + 1);
        int result = boardMapper.insertBoard(boardVO);
        // 파일 저장
        saveFiles(files, boardVO.getBoardNo());
        return result;
    }
    
    @Override
    public List<BoardFileVO> getBoardFileList(int boardNo) throws Exception {
        return boardMapper.getBoardFileList(boardNo);
    }
    @Override
    public BoardFileVO getBoardFileDetail(int fileNo) throws Exception {
        return boardMapper.getBoardFileDetail(fileNo);
    }
    
    @Override
    public int deleteBoardFile(int fileNo) throws Exception {
        return boardMapper.deleteBoardFile(fileNo);
    }

	@Override
	public List<BoardFileVO> deleteBoard2(int boardNo) throws Exception {
		// 실제 파일 삭제를 위한 방식
		return null;
	}
}