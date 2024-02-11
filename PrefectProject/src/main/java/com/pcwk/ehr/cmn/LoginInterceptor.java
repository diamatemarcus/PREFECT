package com.pcwk.ehr.cmn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor, PcwkLogger {

	// 컨트롤러로 보내기 전에 인터셉트합니다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 세션 객체 생성
		HttpSession session = request.getSession(); // 현재 세션을 받아옴
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ preHandle()                       │");
		LOG.debug("└───────────────────────────────────┘");

		// 세션에 "user" 속성이 없으면 로그인 페이지로 리다이렉트합니다.
		if (null == session.getAttribute("user")) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ 세션이 null이면 로그인 페이지로 리다이렉트             │");
			LOG.debug("└───────────────────────────────────┘");
			String redirectUrl = request.getContextPath() + "/login/loginView.do";
			LOG.debug("redirectUrl:" + redirectUrl);
			response.sendRedirect(redirectUrl);

			return true;
		}
		return HandlerInterceptor.super.preHandle(request, response, handler);

	}

	/**
	 * Controller 수행 이후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 로그 메시지를 출력합니다.
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ postHandle()                      │");
		LOG.debug("└───────────────────────────────────┘");

		// HandlerInterceptor의 postHandle 메서드를 호출합니다.
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	/**
	 * view까지 처리가 끝나면 호출
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ afterCompletion()                 │");
		LOG.debug("└───────────────────────────────────┘");
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}
