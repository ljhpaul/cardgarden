package com.cardgarden.project.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	UserInfoService userInfoService;
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
    	
    	HttpSession session = request.getSession();
    	
    	OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        String email = oAuth2User.getAttribute("email");
        
        log.info(email);
    	
        if(userInfoService.existsByEmail(email)) {
        	int loginUserId = userInfoService.getUserIdByEmail(email);
        	session.setAttribute("loginUserId", loginUserId);
        	session.setAttribute("mascotId", 120);  // 디폴트 flower 선택
            session.setMaxInactiveInterval(4000);
        	response.sendRedirect("/cardgarden/main");
        } else {
        	session.setAttribute("socialJoin", true);
        	response.sendRedirect("/cardgarden/user/join/term");
        }
    }
	
}
