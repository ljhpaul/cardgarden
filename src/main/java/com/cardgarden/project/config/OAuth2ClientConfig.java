package com.cardgarden.project.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;

@Configuration
public class OAuth2ClientConfig {
	
    @Value("${oauth2.google.client-id}")
    private String googleClientId;
    @Value("${oauth2.google.client-secret}")
    private String googleClientSecret;
    
    @Value("${oauth2.naver.client-id}")
    private String naverClientId;
    @Value("${oauth2.naver.client-secret}")
    private String naverClientSecret;
    
    @Value("${oauth2.kakao.client-id}")
    private String kakaoClientId;
    @Value("${oauth2.kakao.client-secret}")
    private String kakaoClientSecret;

	
    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        ClientRegistration google = ClientRegistration.withRegistrationId("google")
            .clientId(googleClientId)
            .clientSecret(googleClientSecret)
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
            .scope("email", "profile")
            .authorizationUri("https://accounts.google.com/o/oauth2/v2/auth")
            .tokenUri("https://oauth2.googleapis.com/token")
            .userInfoUri("https://openidconnect.googleapis.com/v1/userinfo")
            .userNameAttributeName("sub")
            .clientName("Google")
            .build();
        
        ClientRegistration naver = ClientRegistration.withRegistrationId("naver")
        		.clientId(naverClientId)
        		.clientSecret(naverClientSecret)
        		.clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
        		.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
        		.redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
        		.scope("name", "email")
        		.authorizationUri("https://nid.naver.com/oauth2.0/authorize")
        		.tokenUri("https://nid.naver.com/oauth2.0/token")
        		.userInfoUri("https://openapi.naver.com/v1/nid/me")
        		.userNameAttributeName("response")
        		.clientName("Naver")
        		.build();
        
        ClientRegistration kakao = ClientRegistration.withRegistrationId("kakao")
        	    .clientId(kakaoClientId)
        	    .clientSecret(kakaoClientSecret)
        	    .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_POST)
        	    .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
        	    .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
        	    .scope("account_email")
        	    .authorizationUri("https://kauth.kakao.com/oauth/authorize")
        	    .tokenUri("https://kauth.kakao.com/oauth/token")
        	    .userInfoUri("https://kapi.kakao.com/v2/user/me")
        	    .userNameAttributeName("id")
        	    .clientName("Kakao")
        	    .build();
        
        return new InMemoryClientRegistrationRepository(google, naver, kakao);
    }
}
