package com.pcwk.ehr.search.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.search.dao.SearchPasswordDao;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class SearchPasswordServiceImpl implements SearchPasswordService {

	@Autowired
	SearchPasswordDao spd;
	
	@Override
	public void sendEmail(UserVO inVO, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; //네이버 이용시 smtp.gmail.com
		String hostSMTPid = "developerkjs89@naver.com";
		String hostSMTPpwd = "roqkfwk1234";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "developerkjs89@naver.com";
		String fromName = "Prefect";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "Prefect 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += inVO.getName() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += inVO.getPassword() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = inVO.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587); //지메일 이용시 465

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public void findPw(HttpServletResponse response, UserVO inVO) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		UserVO user = spd.emailCheck(inVO.getEmail());
		PrintWriter out = response.getWriter();
		// 가입된 아이디가 없으면
		if(mdao.idCheck(vo.getId()) == null) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String password = "";
			for (int i = 0; i < 12; i++) {
				password += (char) ((Math.random() * 26) + 97);
			}
			inVO.setPassword(password);
			// 비밀번호 변경
			mdao.updatePw(vo);
			// 비밀번호 변경 메일 발송
			sendEmail(vo, "findpw");

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}

}
