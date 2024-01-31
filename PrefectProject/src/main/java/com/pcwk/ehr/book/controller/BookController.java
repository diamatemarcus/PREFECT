package com.pcwk.ehr.book.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.book.service.BookSearchService;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;

@Controller
@RequestMapping("book")
public class BookController implements PcwkLogger {
	
	@Autowired
	BookSearchService bookSearchService;
	
	@Autowired
	CodeService codeService;
	
	public BookController() {}
	
	@GetMapping(value = "/doRetrieve.do"
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doRetrieve(DTO inVO)throws IOException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ inVO                              │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv(),"10"));
		if(null !=inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord("겨울");
		}
		     
		
		if(null !=inVO && 0 == inVO.getPageNo()) {
			inVO.setPageNo(1);
		}
		
		if(null !=inVO && 0 == inVO.getPageSize()) {
			inVO.setPageSize(10);
		}
		LOG.debug("2│ inVO                              │"+inVO);
		
		String jsonString = bookSearchService.doBookSearch(inVO);
		
		LOG.debug("jsonString                              │"+jsonString);
		
		return jsonString;
	}
	
	@GetMapping(value="/bookApiView.do")
	public String bookApiView(Model model) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ bookApiView                       │");
		LOG.debug("└───────────────────────────────────┘");
		
		//BOOK_SEARCH,PAGE_SIZE
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"BOOK_SEARCH","PAGE_SIZE"};
		
		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		
		List<CodeVO> bookSearchList=new ArrayList<CodeVO>();
		List<CodeVO> pageSizeList=new ArrayList<CodeVO>();		
		
		for(CodeVO vo :codeList) {
			if(vo.getMstCode().equals("BOOK_SEARCH")) {
				bookSearchList.add(vo);
			}
			
			if(vo.getMstCode().equals("PAGE_SIZE")) {
				pageSizeList.add(vo);
			}	
			//LOG.debug(vo);
		}
		
		//검색조건
		model.addAttribute("bookSearch", bookSearchList);
		
		model.addAttribute("pageSize", pageSizeList);
		
		return "book/booksearch";
	}
	
	
	
}
