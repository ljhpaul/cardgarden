package com.cardgarden.project.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.cardgarden.project.model.user.service.UserInfoService;

@Configuration
@EnableWebSecurity
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	UserInfoService userInfoService;
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
    	
    	OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        String email = oAuth2User.getAttribute("email");
    	
        if(userInfoService.existsByEmail(email)) {
        	response.sendRedirect("/user/login");
        } else {
        	response.sendRedirect("/user/join/info");
        }
        
    }
	
}
