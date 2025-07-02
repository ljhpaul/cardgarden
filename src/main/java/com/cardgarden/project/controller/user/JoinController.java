package com.cardgarden.project.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.term.dto.TermDTO;
import com.cardgarden.project.model.term.service.TermService;
import com.cardgarden.project.model.user.dto.UserAgreementDTO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import com.cardgarden.project.model.user.service.UserAgreementService;
import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user/join")
public class JoinController {
	
	@Autowired
	TermService termService;
	@Autowired
	UserInfoService userInfoSerivce;
	@Autowired
	UserAgreementService userAgreementService;
	
	//0. 회원가입 방법 선택
	@GetMapping("")
	public String joinMethodView() {
		return "join/joinMethod";
	}
	
	//1-1. 약관 동의
	@GetMapping("/term")
	public String termAgreeView(Model model) {
		List<TermDTO> termList = termService.selectAll();
		model.addAttribute("termList", termList);
		return "join/termAgree";
	}
	
	//1-2. 약관 동의 여부 확인
	@PostMapping("/term")
	public String termAgreeCheck(
			@RequestParam List<Integer> checkedTermList, 
			HttpSession session) {
		
		log.info(checkedTermList.toString());
		
		//사용자가 뒤로가기 등으로 다시 약관 동의를 수정할 경우 덮어쓰기됨
		session.setAttribute("checkedTermList", checkedTermList);
		
		Boolean socialJoin = (Boolean) session.getAttribute("socialJoin");
		
		if(socialJoin == null) {
			return "redirect:/user/join/email";
		} else {
			return "redirect:/user/join/info";
		}
	}
	
	//2-1. 이메일 입력
	@GetMapping("/email")
	public String verifyEmailView(Model model) {
		
		model.addAttribute("isJoin", true);
		model.addAttribute("title", "이메일 인증");
		model.addAttribute("actionLink", "join/email");
		
		return "auth/verifyEmail";
	}
	
	//2-2. 이메일 인증 성공
	@PostMapping("/email")
	public String verifyEmailRequest() {
		return "redirect:/user/join/info";
	}
	
	//3-1. 회원정보 입력
	@GetMapping("/info")
	public String inputInfoView(HttpSession session, Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
			OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
			
			//네이버 확인
			Object responseAttr = oAuth2User.getAttribute("response");
			if (responseAttr instanceof Map) {
				@SuppressWarnings("unchecked")
	            Map<String, Object> responseMap = (Map<String, Object>) responseAttr;
				log.info(responseMap.toString());
				log.info(responseMap.get("id").toString());
				log.info(responseMap.get("name").toString());
	            model.addAttribute("socialId", responseMap.get("id"));
	            model.addAttribute("socialName", responseMap.get("name"));
	            session.setAttribute("emailVerified", true);
	            session.setAttribute("verifiedEmail", responseMap.get("email"));
			} else {
				model.addAttribute("socialId", oAuth2User.getAttribute("sub"));
			    model.addAttribute("socialName", oAuth2User.getAttribute("name"));
				session.setAttribute("emailVerified", oAuth2User.getAttribute("email_verified"));
				session.setAttribute("verifiedEmail", oAuth2User.getAttribute("email"));
			}
		}
	    
		/*
		if(session.getAttribute("verifiedEmail") == null) {
			return "redirect:/wrong";
		}
		*/
		
	    return "join/inputInfo";
	}
	
	//3-2. 회원정보 입력 완료
	@PostMapping("/info")
	public String inputInfoRequest(HttpSession session, UserInfoDTO userInfo, Model model) {
		log.info(userInfo.toString());

		int result = userInfoSerivce.createUser(userInfo);
		int user_id = userInfoSerivce.getUserIdByLoginId(userInfo.getUser_name());
		
		String joinResult = "회원가입 " + ((result>0)?"성공 (아이디: " + user_id + "번)":"실패");
		log.info(joinResult);
		
	    if (result > 0) {
	        Map<String, Object> assetParam = new HashMap<>();
	        assetParam.put("user_id", user_id);
	        assetParam.put("asset_id", 120);
	        userInfoSerivce.insertOwnedAsset(assetParam);}
		
		List<TermDTO> termList = termService.selectAll();
		List<Integer> checkedTermList = (List<Integer>) session.getAttribute("checkedTermList");
		
		for (TermDTO term : termList) {
			int term_id = term.getTerm_id();
			String is_agreed = checkedTermList.contains(term_id) ? "Y" : "N";
			
			UserAgreementDTO userAgreementDTO = new UserAgreementDTO();
			userAgreementDTO.setUser_id(user_id);
			userAgreementDTO.setTerm_id(term_id);
			userAgreementDTO.setIs_agreed(is_agreed);
			
			userAgreementService.insert(userAgreementDTO);
		}
		
		if(result > 0 && checkedTermList != null) {
			//소셜회원가입여부 세션 저장값 초기화
			session.removeAttribute("socialJoin");
			
			//약관동의 세션 저장값 초기화
			session.removeAttribute("checkedTermList");
			
			//이메일 세션 저장값 초기화
			session.removeAttribute("emailCode");
			session.removeAttribute("emailExpire");
			session.removeAttribute("emailToVerify");
			session.removeAttribute("emailVerified");
			session.removeAttribute("verifiedEmail");
			
		    return "redirect:/user/join/complete";
		} else {
			model.addAttribute("msg", "회원가입에 실패했습니다. 다시 시도해 주세요.");
			return "join/info";
		}
	}
	
	//4. 회원가입 완료
	@GetMapping("/complete")
	public String joinComplete() {
	    return "join/joinComplete";
	}
	
}