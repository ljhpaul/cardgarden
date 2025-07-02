package com.cardgarden.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import com.cardgarden.project.model.auth.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final OAuth2SuccessHandler successHandler;
    private final CustomOAuth2UserService customOAuth2UserService;

    public SecurityConfig(OAuth2SuccessHandler successHandler, 
    		CustomOAuth2UserService customOAuth2UserService) {
        this.successHandler = successHandler;
        this.customOAuth2UserService = customOAuth2UserService;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeRequests()
                .antMatchers("/", "/css/**", "/js/**", "/images/**", "/user/login", "/user/join/**").permitAll()
                .antMatchers("/user/join/info").authenticated()
                .anyRequest().permitAll()
            .and()
            .csrf().disable()
            .oauth2Login()
                .successHandler(successHandler)
                .userInfoEndpoint()
		        	.userService(customOAuth2UserService);
        return http.build();
    }

    // StrictHttpFirewall 설정
    @Bean
    public HttpFirewall allowUrlEncodedDoubleSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();  // // 허용 (주의)
        firewall.setAllowBackSlash(true);
        return firewall;
    }

    // WebSecurityCustomizer로 httpFirewall 등록 (Spring Security 5.7+)
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer(HttpFirewall httpFirewall) {
        return (web) -> web.httpFirewall(httpFirewall);
    }
}
