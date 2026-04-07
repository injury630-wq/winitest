package com.wini.winitest.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wini.winitest.service.BoardService;
import com.wini.winitest.vo.BoardFileVO;
import com.wini.winitest.vo.BoardVO;
import com.wini.winitest.vo.SearchVO;
import com.wini.winitest.vo.UserVO;

@Controller
public class BoardController {

    @Resource(name = "boardService")
    private BoardService boardService;

    // 게시판 목록
    @RequestMapping(value = "/board/list.do", method = RequestMethod.GET)
    public String boardList(@ModelAttribute SearchVO searchVO, Model model, HttpSession session) throws Exception {
        model.addAttribute("boardList", boardService.getBoardList(searchVO));
        model.addAttribute("searchVO", searchVO);
        return "board/list";
    }

    // 게시글 등록 페이지
    @RequestMapping(value = "/board/write.do", method = RequestMethod.GET)
    public String writeView(HttpSession session) throws Exception {
        return "board/write";
    }

 // 게시글 등록 처리
    @RequestMapping(value = "/board/write.do", method = RequestMethod.POST)
    public String write(@ModelAttribute BoardVO boardVO,
                        @RequestParam(value="uploadFile", required=false) List<MultipartFile> files,
                        HttpSession session) throws Exception {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boardVO.setWriterId(loginUser.getUserId());
        boardService.insertBoard(boardVO, files);
        return "redirect:/board/list.do";
    }

    // 게시글 상세 조회
    @RequestMapping(value = "/board/detail.do", method = RequestMethod.GET)
    public String detail(@RequestParam int boardNo, Model model, HttpSession session) throws Exception {
    	boardService.updateHit(boardNo);
    	// 파일 목록, 글 정보 각각 조회
        model.addAttribute("board", boardService.getBoardDetail(boardNo));
        model.addAttribute("fileList", boardService.getBoardFileList(boardNo));
        return "board/detail";
    }

    // 게시글 수정 페이지
    @RequestMapping(value = "/board/edit.do", method = RequestMethod.POST)
    public String editView(@ModelAttribute BoardVO boardVO, Model model) throws Exception {
    	int boardNo = boardVO.getBoardNo(); 
    	BoardVO board = boardService.getBoardDetail(boardNo);
    	if(board.getWriterPw().equals(boardVO.getWriterPw())) {
    		model.addAttribute("board", board);
    		model.addAttribute("fileList", boardService.getBoardFileList(boardNo));
            return "/board/edit";
        } else {
            return "redirect:/board/detail.do?boardNo=" + boardNo + "&pwError=1";
        }
    }

 // 게시글 수정 처리
    @RequestMapping(value = "/board/editProc.do", method = RequestMethod.POST)
    public String edit(@ModelAttribute BoardVO boardVO,
                       @RequestParam(value="uploadFile", required=false) List<MultipartFile> files) throws Exception {
        boardService.updateBoard(boardVO, files);
        return "redirect:/board/detail.do?boardNo=" + boardVO.getBoardNo();
    }
    
    // 게시글 삭제 처리
    @RequestMapping(value = "/board/delete.do", method = RequestMethod.POST)
    public String delete(@RequestParam int boardNo, @RequestParam String writerPw) throws Exception {
        BoardVO board = boardService.getBoardDetail(boardNo);
        // 없는 글 삭제 요청 -> 리스트로 이동 에러쿼리스트링
        if(board == null) return "redirect:/board/list.do?nullEroor=1";
        
        if(board.getWriterPw().equals(writerPw)) {
            boardService.deleteBoard(boardNo);
            return "redirect:/board/list.do";
        } else {
            return "redirect:/board/detail.do?boardNo=" + boardNo + "&pwError=1";
        }
    }
    
    // 파일 다운로드
//    @RequestMapping(value = "/board/download.do", method = RequestMethod.GET)
//    public void download(@RequestParam int fileNo,
//                         HttpServletResponse response) throws Exception {
//
//        // 1. DB에서 파일 정보 조회
//        BoardFileVO file = boardService.getBoardFileDetail(fileNo);
//
//        // 2. 실제 파일 읽기
//        File downloadFile = new File(file.getFilePath());
//        byte[] fileByte = FileUtils.readFileToByteArray(downloadFile);
//
//        // 3. 다운로드 응답 설정
//        response.setContentType("application/octet-stream");
//        response.setContentLength(fileByte.length);
//        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(file.getFileName(), "UTF-8") + "\"");
//
//        // 4. 파일 전송
//        response.getOutputStream().write(fileByte);
//        response.getOutputStream().flush();
//        response.getOutputStream().close();
//    }
    @RequestMapping(value = "/board/download.do")
    public ResponseEntity<org.springframework.core.io.Resource> downloadFile(@RequestParam("fileNo") int fileNo) throws Exception {

        // 1. 파일 정보 조회
        BoardFileVO file = boardService.getBoardFileDetail(fileNo);

        if (file == null) {
            throw new FileNotFoundException("파일 정보 없음");
        }

        // 2. 파일 경로 생성
        File downloadFile = new File(file.getFilePath());

        if (!downloadFile.exists()) {
            throw new FileNotFoundException("파일이 존재하지 않습니다.");
        }

        // 3. Resource 생성
        org.springframework.core.io.Resource resource = new FileSystemResource(downloadFile);

        // 4. 파일명 인코딩 (한글 대응)
        String fileName = file.getFileName();
        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

        // 5. ResponseEntity 생성
        return ResponseEntity.ok()
                .header("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"")
                .header("Content-Length", String.valueOf(downloadFile.length()))
                .header("Content-Type", "application/octet-stream")
                .body(resource);
    }
    
    // 파일 개별 삭제 (Ajax)
    @ResponseBody
    @RequestMapping(value = "/board/deleteFile.do", method = RequestMethod.GET)
    public Map<String, Object> deleteFile(@RequestParam int fileNo) throws Exception {
    	Map<String, Object> response = new HashMap<>();
        try {
            // DB에서 파일 정보 조회
            BoardFileVO file = boardService.getBoardFileDetail(fileNo);
            // 실제 파일 삭제
            File deleteFile = new File(file.getFilePath());
            if(deleteFile.exists()) deleteFile.delete();
            // DB에서 파일 정보 삭제
            boardService.deleteBoardFile(fileNo);
            // view에 그릴 파일리스트 정보 저장
            int boardNo = file.getBoardNo();
            List<BoardFileVO> fileList = boardService.getBoardFileList(boardNo);
            response.put("msg", "success");
            response.put("fileList", fileList);
        } catch(Exception e) {
        	response.put("msg", "fail");
        }
        return response;
    }
    

    // 답변글 페이지
    @RequestMapping(value = "/board/reply.do", method = RequestMethod.GET)
    public String replyView(@RequestParam int boardNo, Model model, HttpSession session) throws Exception {
        model.addAttribute("board", boardService.getBoardDetail(boardNo));
        return "board/reply";
    }

 // 답변글 등록 처리
    @RequestMapping(value = "/board/reply.do", method = RequestMethod.POST)
    public String reply(@ModelAttribute BoardVO boardVO,
                        @RequestParam(value="uploadFile", required=false) List<MultipartFile> files,
                        HttpSession session) throws Exception {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boardVO.setWriterId(loginUser.getUserId());
        boardService.insertReply(boardVO, files);
        return "redirect:/board/list.do";
    }
}