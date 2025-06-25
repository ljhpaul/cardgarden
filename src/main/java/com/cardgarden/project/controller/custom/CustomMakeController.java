package com.cardgarden.project.controller.custom;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/make")
public class CustomMakeController {

    @GetMapping("/frame")
    public String makeFrame() {
        return "custom/makeFrame"; 
    }

    @GetMapping("/image")
    public String makeImage() {
        return "custom/makeImage"; 
    }

    @GetMapping("/result")
    public String makeResult() {
        return "custom/makeResult"; 
    }
}
