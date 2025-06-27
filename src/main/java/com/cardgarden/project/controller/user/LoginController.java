package com.cardgarden.project.controller.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cardgarden.project.model.user.dto.LoginRequestDTO;
import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class LoginController {

    @Autowired
    private UserInfoService userInfoSerivce;

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
        if (!userInfoSerivce.existsByLoginId(inputLoginId)) {
            map.put("success", false);
            map.put("message", "존재하지 않는 아이디입니다.");
            return map;
        }

        // 비밀번호 검증
        String password = userInfoSerivce.getPasswordByLoginId(inputLoginId);
        if (!inputLoginPassword.equals(password)) {
            map.put("success", false);
            map.put("message", "비밀번호가 일치하지 않습니다.");
            return map;
        }

        // 로그인 성공
        int loginUserId = userInfoSerivce.getUserIdByLoginId(inputLoginId);
        session.setAttribute("loginUserId", loginUserId);
        session.setMaxInactiveInterval(4000); // 세션 유지 시간 (초)
        
        map.put("success", true);
        map.put("message", "로그인 성공");

        return map;
    }

    // 2. 로그아웃
    @GetMapping("/logout")
    public String logoutProcess(HttpSession session) {
        session.removeAttribute("loginUserId");
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
