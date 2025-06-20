/*
 * package com.cardgarden.project.controller; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestParam;
 * 
 * @Controller public class CardController {
 * 
 * @GetMapping("/inCon.do") public String insertView(Model model) {
 * 
 * 
 * List<UserConsumptionPatternDTO> benefitCategorylist = ucpService.selectAll();
 * 
 * System.out.println(benefitCategorylist.size());
 * model.addAttribute("benefitCategorylist", benefitCategorylist); // JSP에서 이
 * 이름으로 사용 가능
 * 
 * return "cardgarden/insertUserConsumptionPattern"; // 뷰 이름
 * 
 * }
 * 
 * @GetMapping("/cardAll.do") public String cardall() {
 * 
 * return "cardSelect/cardAll"; }
 * 
 * @PostMapping("/cardAll") public void cardSearch(@RequestParam("category")
 * String[] selectedCategories) { System.out.println(selectedCategories.length);
 * } }
 */