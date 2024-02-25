package com.pcwk.ehr.board.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.board.service.BoardService;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.file.domain.FileVO;
import com.pcwk.ehr.file.service.AttachFileService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("board")
public class BoardController implements PcwkLogger{

	@Autowired
	BoardService service;
	
	@Autowired
	CodeService  codeService;
	
	@Autowired
	AttachFileService fileService;
	
	public BoardController() {}
	
	@GetMapping(value="/moveToMod.do")
	public String moveToMod(BoardVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
		String view = "";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToMod                         │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
		
		if(0 == inVO.getSeq() ) {
	        throw new NullPointerException("순번을 입력 하세요");
	    }
		
		BoardVO  outVO = service.doSelectOne(inVO);
			
		model.addAttribute("vo", outVO);
		
		// uuid 값을 모델에 추가
	    model.addAttribute("uuid", outVO.getUuid());
		
		// 파일 정보 조회
		List<FileVO> fileList = fileService.getFileUuid(outVO.getUuid());
		model.addAttribute("fileList", fileList);
		
		//DIV코드 조회
		Map<String, Object> codes=new HashMap<String, Object>();
		String[] codeStr = {"BOARD_DIV"};
		codes.put("code", codeStr);
		
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		model.addAttribute("divCode", codeList);
		
		//공지사항:10, 자유게시판:20
		String title = "";
		if(inVO.getDiv().equals("10")) {
			title = "공지사항-수정";
		}else {
			title = "자유게시판-수정";
		}
		model.addAttribute("title", title);	
		
		view = "board/board_mod";
		
		return view;
		
	}
	
	@GetMapping(value="/moveToReg.do")//저 url로 get매핑함
	public String moveToReg(Model model, BoardVO inVO) throws SQLException {
		String viewName = "";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToReg                         │");
		LOG.debug("└───────────────────────────────────┘");		
		
		//DIV코드 조회
		Map<String, Object> codes=new HashMap<String, Object>();
		String[] codeStr = {"BOARD_DIV"};
		codes.put("code", codeStr);
		
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		
		String selectedDiv = inVO.getDiv();
		
		model.addAttribute("divCode", codeList);
		model.addAttribute("paramVO", inVO);
		model.addAttribute("selectedDiv", selectedDiv);
		
		/**
		 * error noUse
		 */
		//공지사항:10, 자유게시판:20
		String title = "";
		if(inVO.getDiv().equals("10")) {
			title = "공지사항-등록";
		}else {
			title = "자유게시판-등록";
		}
		model.addAttribute("title", title);	
		
		viewName = "board/board_reg";///WEB-INF/views/ viewName .jsp
		return viewName;
	}
	
	@GetMapping(value = "/doRetrieve.do")
	public ModelAndView doRetrieve(BoardVO inVO, ModelAndView modelAndView) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		//Default처리
		
