package com.cardgarden.project.controller.custom;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;
import com.cardgarden.project.model.custom.service.CustomAssetService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/custom")
public class CustomAssetController {

    @Autowired
    CustomAssetService service;

    @GetMapping("/main")
    public String showCustomMain(Model model) {
        Map<String, Object> allParam = new HashMap<>();
        allParam.put("asset_type", "");
        allParam.put("sortBy", "used");
        allParam.put("brand","");
        List<CustomAssetDTO> topAll = service.getTopAssets(allParam);

        Map<String, Object> stickerParam = new HashMap<>();
        stickerParam.put("asset_type", "sticker");
        stickerParam.put("sortBy", "used");
        stickerParam.put("brand","");
        List<CustomAssetDTO> topSticker = service.getTopAssets(stickerParam);

        Map<String, Object> bgParam = new HashMap<>();
        bgParam.put("asset_type", "background");
        bgParam.put("sortBy", "used");
        stickerParam.put("brand","");
        List<CustomAssetDTO> topBackground = service.getTopAssets(bgParam);

        List<CustomAssetDTO> discountList = service.getDailyDiscountAssets();
        List<CustomAssetDTO> freeList = service.getDailyFreeAssets();

        model.addAttribute("topAllList", topAll.subList(0, Math.min(5, topAll.size())));      
        model.addAttribute("topStickerList", topSticker.subList(0, Math.min(5, topSticker.size())));   
        model.addAttribute("topBgList", topBackground.subList(0, Math.min(5, topBackground.size())));   
        model.addAttribute("discountList", discountList);
        model.addAttribute("freeList", freeList);

        return "custom/main";
    }



    @GetMapping("/top")
    public String showTopPage(
        @RequestParam("type") String type,
        @RequestParam(value = "sortBy", defaultValue = "used") String sortBy,
        @RequestParam(value = "brand", defaultValue = "") String brand,
        Model model
    ) {
        Map<String, Object> param = new HashMap<>();
        param.put("asset_type", type);
        param.put("sortBy", sortBy);
        param.put("brand", brand);

        List<CustomAssetDTO> topAssets = service.getTopAssets(param);

        List<CustomAssetDTO> top5List = topAssets.subList(0, Math.min(5, topAssets.size()));
        List<CustomAssetDTO> rankedList = topAssets.size() > 5
            ? topAssets.subList(5, Math.min(100, topAssets.size()))
            : Collections.emptyList();

        model.addAttribute("top5List", top5List);
        model.addAttribute("rankedList", rankedList);
        model.addAttribute("type", type);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("brand", brand);

        return "custom/top";
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
