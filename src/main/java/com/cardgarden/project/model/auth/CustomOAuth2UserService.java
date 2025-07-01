package com.cardgarden.project.model.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.java.Log;

@Service
@Log
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserInfoService userInfoService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        // 구글(또는 네이버 등)에서 받아온 값
        String email = oAuth2User.getAttribute("email");

        // 이미 회원인지 확인
        if (userInfoService.existsByEmail(email)) {
            // 이미 회원 → 우리 시스템 세션/인증처리 (추가 인증이 필요할 수 있음)
            // 이 부분은 CustomUserDetails 등과 연동 가능
        } else {
            // 회원가입이 필요함 → info 입력 페이지로 이동시킴
            // Security 설정에서 .defaultSuccessUrl("/user/join/info", true) 를 써도 되고,
            // 아니면 SuccessHandler에서 분기해도 됨
        }
        return oAuth2User;
    }
}

