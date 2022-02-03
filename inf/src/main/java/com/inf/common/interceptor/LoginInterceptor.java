package com.inf.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.inf.common.annotation.AdminOnly;
import com.inf.common.annotation.LoginRequired;
import com.inf.common.annotation.MentorOnly;
import com.inf.member.domain.UserVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	Boolean result = true;
    	log.info("인터셉터 접근 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
    	if (handler instanceof HandlerMethod) {
            HandlerMethod hm = (HandlerMethod) handler;
            UserVO sessionUser = (UserVO) request.getSession().getAttribute("user");
            log.info("어노테이션 가졌니? " +hm.hasMethodAnnotation(LoginRequired.class));
//            log.info("user 붙었니? " + sessionUser);
            if(!hm.hasMethodAnnotation(LoginRequired.class)) {
            	return result;
            }
            
            if (hm.hasMethodAnnotation(LoginRequired.class) && sessionUser == null) {
//            	log.info("if문 들어왔니? >>>>>>>>>>>>>>>> ");
            	String referer = request.getRequestURI();
            	response.sendRedirect(request.getContextPath() +"/main/login?referer="+referer);
            	//throw new AuthenticationException(request.getRequestURI());
            	result = false;
            }
            if(hm.hasMethodAnnotation(AdminOnly.class) && sessionUser.getMember_role() != "관리자") {
            	// TODO 권한 없음 에러페이지
            	result = false;
            }
            if(hm.hasMethodAnnotation(MentorOnly.class) && sessionUser.getMember_role() != "멘토") {
            	// TODO 권한 없음 에러페이지
            	result = false;	
            }
        }
        return result;
        // return super.preHandle(request, response, handler);
    }
}

