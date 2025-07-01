package com.cardgarden.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.cardgarden.project.model.auth.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	private final CustomOAuth2UserService customOAuth2UserService;
	private final OAuth2SuccessHandler successHandler;

	public SecurityConfig(CustomOAuth2UserService customOAuth2UserService,
			OAuth2SuccessHandler successHandler) {
		this.customOAuth2UserService = customOAuth2UserService;
		this.successHandler = successHandler;
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	    http
	        .authorizeRequests()
	            .antMatchers("/", "/css/**", "/js/**", "/images/**", "/user/login", "/user/join/**").permitAll()
	            .antMatchers("/user/join/info").authenticated()
	            .anyRequest().permitAll()
	        .and()
	        .csrf().disable() // 개발시 임시로 해제, 운영시엔 활성화/토큰처리 필요
	        .oauth2Login()
	            // ...
	        ;
	    return http.build();
	}
}
