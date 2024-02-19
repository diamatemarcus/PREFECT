package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.subject.service.SubjectService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("subject")
public class SubjectController implements PcwkLogger {

	@Autowired
	SubjectService subjectService;
	
	@Autowired
	CodeService codeService;
	
    SubjectVO searchVO = new SubjectVO();

	public SubjectController() {}


	@RequestMapping(value="/doRetrieve.do", method = RequestMethod.GET)
	public String doRetrieve(HttpServletRequest req, Model model) throws SQLException {
	    HttpSession session = req.getSession();
	    String professorEmail = (String) session.getAttribute("userEmail");

	    SubjectVO searchVO = new SubjectVO();
	    searchVO.setProfessor(professorEmail); // 로그인한 교수의 이메일 설정

	    // 검색 조건 처리
	    String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"), "");
	    String searchWord = StringUtil.nvl(req.getParameter("searchWord"), "");
	    searchVO.setSearchDiv(searchDiv);
	    searchVO.setSearchWord(searchWord);

	    // 페이지 번호와 사이즈 처리
	    String pageSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
	    String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");
	    searchVO.setPageSize(Long.parseLong(pageSize));
	    searchVO.setPageNo(Long.parseLong(pageNo));

	    // 조회
	    List<SubjectVO> list = subjectService.doRetrieve(searchVO);
	    model.addAttribute("list", list);
	    model.addAttribute("searchVO", searchVO);

	    // 페이징 처리
	    long totalCnt = list.isEmpty() ? 0 : list.get(0).getTotalCnt();
	    String pageHtml = StringUtil.renderingPager(totalCnt, searchVO.getPageNo(), searchVO.getPageSize(), 10, "/ehr/subject/doRetrieve.do", null);
	    model.addAttribute("pageHtml", pageHtml);

	    return "subject/subject_list"; // 뷰 이름 반환
	}

	
	

	
	 
    // 학생 성적 수정 (교수용)
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdate(SubjectVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                  │inVO:"+inVO);
		LOG.debug("└───────────────────────────────────────────┘");		
				
		int flag = this.subjectService.doUpdate(inVO);
		String message = "";
		if(1==flag) {
			message = inVO.getScore()+"가 수정 되었습니다.";
		}else {
			message = inVO.getScore()+"수정 실패";
		}
		MessageVO messageVO = new MessageVO(flag+"", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:"+jsonString);	
						
		
		return jsonString;
	}

	
	@RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(SubjectVO inVO,HttpServletRequest req, Model model) throws SQLException, EmptyResultDataAccessException {
		String view = "subject/subject_mod";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │inVO:"+inVO);
		LOG.debug("└───────────────────────────────────────────┘");	
		String trainee = req.getParameter("trainee");
		LOG.debug("│ userId                                :"+trainee);		
		
		SubjectVO outVO = this.subjectService.doSelectOne(inVO);
		LOG.debug("│ outVO                                :"+outVO);		

		model.addAttribute("outVO", outVO);
		
		//코드목록 조회 : 'EDUCATION','ROLE'
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"SUBJECT","ROLE"};
		
		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		
		List<CodeVO> subjectList=new ArrayList<CodeVO>();
		List<CodeVO> roleList=new ArrayList<CodeVO>();
		
		
		for(CodeVO vo :codeList) {
			//EDUCATION
			if(vo.getMstCode().equals("SUBJECT")) {
				subjectList.add(vo);
			}
			
			if(vo.getMstCode().equals("ROLE")) {
				roleList.add(vo);
			}	
			LOG.debug(vo);
		}
		
		LOG.debug("subjectList");
		for(CodeVO vo :subjectList) {
			LOG.debug(vo);
		}
		
		LOG.debug("roleList");
		for(CodeVO vo :roleList) {
			LOG.debug(vo);
		}
		
		
		model.addAttribute("subject", subjectList);
		
		model.addAttribute("role",roleList);
		
		return view;
	}
}
