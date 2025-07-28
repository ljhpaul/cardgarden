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
        System.out.println("===[CustomOAuth2UserService (1)] registrationId: " + registrationId);
        
        OAuth2User oAuth2User = super.loadUser(userRequest);
        
        if ("naver".equals(registrationId)) {
            Map<String, Object> attributes = oAuth2User.getAttributes();
            Object response = attributes.get("response");
            System.out.println("===[CustomOAuth2UserService (2)] naver response: " + response);
            
            if (response instanceof Map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> responseMap = (Map<String, Object>) response;
                System.out.println("===[CustomOAuth2UserService (3)] naver responseMap: " + responseMap);
                
                return new DefaultOAuth2User( Collections.singleton(() -> "ROLE_USER"), responseMap, "id" );
            } else {
                System.out.println("===[CustomOAuth2UserService (4)] response is NOT Map: " + response);
            }
        }
        
        
        if ("kakao".equals(registrationId)) {
            Map<String, Object> attributes = oAuth2User.getAttributes();
            Map<String, Object> flattened = new java.util.HashMap<>();

            // 1. id, connected_at 등 최상위 값 직접 복사
            if (attributes.get("id") != null) {
                flattened.put("id", attributes.get("id"));
            }
            if (attributes.get("connected_at") != null) {
                flattened.put("connected_at", attributes.get("connected_at"));
            }

            // 2. kakao_account map 안의 값들 복사
            Object accountObj = attributes.get("kakao_account");
            if (accountObj instanceof Map) {
                Map<String, Object> account = (Map<String, Object>) accountObj;
                for (Map.Entry<String, Object> entry : account.entrySet()) {
                    flattened.put(entry.getKey(), entry.getValue());
                }
            }

            // 3. properties map(닉네임 등) 복사
            Object propertiesObj = attributes.get("properties");
            if (propertiesObj instanceof Map) {
                Map<String, Object> properties = (Map<String, Object>) propertiesObj;
                for (Map.Entry<String, Object> entry : properties.entrySet()) {
                    flattened.put(entry.getKey(), entry.getValue());
                }
            }

            System.out.println("===[CustomOAuth2UserService (KAKAO)] flattened: " + flattened);

            // id가 고유키
            return new DefaultOAuth2User(Collections.singleton(() -> "ROLE_USER"), flattened, "id");
        }
        
        return oAuth2User;
    }
}