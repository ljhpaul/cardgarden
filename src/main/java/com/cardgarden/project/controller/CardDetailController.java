package com.cardgarden.project.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.cardDetail.CardDetailDTO;
import com.cardgarden.project.model.cardDetail.CardService;

@Controller
@RequestMapping("/card")
public class CardDetailController {

    @Autowired
    private CardService cardService;

    @GetMapping("/carddetail")
    public String cardDetail(@RequestParam("cardid") int cardid, Model model) {
        model.addAttribute("cardList", cardService.selectById(cardid));

        List<CardDetailDTO> detailList = cardService.selectDetailByID(cardid);
        Map<String, List<CardDetailDTO>> mapData = new LinkedHashMap<>();

        for (CardDetailDTO dto : detailList) {
            String groupKey = dto.getBenefitdetail_name();
            mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        //System.out.println(mapData);
        model.addAttribute("cardDetail", mapData);
        return "card/cardDetail";
    }
}
