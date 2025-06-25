package com.cardgarden.project.controller.custom;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;
import com.cardgarden.project.model.custom.service.CustomMakeService;


@Controller
@RequestMapping("/make")
public class CustomMakeController {
    
	@Autowired
    CustomMakeService service;
    
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
    public String makeBackground(
            @RequestParam(name = "type") String type,
            @RequestParam(name = "direction") String direction,
            HttpSession session,
            Model model) {

        Integer loginUserId = (Integer) session.getAttribute("loginUserId");
        if (loginUserId == null) {
            return "redirect:/user/login";
        }

        model.addAttribute("type", type);
        model.addAttribute("direction", direction);

        List<CustomAssetDTO> backgroundList = service.getBackgroundList();

        List<Integer> ownedList = service.getOwnedBackgroundList(loginUserId);

        for (CustomAssetDTO bg : backgroundList) {
            bg.setOwn(ownedList.contains(bg.getAsset_id()));
        }

        model.addAttribute("backgroundList", backgroundList);

        return "custom/makeBackground";
    }


    

    private boolean checkLogin(HttpSession session) {
        return session.getAttribute("loginUserId") != null;
    }
}
