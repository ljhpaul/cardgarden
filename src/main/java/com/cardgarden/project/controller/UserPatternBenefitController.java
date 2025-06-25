package com.cardgarden.project.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.userPatternBenefit.UserPatternBenefitDTO;
import com.cardgarden.project.model.userPatternBenefit.UserPatternBenefitService;

@Controller
@RequestMapping("/recommend")
public class UserPatternBenefitController {
    @Autowired
    private UserPatternBenefitService userPatternBenefitService;

    @RequestMapping("/ai")
    public String patternAI(Model model, HttpSession session) {
    	Integer userId = (Integer) session.getAttribute("loginUserId");
    	if (userId == null) {
    	    return "redirect:/user/login";
    	}
        List<UserPatternBenefitDTO> dataList = userPatternBenefitService.selectByIdConsumPattern(userId);

        Map<Integer, List<UserPatternBenefitDTO>> mapData = new LinkedHashMap<>();
        for (UserPatternBenefitDTO dto : dataList) {
            int groupKey = dto.getPattern().getPattern_id();
            mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        model.addAttribute("patternList", mapData);
        return "recommend/ai";
    }

}
