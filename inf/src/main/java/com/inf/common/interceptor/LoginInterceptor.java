package com.inf.common.interceptor;

import javax.security.sasl.AuthenticationException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.cglib.proxy.Dispatcher;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

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
    	log.info("인터셉터 접근 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
//    	log.info(handler instanceof HandlerMethod);
    	if (handler instanceof HandlerMethod) {
            HandlerMethod hm = (HandlerMethod) handler;
            UserVO sessionUser = (UserVO) request.getSession().getAttribute("user");
//            log.info("어노테이션 가졌니? " +hm.hasMethodAnnotation(LoginRequired.class));
//            log.info("user 붙었니? " + sessionUser);
            if (hm.hasMethodAnnotation(LoginRequired.class) && sessionUser == null) {
//            	log.info("if문 들어왔니? >>>>>>>>>>>>>>>> ");
            	String referer = request.getRequestURI();
            	response.sendRedirect(request.getContextPath() +"/main/login?referer="+referer);
            	return false;
            	//throw new AuthenticationException(request.getRequestURI());
            }
            if(hm.hasMethodAnnotation(AdminOnly.class) && sessionUser.getMember_role() != "관리자") {
            	// 권한 없음 에러페이지
            	return false;
            }
            if(hm.hasMethodAnnotation(MentorOnly.class) && sessionUser.getMember_role() != "멘토") {
            	// 권한 없음 에러페이지
            	return false;
            }
        }
        return true;
        //return super.preHandle(request, response, handler);
    }
}