		//페이지 사이즈:10
		if(null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10L);
		}

		//페이지 번호:1
		if(null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1L);
		}
		
		//검색구분:""
		if(null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}
		//검색어:""
		if(null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchWord()));
		}
		LOG.debug("│ BoardVO Default처리                          │"+inVO);
		
		//코드목록 조회 : 'PAGE_SIZE','BOARD_SEARCH'
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"PAGE_SIZE","BOARD_SEARCH"};
		
		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		
		List<CodeVO> boardSearchList=new ArrayList<CodeVO>();
		List<CodeVO> pageSizeList=new ArrayList<CodeVO>();
		
		
		for(CodeVO vo :codeList) {
			if(vo.getMstCode().equals("BOARD_SEARCH")) {
				boardSearchList.add(vo);
			}
			
			if(vo.getMstCode().equals("PAGE_SIZE")) {
				pageSizeList.add(vo);
			}	
			//LOG.debug(vo);
		}
		
		//목록조회
		List<BoardVO>  list = service.doRetrieve(inVO);
		
		long totalCnt = 0;
		//총글수 
		for(BoardVO vo  :list) {
			if(totalCnt == 0) {
				totalCnt = vo.getTotalCnt();
				break;
			}
		}
		
		modelAndView.addObject("totalCnt", totalCnt);
		
		//뷰
		modelAndView.setViewName("board/board_list");//  /WEB-INF/views/board/board_list.jsp
		//Model
		modelAndView.addObject("list", list);
		//검색데이터
		modelAndView.addObject("paramVO", inVO);  
		
		//검색조건
		modelAndView.addObject("boardSearch", boardSearchList);
		
		//페이지 사이즈
		modelAndView.addObject("pageSize",pageSizeList);
		
		//페이징
		long bottomCount = StringUtil.BOTTOM_COUNT;//바닥글
		String html = StringUtil.renderingPager(totalCnt, inVO.getPageNo(), inVO.getPageSize(), bottomCount,
				"/ehr/board/doRetrieve.do", "pageDoRerive");
		modelAndView.addObject("pageHtml", html);
		
		//공지사항:10, 자유게시판:20
		String title = "";
		if(inVO.getDiv().equals("10")) {
			title = "공지사항-목록";
		}else {
			title = "자유게시판-목록";
		}
		modelAndView.addObject("title", title);	
		
		
		return modelAndView;   
	}
	
	@PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doUpdate(BoardVO inVO, Model model) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doUpdate                          │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		int flag = service.doUpdate(inVO);
		
		String message = "";
		if(1==flag) {
			message = "수정 되었습니다.";
		}else {
			message = "수정 실패.";
		}
		
		MessageVO messageVO=new MessageVO(flag+"",message);
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
		
	}
	
	@GetMapping(value = "/doSelectOne.do")
	public String doSelectOne(BoardVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
		String view = "board/board_mng";///WEB-INF/views/+board/board_mng+.jsp ->/WEB-INF/views/board/board_mng.jsp
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSelectOne                       │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");			
		if(0 == inVO.getSeq() ) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			
			throw new NullPointerException("순번을 입력 하세요");
		}
		
		if( null==inVO.getRegId()) {
			inVO.setRegId(StringUtil.nvl(inVO.getRegId(),"Guest"));
		}
		
		//session이 있는 경우
		if(null != httpSession.getAttribute("user")) {
			UserVO user = (UserVO) httpSession.getAttribute("user");
			inVO.setRegId(user.getEmail());
		}
		
		BoardVO  outVO = service.doSelectOne(inVO);
		model.addAttribute("vo", outVO);
		
		// 파일 정보 조회
		List<FileVO> fileList = fileService.getFileUuid(outVO.getUuid());
		model.addAttribute("fileList", fileList);
		
		//DIV코드 조회
		Map<String, Object> codes=new HashMap<String, Object>();
		String[] codeStr = {"BOARD_DIV"};
		codes.put("code", codeStr);
		
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		model.addAttribute("divCode", codeList);
		
		//공지사항:10, 자유게시판:20
		String title = "";
		if(inVO.getDiv().equals("10")) {
			title = "공지사항-상세 조회";
		}else {
			title = "자유게시판-상세 조회";
		}
		model.addAttribute("title", title);	
		
		return view;
	}
	
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSave(BoardVO inVO, @RequestParam(value = "uuid", required = false) String uuid) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");				
		//seq조회
		int seq = service.getBoardSeq();
		inVO.setSeq(seq);
		
		inVO.setUuid(uuid);
		
		LOG.debug("│ BoardVO seq                       │"+inVO);
		int flag = service.doSave(inVO);
		
		String message = "";
		if(1 == flag) {
			message = "등록 되었습니다.";
		}else {
			message = "등록 실패.";
		}
		
		MessageVO  messageVO=new MessageVO(String.valueOf(flag), message);
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
	}
	

	@GetMapping(value ="/doDelete.do",produces = "application/json;charset=UTF-8" )//@RequestMapping(value = "/doDelete.do",method = RequestMethod.GET)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doDelete(BoardVO inVO) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
		if(0 == inVO.getSeq() ) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			MessageVO messageVO=new MessageVO(String.valueOf("3"), "순번을 선택 하세요.");
			return messageVO;
		} 
		
		
		int flag = service.doDelete(inVO);
		
		String   message = "";
		if(1==flag) {//삭제 성공
			message = "삭제 되었습니다.";	
		}else {
			message = "삭제 실패!";
		}
		
		MessageVO messageVO=new MessageVO(String.valueOf(flag), message);
		
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
	}
	
	
	
}