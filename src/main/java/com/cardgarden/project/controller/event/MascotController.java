package com.cardgarden.project.controller.event;

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
@RequestMapping("/event")
public class MascotController {

    @Autowired
    private CustomAssetService service;


    @GetMapping("/mascot")
    public String mascotShop(Model model, HttpSession session) {

        Map<String, Object> param = new HashMap<>();
        param.put("asset_type", "mascot");
        param.put("sortBy", "all");

        List<CustomAssetDTO> mascotList = service.getTopAssets(param);
        model.addAttribute("mascotList", mascotList);

        Integer userId = (Integer) session.getAttribute("loginUserId");

        Map<Integer, Integer> ownedMap = new HashMap<>();
        if (userId != null) {
            for (CustomAssetDTO mascot : mascotList) {
                int owned = service.checkOwned(userId, mascot.getAsset_id());
                ownedMap.put(mascot.getAsset_id(), owned);
            }
        }

        model.addAttribute("ownedMap", ownedMap);

        return "event/mascot";
    }

    @PostMapping("/buy")
    @ResponseBody
    public String buyMascot(@RequestParam("asset_id") int assetId, HttpSession session) {

        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return "notlogin";
        }

        int userPoint = service.getUserPoint(userId);
        CustomAssetDTO asset = service.getAssetDetail(assetId);
        int price = asset.getFinal_price();

        if (userPoint < price) {
            return "nopoint";
        }

        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userId);
        param.put("point", price);
        service.updateUserPoint(param);

        Map<String, Object> ownParam = new HashMap<>();
        ownParam.put("user_id", userId);
        ownParam.put("asset_id", assetId);
        service.insertOwnedAsset(ownParam);

        return "success";
    }
    @GetMapping("/result")
    public String showResultPage() {
        return "event/result";
    }
    @GetMapping("/mascot/my")
    public String myMascotPage(HttpSession session, Model model) {

        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        List<CustomAssetDTO> ownedList = service.getOwnedMascots(userId);
        Integer mascotId = (Integer) session.getAttribute("mascotId");

        CustomAssetDTO selectedMascot = null;
        if (mascotId != null) {
            selectedMascot = service.getAssetDetail(mascotId);
        }

        model.addAttribute("ownedList", ownedList);
        model.addAttribute("selectedMascot", selectedMascot);

        return "event/myMascot";
    }
    @PostMapping("/mascot/select")
    @ResponseBody
    public String selectMascot(@RequestParam("asset_id") int assetId, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return "notlogin";
        }

        int owned = service.checkOwned(userId, assetId);
        if (owned == 0) {
            return "notowned";
        }

        session.setAttribute("mascotId", assetId);
        return "success";
    }



}
