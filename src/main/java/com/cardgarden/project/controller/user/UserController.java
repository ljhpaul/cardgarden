package com.cardgarden.project.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cardgarden.project.model.CardSearchCondition.CardDTO;
import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;
import com.cardgarden.project.model.benefitCategory.benefitCategoryService;
import com.cardgarden.project.model.custom.dto.CustomCardDTO;
import com.cardgarden.project.model.user.dto.UserConsumptionPatternResponseDTO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import com.cardgarden.project.model.user.dto.UserUpdateInfoDTO;
import com.cardgarden.project.model.user.service.UserInfoService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	benefitCategoryService bcService;
	
	@Autowired
	UserInfoService userInfoSerivce;

	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpServletRequest request, Model model, RedirectAttributes redirectAttr,HttpSession session) {
	
		String url;
		
	    HttpSession mySession = request.getSession();
	    Object loginUserIdObj = mySession.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	session.setAttribute("msg", "로그인이 필요한 기능입니다");
	    	session.setAttribute("redirectAfterLogin", "/user/mypage");
	        return "redirect:/user/login";
	    }
	    
	    int userId = (Integer) loginUserIdObj; // null 아님이 확실할 때만 형변환
	    System.out.println("로그인한 사용자 ID: " + userId);
	    
	    UserInfoDTO user = (UserInfoDTO)userInfoSerivce.selectById(userId);
	 
	    model.addAttribute("user",user);

	    
	    url = "mypage/mypage";
	    
		return url;
		
	}
	
	@PostMapping("/mypage")
	public String updateUser(UserUpdateInfoDTO userupdateInfo, RedirectAttributes redirectAttr) {
		String msg;
		int result =  userInfoSerivce.update(userupdateInfo);
		
	    if(result > 0) {
	        redirectAttr.addFlashAttribute("msg", "회원정보 수정 성공");
	    } else {
	        redirectAttr.addFlashAttribute("msg", "회원정보 수정 실패");
	    }

		
	    return "redirect:/user/mypage";
	}
	
	// 회원 탈퇴
	@PostMapping("/leave")
	@ResponseBody
	public boolean deleteUser(HttpSession session) {
		
		Integer loginUserId = (Integer) session.getAttribute("loginUserId");
		if(loginUserId == null) {
			return false;
		}
		
		boolean deleteSuccess = userInfoSerivce.delete(loginUserId) > 0;
		if(deleteSuccess) {
			session.invalidate();
		}
		
		return deleteSuccess;
	}
	
	// 소비패턴보기
	@GetMapping("/consumptionPattern")
	public String myconsumptionPattern(HttpServletRequest request, Model model, HttpSession session ) {
		
	    HttpSession mySession = request.getSession();
	    Object loginUserIdObj = mySession.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	session.setAttribute("msg", "로그인이 필요한 기능입니다");
	    	session.setAttribute("redirectAfterLogin", "/user/myconsumptionPattern");
	        return "redirect:/user/login";
	    }
	    
	    int userId = (Integer) loginUserIdObj;

		List<UserConsumptionPatternResponseDTO> myConsumptionPatternList  = userInfoSerivce.selectMyonsumptionPattern(userId);
        
		List<benefitCategoryDTO> benefitCategorylist = bcService.selectAll();
		
		model.addAttribute("benefitCategorylist", benefitCategorylist);
        model.addAttribute("myConsumptionPatternList", myConsumptionPatternList);

		
	    return "mypage/myconsumptionPattern";
		
	}
	
	//포인트관리
	@GetMapping("/point")
	public String myPoint(HttpServletRequest request,HttpSession session, Model model){
		
	    Integer loginUserId = (Integer) session.getAttribute("loginUserId");
	    
	    HttpSession mySession = request.getSession();
	    Object loginUserIdObj = mySession.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	session.setAttribute("msg", "로그인이 필요한 기능입니다");
	    	session.setAttribute("redirectAfterLogin", "/user/myPoint");
	        return "redirect:/user/login";
	    }
		
		int loginUserPoint = userInfoSerivce.getPointById(loginUserId);
		
		model.addAttribute("loginUserPoint", loginUserPoint);
		
		return "mypage/myPoint";
	}
	
	//내가 좋아요한 카드
	@GetMapping("/card")
	public String mmyLikeCardList(HttpServletRequest request,HttpSession session,Model model, RedirectAttributes redirectAttr){
		
	    HttpSession mySession = request.getSession();
	    Object loginUserIdObj = mySession.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	session.setAttribute("msg", "로그인이 필요한 기능입니다");
	    	session.setAttribute("redirectAfterLogin", "/user/mycard");
	        return "redirect:/user/login";
	    }
	    
	    int userId = (Integer) loginUserIdObj; // null 아님이 확실할 때만 형변환
		
		List<CardDTO> myLikeCardList = userInfoSerivce.myLikeCardList(userId);
		
		System.out.println("내가 좋아요한 카드 잘 가져오나..?" + myLikeCardList.size());
		
		model.addAttribute("myLikeCardList", myLikeCardList);
		
		 return "mypage/mycard";
	}
	// 내 커스텀 카드 보기
	@GetMapping("/customcard")
	public String myCustomCardList(HttpServletRequest request,HttpSession session, Model model, RedirectAttributes redirectAttr) {

	    HttpSession mysession = request.getSession();
	    Object loginUserIdObj = mysession.getAttribute("loginUserId");
	    Integer loginUserId = (Integer) session.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	session.setAttribute("msg", "로그인이 필요한 기능입니다");
	    	session.setAttribute("redirectAfterLogin", "/user/mycustomcard");
	        return "redirect:/user/login";
	    }

	    List<CustomCardDTO> myCustomCardList = userInfoSerivce.myCustomCardList(loginUserId);

	    model.addAttribute("myCustomCardList", myCustomCardList);
	    return "mypage/mycustomcard";
	}
	
	
	@PostMapping("/customcard/delete")
	@ResponseBody
	public boolean deleteCustomCard(int customcard_id, HttpSession session) {
	    
	    Integer loginUserId = (Integer) session.getAttribute("loginUserId");

	    if (loginUserId == null) {
	        return false;
	    }
	    int result = userInfoSerivce.deleteCustomCard(customcard_id);

	    return result > 0;
	}



}
