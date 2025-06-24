package com.cardgarden.project.controller.custom;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/make")
public class CustomMakeController {

    @GetMapping("/frame")
    public String makeFrame(HttpSession session, Model model,
                            @RequestParam(name = "type", required = false, defaultValue = "largechip") String type,
                            @RequestParam(name = "direction", required = false, defaultValue = "portrait") String direction) {

        boolean isLogin = checkLogin(session);
        model.addAttribute("isLogin", isLogin);
        model.addAttribute("selectedType", type);
        model.addAttribute("selectedDirection", direction);

        return "custom/makeFrame";
    }

    @GetMapping("/background")
    public String makeBackground(@RequestParam String type,
                                 @RequestParam String direction,
                                 HttpSession session, Model model) {

        if (!checkLogin(session)) {
            return "redirect:/user/login";
        }

        model.addAttribute("type", type);
        model.addAttribute("direction", direction);

        return "custom/makeBackground";
    }

    private boolean checkLogin(HttpSession session) {
        return session.getAttribute("loginUserId") != null;
    }
}
