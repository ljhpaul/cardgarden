package com.cardgarden.project.controller.card.pattern;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class AiConsumpatternController {
	
	
	@PostMapping("/recommend/noaipattern")
	public Map<String, Object> cardDetailPattern(HttpSession session){
		Integer userId = (Integer) session.getAttribute("loginUserId");
		Map<String, Object> loginResult = new HashMap<>();
		if (userId == null) {
			System.out.println("adasd");
	        loginResult.put("result", "go_need_login");
	        return loginResult;
		}else {
			System.out.println("------");
			loginResult.put("result", "login_good");
	        return loginResult;
		}
		
	}
	
	@PostMapping("/recommend/goodaipattern")
    public boolean cardLikeInsert(HttpSession session, String path){
    	if (path == null) {
    		System.out.println("bdgdf");
    		return false;
    	}
    	System.out.println("bdgdf");
    	session.setAttribute("redirectAfterLogin", path);
    	return true; 
    }
	
}
