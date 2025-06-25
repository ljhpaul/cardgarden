package com.cardgarden.project.controller.auth;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    UserInfoService userInfoService;
    
	/** 아이디 중복 체크 */
	@PostMapping("/loginId/check")
	@ResponseBody
	public Map<String, Object> checkLoginId(@RequestParam String loginId) {
		boolean exists = userInfoService.existsByLoginId(loginId);
		Map<String, Object> map = new HashMap<>();
		map.put("duplicate", exists);
		log.info(loginId + " : " + map.toString());
		return map;
	}
    
    /** 이름 존재 유무 체크 */
	@PostMapping("/name/check")
	@ResponseBody
	public Map<String, Object> checkName(@RequestParam String name) {
	    boolean exists = userInfoService.existsByName(name);
	    Map<String, Object> map = new HashMap<>();
	    map.put("duplicate", exists);
	    log.info(name + " : " + map.toString());
	    return map;
	}
	
	/** 닉네임 중복 체크 */
	@PostMapping("/nickname/check")
	@ResponseBody
	public Map<String, Object> checkNickName(@RequestParam String nickname) {
		boolean exists = userInfoService.existsByNickname(nickname);
		Map<String, Object> map = new HashMap<>();
		map.put("duplicate", exists);
		log.info(nickname + " : " + map.toString());
		return map;
	}
}
