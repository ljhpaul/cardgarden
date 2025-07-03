package com.cardgarden.project.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;
import com.cardgarden.project.model.benefitCategory.benefitCategoryService;
import com.cardgarden.project.model.userConsumptionPattern.UserConsumptionPatternDTO;
import com.cardgarden.project.model.userConsumptionPattern.UserConsumptionPatternService;

@RequestMapping("/ConsumptionPattern")
@Controller
public class UserConsumptionPatternController {
	@Autowired
	benefitCategoryService bcService;
	
	@Autowired
	UserConsumptionPatternService ucpService;

	String namespace = "com.cardgarden.inCon.";

	@GetMapping("/inCon")
	public String insertView(Model model) {

		List<benefitCategoryDTO> benefitCategorylist = bcService.selectAll();

		System.out.println(benefitCategorylist.size());
		model.addAttribute("benefitCategorylist", benefitCategorylist);
		

		return "cardSearchcondition/insertUserConsumptionPattern";

	}

	@PostMapping("/inCon")
	public String insertConsumPattern(@RequestParam("benefitcategory_id") int[] selectedCategories,
			@RequestParam("amount") int[] amount, @RequestParam("pattern_name") String pattern_name,
			RedirectAttributes redirectAttr,HttpServletRequest request) {

		// 요청값 체크
		System.out.println(pattern_name);
		System.out.println(selectedCategories.length);
		System.out.println(Arrays.toString(selectedCategories));
		System.out.println(amount.length);
		
		// 날짜 가공하기
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String nowStr = now.format(formatter);
		
		Timestamp created_at = Timestamp.valueOf(nowStr);
		
		System.out.println(created_at);
		
		//로그인 기능 구현 후 로그인 사용자 객체에서 user_id 가져오는 로직 추가
		//세션에서 사용자 ID 꺼내기
	    HttpSession mySession = request.getSession();
	    int userId = (Integer)mySession.getAttribute("loginUserId");
	    System.out.println("로그인한 사용자 ID: " + userId);
		
		// 요청값 가공
		// UserConsumptionPattern에 먼저 insert
		// pattern_id는 DB에서 자동으로 생성
		UserConsumptionPatternDTO ucp = UserConsumptionPatternDTO.builder()
				.created_at(created_at)
				.pattern_name(pattern_name)
				.user_id(userId).build();
		
		// UserConsumptionPattern 먼저 insert 
		ucpService.insertUserConsumptionPatternWithDetails(ucp,selectedCategories,amount);
		
		redirectAttr.addFlashAttribute("msg", "등록이 완료되었습니다!");
		
		return "redirect:/ConsumptionPattern/inCon";
		
	}
	
	//소비패턴 수정
	// 패턴 아이디, 패턴 제목, 선택된 카테고리, 작성한 금액
	@PostMapping("/updateCon")
	public String updateConsumPattern(@RequestParam("benefitcategory_id") int[] selectedCategories,
			@RequestParam("amount") int[] amount, @RequestParam("pattern_name") String pattern_name,int pattern_id,
			RedirectAttributes redirectAttr,HttpServletRequest request,HttpSession session) {

		// 요청값 체크
		System.out.println(pattern_name);
		System.out.println("패턴 아이디 : " + pattern_id);
		System.out.println(selectedCategories.length);
		System.out.println(Arrays.toString(selectedCategories));
		System.out.println(amount.length);
		
		// 수정하는 날짜 가공하기
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String nowStr = now.format(formatter);
		
		Timestamp created_at = Timestamp.valueOf(nowStr);
		
		System.out.println("수정하는 날짜 : " + created_at);
		
		
		// 요청값 가공
		// UserConsumptionPattern에 먼저 update
		UserConsumptionPatternDTO ucp = UserConsumptionPatternDTO.builder()
				.created_at(created_at)
				.pattern_name(pattern_name)
				.pattern_id(pattern_id).build();
		
		ucpService.updatetUserConsumptionPatternWithDetails(ucp,selectedCategories,amount);
		
		session.setAttribute("msg", "수정이 완료되었습니다!");
		
		return "redirect:/user/consumptionPattern";
		
	}
	
	// 소비패턴 삭제
	@PostMapping("/deleteCon")
	@ResponseBody
	public String deleteConsumPattern(int pattern_id,
			RedirectAttributes redirectAttr,HttpServletRequest request) {

		// 요청값 체크
		System.out.println("패턴 아이디 : " + pattern_id);	

		int result = ucpService.deleteConsumPattern(pattern_id);
	
		
		return (result == 2) ? "ok" : "fail";
		
	}
}
