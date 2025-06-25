package com.cardgarden.project.controller.custom;

import java.io.*;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;
import com.cardgarden.project.model.custom.service.CustomMakeService;

@Controller
@RequestMapping("/make")
public class CustomMakeController {
    
    @Autowired
    CustomMakeService service;
    
    @GetMapping("/frame")
    public String makeFrame(HttpSession session, Model model,
                            @RequestParam(name = "type", required = false, defaultValue = "largechip") String type) {

        boolean isLogin = checkLogin(session);
        model.addAttribute("isLogin", isLogin);
        model.addAttribute("selectedType", type);

        return "custom/makeFrame";
    }

    @GetMapping("/background")
    public String makeBackground(
            @RequestParam(name = "type") String type,
            HttpSession session,
            Model model) {

        Integer loginUserId = (Integer) session.getAttribute("loginUserId");
        if (loginUserId == null) {
            return "redirect:/user/login";
        }

        model.addAttribute("type", type);
        
        List<CustomAssetDTO> backgroundList = service.getBackgroundList();
        List<Integer> ownedList = service.getOwnedBackgroundList(loginUserId);

        for (CustomAssetDTO bg : backgroundList) {
            bg.setOwn(ownedList.contains(bg.getAsset_id()));
        }

        model.addAttribute("backgroundList", backgroundList);

        return "custom/makeBackground";
    }

    @GetMapping("/sticker")
    public String makeSticker(@RequestParam String type,
                              @RequestParam String background,
                              HttpSession session,
                              Model model) {

        Integer loginUserId = (Integer) session.getAttribute("loginUserId");
        if (loginUserId == null) {
            return "redirect:/user/login";
        }

        model.addAttribute("type", type);
        model.addAttribute("background", background);

        List<CustomAssetDTO> stickerList = service.getStickerList();
        List<Integer> ownedList = service.getOwnedStickerList(loginUserId);

        for (CustomAssetDTO sticker : stickerList) {
            sticker.setOwn(ownedList.contains(sticker.getAsset_id()));
        }

        model.addAttribute("stickerList", stickerList);

        return "custom/makeSticker";
    }

 // 이미지 저장
    @PostMapping("/saveImage")
    @ResponseBody
    public String saveImage(@RequestBody Map<String, String> data, HttpSession session) {
        try {
            String imageData = data.get("imageData");
            String cardName = data.get("cardName");

            Integer loginUserId = (Integer) session.getAttribute("loginUserId");
            if (loginUserId == null) {
                return "로그인 필요";
            }

            String base64 = imageData.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(base64);

            // 프로젝트 실제 경로 기준
            String projectPath = System.getProperty("user.dir");
            String savePath = "C:/shinhan5/work/cardgarden/src/main/webapp/resources/images/custom/customcard";


            File folder = new File(savePath);
            if (!folder.exists()) {
                folder.mkdirs();
            }

            String fileName = loginUserId + "_" + cardName + ".png";
            File outputFile = new File(folder, fileName);

            try (OutputStream os = new FileOutputStream(outputFile)) {
                os.write(imageBytes);
            }

            System.out.println(">> 실제 저장 경로: " + outputFile.getAbsolutePath());

            return "ok";
        } catch (Exception e) {
            e.printStackTrace();
            return "저장 실패";
        }
    }



    @GetMapping("/result")
    public String makeResult(HttpSession session) {
        return "custom/makeResult";
    }


    private boolean checkLogin(HttpSession session) {
        return session.getAttribute("loginUserId") != null;
    }
}
