package com.cardgarden.project.controller.custom;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
    public String showCustomMain(Model model, HttpSession session) {
        
        Integer loginId = (Integer) session.getAttribute("loginUserId");

        Map<String, Object> allParam = new HashMap<>();
        allParam.put("asset_type", "");
        allParam.put("sortBy", "used");
        allParam.put("brand", "");
        List<CustomAssetDTO> topAll = service.getTopAssets(allParam);

        Map<String, Object> stickerParam = new HashMap<>();
        stickerParam.put("asset_type", "sticker");
        stickerParam.put("sortBy", "used");
        stickerParam.put("brand", "");
        List<CustomAssetDTO> topSticker = service.getTopAssets(stickerParam);

        Map<String, Object> bgParam = new HashMap<>();
        bgParam.put("asset_type", "background");
        bgParam.put("sortBy", "used");
        bgParam.put("brand", "");
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
    
    @GetMapping("/detail")
    public String showDetail(
        @RequestParam("asset_id") int assetId,
        HttpSession session,
        Model model
    ) {
        CustomAssetDTO asset = service.getAssetDetail(assetId);

        Integer userId = (Integer) session.getAttribute("loginUserId");
        int liked = -1;
        int owned = -1;
        int userPoint = 0;

        if (userId != null) {
            liked = service.checkLiked(userId, assetId);
            owned = service.checkOwned(userId, assetId);
            userPoint = service.getUserPoint(userId);
        }

        List<CustomAssetDTO> relatedList = service.getSameBrandAssets(asset.getAsset_brand(), asset.getAsset_type());

        model.addAttribute("asset", asset);
        model.addAttribute("liked", liked);
        model.addAttribute("owned", owned);
        model.addAttribute("userPoint", userPoint);
        model.addAttribute("relatedList", relatedList);

        return "custom/detail";
    }

    @GetMapping("/buy")
    public String buyConfirm(@RequestParam("asset_id") int assetId, HttpSession session, Model model) {
        
        Integer userId = (Integer) session.getAttribute("loginUserId");
        
        CustomAssetDTO asset = service.getAssetDetail(assetId);
        int userPoint = service.getUserPoint(userId);

        model.addAttribute("asset", asset);
        model.addAttribute("userPoint", userPoint);

        return "custom/buy";
    }

    @PostMapping("/buy")
    public String buyAsset(@RequestParam("asset_id") int assetId, HttpSession session, Model model) {

        Integer userId = (Integer) session.getAttribute("loginUserId");

        int userPoint = service.getUserPoint(userId);
        CustomAssetDTO asset = service.getAssetDetail(assetId);

        int price = asset.getPoint_needed();
        if (asset.getDiscount() > 0) {
            price = asset.getDiscount();
        }

        if (userPoint < price) {
            model.addAttribute("asset", asset);
            model.addAttribute("userPoint", userPoint);
            model.addAttribute("error", "포인트가 부족합니다.");
            return "custom/buy";
        }

        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userId);
        param.put("point", price);
        service.updateUserPoint(param);

        Map<String, Object> ownParam = new HashMap<>();
        ownParam.put("user_id", userId);
        ownParam.put("asset_id", assetId);
        service.insertOwnedAsset(ownParam);

        int updatedPoint = service.getUserPoint(userId);
        List<CustomAssetDTO> relatedList = service.getSameBrandAssets(asset.getAsset_brand(), asset.getAsset_type());

        model.addAttribute("asset", asset);
        model.addAttribute("userPoint", updatedPoint);
        model.addAttribute("relatedList", relatedList);

        return "custom/result";
    }

    @GetMapping("/discount")
    public String showDiscountPage(Model model) {
        List<CustomAssetDTO> discountList = service.getDailyDiscountAssets();
        model.addAttribute("discountList", discountList);
        return "custom/discount";
    }
    
    @GetMapping("/free")
    public String showDailyFreeDetail(HttpSession session, Model model) {

        Integer userId = (Integer) session.getAttribute("loginUserId");

        List<CustomAssetDTO> freeList = service.getDailyFreeAssets();

        if (freeList.isEmpty()) {
            model.addAttribute("error", "오늘의 무료 스티커가 없습니다.");
            return "custom/main";
        }

        CustomAssetDTO freeAsset = freeList.get(0);
        int liked = -1;
        int owned = -1;
        int userPoint = 0;

        if (userId != null) {
            liked = service.checkLiked(userId, freeAsset.getAsset_id());
            owned = service.checkOwned(userId, freeAsset.getAsset_id());
            userPoint = service.getUserPoint(userId);
        }

        List<CustomAssetDTO> relatedList = service.getSameBrandAssets(freeAsset.getAsset_brand(), freeAsset.getAsset_type());

        model.addAttribute("asset", freeAsset);
        model.addAttribute("liked", liked);
        model.addAttribute("owned", owned);
        model.addAttribute("userPoint", userPoint);
        model.addAttribute("relatedList", relatedList);

        return "custom/free";
    }
    @PostMapping("/getfree")
    public String getFreeAsset(
        @RequestParam("asset_id") int assetId,
        HttpSession session,
        Model model
    ) {
        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        int owned = service.checkOwned(userId, assetId);
        if (owned == 1) {
            return "redirect:/custom/free";
        }

        Map<String, Object> ownParam = new HashMap<>();
        ownParam.put("user_id", userId);
        ownParam.put("asset_id", assetId);
        service.insertOwnedAsset(ownParam);

        CustomAssetDTO asset = service.getAssetDetail(assetId);
        int userPoint = service.getUserPoint(userId);

        model.addAttribute("asset", asset);
        model.addAttribute("userPoint", userPoint);

        return "custom/freeresult";
    }




    @PostMapping("/like")
    @ResponseBody
    public Map<String, Object> likeAsset(@RequestParam int asset_id, HttpSession session) {

        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return Collections.singletonMap("error", "로그인이 필요합니다.");
        }

        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userId);
        param.put("asset_id", asset_id);

        service.likeAsset(param);

        int updatedLikeCount = service.getUserAssetLike(asset_id);

        Map<String, Object> result = new HashMap<>();
        result.put("asset_like", updatedLikeCount);
        result.put("liked", 1);

        return result;
    }

    @PostMapping("/unlike")
    @ResponseBody
    public Map<String, Object> unlikeAsset(@RequestParam int asset_id, HttpSession session) {

        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return Collections.singletonMap("error", "로그인이 필요합니다.");
        }

        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userId);
        param.put("asset_id", asset_id);

        service.unlikeAsset(param);

        int updatedLikeCount = service.getUserAssetLike(asset_id);

        Map<String, Object> result = new HashMap<>();
        result.put("asset_like", updatedLikeCount);
        result.put("liked", 0);

        return result;
    }
}
