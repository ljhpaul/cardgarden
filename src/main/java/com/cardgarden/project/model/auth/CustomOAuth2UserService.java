package com.cardgarden.project.model.auth;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Map;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        System.out.println("===[CustomOAuth2UserService] registrationId: " + registrationId);
        
        OAuth2User oAuth2User = super.loadUser(userRequest);
        
        if ("naver".equals(registrationId)) {
            Map<String, Object> attributes = oAuth2User.getAttributes();
            Object response = attributes.get("response");
            System.out.println("===[CustomOAuth2UserService] naver response: " + response);
            
            if (response instanceof Map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> responseMap = (Map<String, Object>) response;
                System.out.println("===[CustomOAuth2UserService] naver responseMap: " + responseMap);
                
                return new DefaultOAuth2User(
                        Collections.singleton(() -> "ROLE_USER"),
                        responseMap, "id" );
            } else {
                System.out.println("===[CustomOAuth2UserService] response is NOT Map: " + response);
            }
        }
        
        return oAuth2User;
    }
}