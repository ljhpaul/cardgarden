package com.cardgarden.project.controller.user;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cardgarden.project.model.user.dto.LoginRequestDTO;
import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class LoginController {

    @Autowired
    private UserInfoService userInfoService;

    // 1-1. 로그인 입력창
    @GetMapping("/login")
    public String loginFormView(HttpSession session) {

        return "login/loginForm";
    }

    // 1-2. 로그인 처리
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> loginProcess(HttpSession session, LoginRequestDTO inputData) {
    	
        Map<String, Object> map = new HashMap<>();

        String inputLoginId = inputData.getUser_name();
        String inputLoginPassword = inputData.getUser_password();

        log.info("(" + inputLoginId + ", " + inputLoginPassword + ")");

        // 아이디 검증
        if (!userInfoService.existsByLoginId(inputLoginId)) {
            map.put("success", false);
            map.put("message", "존재하지 않는 아이디입니다.");
            return map;
        }

        // 비밀번호 검증
        String password = userInfoService.getPasswordByLoginId(inputLoginId);
        if (!inputLoginPassword.equals(password)) {
            map.put("success", false);
            map.put("message", "비밀번호가 일치하지 않습니다.");
            return map;
        }

        // 로그인 성공
        int loginUserId = userInfoService.getUserIdByLoginId(inputLoginId);
        session.setAttribute("loginUserId", loginUserId);
        session.setAttribute("mascotBrand", "flower");  // 디폴트 flower 선택
        session.setMaxInactiveInterval(4000);
        map.put("success", true);
        map.put("message", "로그인 성공");
        
        // 로그인 후 리다이렉트 경로 분기
        String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
        if(redirectAfterLogin == null || redirectAfterLogin.equals("")) {
        	map.put("redirectAfterLogin", "/main");
        } else {
        	map.put("redirectAfterLogin", redirectAfterLogin);
        	session.removeAttribute("redirectAfterLogin");
        }

        return map;
    }

    // 2. 로그아웃
    @GetMapping("/logout")
    public String logoutProcess(HttpSession session, RedirectAttributes redirectAttributes) {
        session.removeAttribute("loginUserId");
        session.removeAttribute("userLike");    // 좋아요 카운트도 제거
        return "redirect:/main";
    }

    @GetMapping("/session-remaining")
    @ResponseBody
    public Map<String, Object> getRemainingSessionTime(HttpSession session) {
        Map<String, Object> map = new HashMap<>();

        Object userId = session.getAttribute("loginUserId");

        if (userId == null) {
            map.put("loggedIn", false);  // 로그인 안됨
        } else {
            int total = session.getMaxInactiveInterval();
            long last = session.getLastAccessedTime();
            long now = System.currentTimeMillis();
            int remainSec = (int) (total - (now - last) / 1000);

            map.put("loggedIn", true);
            map.put("remaining", remainSec);
        }

        return map;
    }


}
