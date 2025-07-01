package com.cardgarden.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminMetaBaseController {
	
	
	@Value("${metabase.benefit.url}")
	private String metabasebenefitUrl;
	
	@Value("${metabase.topf.url}")
	private String metabasefUrl;
	
	@Value("${metabase.topm.url}")
	private String metabasemUrl;
	
	
	@Value("${metabase.user.url}")
	private String metabaseuserUrl;
	
	
	@RequestMapping("/metabase")
    public String patternAI(Model model, HttpSession session,RedirectAttributes redirectAttributes) {
		model.addAttribute("metabasebenefitUrl", metabasebenefitUrl);
		model.addAttribute("metabasefUrl", metabasefUrl);
		model.addAttribute("metabasemUrl", metabasemUrl);
		model.addAttribute("metabaseuserUrl", metabaseuserUrl);
		return "admin/metabase";
	}

}
