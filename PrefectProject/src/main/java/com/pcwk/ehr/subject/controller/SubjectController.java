package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.subject.service.SubjectService;

@Controller
@RequestMapping("/subject")
public class SubjectController {
    final Logger LOG = LogManager.getLogger(getClass());

    @Autowired
    SubjectService subjectService;

    @Autowired
    CodeService codeService;

    // 과목 조회
    @RequestMapping(value = "/doRetrieve.do", method = RequestMethod.GET)
    public String doRetrieve(SubjectVO searchVO, HttpServletRequest req, Model model) throws SQLException {
        String view = "subject/subject_list";
        LOG.debug("┌───────────────────────────────────────────┐");
        LOG.debug("│ doRetrieve                               │DTO:" + searchVO);
        LOG.debug("└───────────────────────────────────────────┘");

        // 검색 파라미터 처리
        // ...

        // 서비스에서 과목 목록 가져오기
        List<SubjectVO> list = this.subjectService.doRetrieve(searchVO);

        // 모델에 과목 목록 및 검색 조건 추가
        model.addAttribute("list", list);
        model.addAttribute("searchVO", searchVO);

        // 페이지 처리 로직 추가 가능

        return view;
    }

    // 과목 단건 조회
    @RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET)
    public String doSelectOne(SubjectVO inVO, HttpServletRequest req, Model model)
            throws SQLException, EmptyResultDataAccessException {
        String view = "subject/subject_mod";
        LOG.debug("┌───────────────────────────────────────────┐");
        LOG.debug("│ doSelectOne                              │inVO:" + inVO);
        LOG.debug("└───────────────────────────────────────────┘");

        // 서비스에서 과목 상세 정보 가져오기
        SubjectVO outVO = this.subjectService.doSelectOne(inVO);

        // 모델에 과목 상세 정보 추가
        model.addAttribute("outVO", outVO);

        // 추가 처리가 필요한 경우 여기에 추가

        return view;
    }

    // 과목 수정
    @RequestMapping(value = "/doUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doUpdate(SubjectVO inVO) throws SQLException {
        String jsonString = "";
        LOG.debug("┌───────────────────────────────────────────┐");
        LOG.debug("│ doUpdate                                 │inVO:" + inVO);
        LOG.debug("└───────────────────────────────────────────┘");

        // 서비스를 사용하여 과목 수정
        int flag = this.subjectService.doUpdate(inVO);

        // 응답 메시지 준비
        String message = (flag == 1) ? "과목이 성공적으로 수정되었습니다." : "과목 수정에 실패했습니다.";
        Map<String, Object> response = new HashMap<>();
        response.put("flag", flag);
        response.put("message", message);

        // 응답을 JSON으로 변환
        jsonString = new Gson().toJson(response);
        LOG.debug("jsonString:" + jsonString);

        return jsonString;
    }

    // 과목 삭제
    @RequestMapping(value = "/doDelete.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doDelete(SubjectVO inVO, HttpServletRequest req) throws SQLException {
        String jsonString = "";
        LOG.debug("┌───────────────────────────────────────────┐");
        LOG.debug("│ doDelete                                 │inVO:" + inVO);
        LOG.debug("└───────────────────────────────────────────┘");

        // 서비스를 사용하여 과목 삭제
        int flag = this.subjectService.doDelete(inVO);

        // 응답 메시지 준비
        String message = (flag == 1) ? "과목이 성공적으로 삭제되었습니다." : "과목 삭제에 실패했습니다.";
        Map<String, Object> response = new HashMap<>();
        response.put("flag", flag);
        response.put("message", message);

        // 응답을 JSON으로 변환
        jsonString = new Gson().toJson(response);
        LOG.debug("jsonString:" + jsonString);

        return jsonString;
    }

    // 추가적인 메서드가 필요한 경우 추가할 수 있습니다.
}
