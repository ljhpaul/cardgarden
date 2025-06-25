package com.cardgarden.project.controller.user;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;
import com.cardgarden.project.model.benefitCategory.benefitCategoryService;
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
	
    // 세션에서 loginUserId 가져오기
	public static int getLoginUserIdOrThrow(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            throw new IllegalStateException("세션이 존재하지 않습니다. 로그인 필요.");
        }

        Object loginUserIdObj = session.getAttribute("loginUserId");
        if (loginUserIdObj == null) {
            throw new IllegalStateException("로그인된 사용자 정보가 없습니다.");
        }

        return Integer.parseInt(loginUserIdObj.toString());
    }
	
    
	@GetMapping("/mypage")
	public String mypage(HttpServletRequest request,Model model, RedirectAttributes redirectAttr) {
	
		String url;
		
	    HttpSession mySession = request.getSession();
	    Object loginUserIdObj = mySession.getAttribute("loginUserId");
	    // 로그인되지 않았을 경우 처리
	    if (loginUserIdObj == null) {
	    	redirectAttr.addFlashAttribute("msg", "로그인이 필요한 기능입니다");
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
	public String updateUser(UserUpdateInfoDTO userupdateInfo,RedirectAttributes redirectAttr) {
		String msg;
		int result =  userInfoSerivce.update(userupdateInfo);
		
	    if(result > 0) {
	        redirectAttr.addFlashAttribute("msg", "회원정보 수정 성공");
	    } else {
	        redirectAttr.addFlashAttribute("msg", "회원정보 수정 실패");
	    }

		
	    return "redirect:/user/mypage";
	}
	
	@GetMapping("/consumptionPattern")
	public String myconsumptionPattern(HttpServletRequest request,Model model, RedirectAttributes redirectAttr) {
		
		int userId = getLoginUserIdOrThrow(request);
		
		List<UserConsumptionPatternResponseDTO> myConsumptionPatternList  = userInfoSerivce.selectMyonsumptionPattern(userId);
        
		List<benefitCategoryDTO> benefitCategorylist = bcService.selectAll();
		
		model.addAttribute("benefitCategorylist", benefitCategorylist);
        model.addAttribute("myConsumptionPatternList", myConsumptionPatternList);

		
	    return "mypage/myconsumptionPattern";
		
	}

}
