package com.cardgarden.project.controller.custom;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;
import com.cardgarden.project.model.custom.service.CustomAssetService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/custom")
public class CustomAssetController {

    @Autowired
    CustomAssetService service;

    @GetMapping("/main")
    public String customMain(Model model) {
        List<CustomAssetDTO> topStickers = service.getTopAssets("sticker", "like").subList(0, 5);
        List<CustomAssetDTO> topBackgrounds = service.getTopAssets("background", "like").subList(0, 5);

        model.addAttribute("topStickers", topStickers);
        model.addAttribute("topBackgrounds", topBackgrounds);

        return "custom/main"; // /WEB-INF/views/custom/main.jsp
    }


    @GetMapping("/discount")
    public List<CustomAssetDTO> dailyDiscount() {
        return service.getDailyDiscountAssets();
    }

    @GetMapping("/free")
    public List<CustomAssetDTO> dailyFree() {
        return service.getDailyFreeAssets();
    }

    @GetMapping("/detail")
    public CustomAssetDTO detail(@RequestParam int asset_id) {
        return service.getAssetDetail(asset_id);
    }
}
