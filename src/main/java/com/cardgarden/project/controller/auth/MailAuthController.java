package com.cardgarden.project.controller.auth;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender; // Spring Mail 쓴다면
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.SimpleMailMessage;    // (생략 가능)
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/auth/email")
public class MailAuthController {

    @Autowired
    UserInfoService userInfoService;
    
    @Autowired(required = false)
    private JavaMailSender mailSender;
    
    
    /** 1. 이메일 중복 체크 */
	@PostMapping("/check")
	@ResponseBody
	public Map<String, Object> checkEmail(@RequestParam String email) {
	    boolean exists = userInfoService.existsByEmail(email);
	    Map<String, Object> map = new HashMap<>();
	    map.put("duplicate", exists);
	    log.info(email + " : " + map.toString());
	    return map;
	}

    /** 2. 인증코드 발송 요청 */
	/* @PostMapping("/send") */
    public Map<String, Object> sendMailWithCodeFirstVersion(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 인증코드 생성
        String code = String.format("%06d", new Random().nextInt(1000000));
        long expire = System.currentTimeMillis() + 3 * 60 * 1000; // 3분

        // 세션에 저장
        session.setAttribute("emailCode", code);
        session.setAttribute("emailExpire", expire);
        session.setAttribute("emailToVerify", email);

        // 실제 메일 발송 (이메일 발송 설정 필요)
        try {
            if (mailSender != null) {
                SimpleMailMessage message = new SimpleMailMessage();
                message.setTo(email);
                message.setSubject("[카드가든] 이메일 인증번호 안내");
                message.setText("인증번호: " + code + "\n3분 이내 입력해 주세요.");
                mailSender.send(message);
                log.info("[MAIL] 인증코드 발송: " + email + ", code=" + code);
            } else {
                log.warn("[MAIL] mailSender 미설정. 콘솔 출력: code=" + code);
            }
            result.put("success", true);
        } catch (Exception e) {
            log.error("[MAIL] 이메일 발송 실패", e);
            result.put("success", false);
            result.put("error", "메일 발송 실패");
        }
        return result;
    }
    
    /** 2. 인증코드 발송 요청 */
    @PostMapping("/send")
    public Map<String, Object> sendMailWithCode(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        String code = String.format("%06d", new Random().nextInt(1000000));
        long expire = System.currentTimeMillis() + 3 * 60 * 1000;
        session.setAttribute("emailCode", code);
        session.setAttribute("emailExpire", expire);
        session.setAttribute("emailToVerify", email);

        try {
            if (mailSender != null) {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");

                helper.setTo(email);
                helper.setSubject("[카드가든] 이메일 인증번호 안내");

                // Java 코드 예시 (MailAuthController 내부)
                String html =
                    "<div style=\"font-family:'NanumSquareRound','Apple SD Gothic Neo',sans-serif;background:#f9faf9;padding:32px 0;width:100%;\">"
                  + "<div style=\"max-width:420px;margin:0 auto;background:#fff;border-radius:20px;box-shadow:0 2px 16px rgba(100,130,120,0.08);padding:40px 32px;\">"
                  + "  <div style=\"text-align:center;\">"
                  + "    <h1 style=\"color:#8FB098;font-size:2.1rem;margin-top:0;margin-bottom:22px;\">카드가든 회원가입</h1>"
                  + "    <h2 style=\"color:#646F58;font-size:1.5rem;margin:0 0 30px 0;\">이메일 인증번호 안내</h2>"
                  + "    <p style=\"font-size:16px;color:#222;margin:0 0 30px 0;\">"
                  + "      카드가든 회원가입을 위해<br><b style=\"color:#8FB098;\">이메일 인증</b>이 필요합니다.<br>"
                  + "      아래 인증번호 6자리를<br>회원가입 화면에 입력해 주세요."
                  + "    </p>"
                  + "    <div style=\"margin:32px 0 18px 0;\">"
                  + "      <span style=\"display:inline-block;padding:16px 38px;font-size:2.2rem;letter-spacing:12px;background:#8FB098;color:#fff;font-weight:700;border-radius:10px;box-shadow:0 2px 12px rgba(100,130,120,0.1);\">" + code + "</span>"
                  + "    </div>"
                  + "    <div style=\"color:#E44E37;font-size:15px;margin-bottom:18px;\">※ 인증번호는 3분간만 유효합니다.</div>"
                  + "    <hr style=\"margin:30px 0;border:0;border-top:1px solid #DFEED8;\"/>"
                  + "    <div style=\"color:#888;font-size:13px;line-height:1.8;\">"
                  + "      본 메일은 카드가든 회원가입 요청에 따라 자동 발송되었습니다.<br>"
                  + "      만약 본인이 직접 요청하지 않았다면 이 메일을 무시해 주세요."
                  + "    </div>"
                  + "    <div style=\"color:#bbb;font-size:12px;margin-top:22px;\">&copy; 카드가든 team</div>"
                  + "  </div>"
                  + "</div>"
                  + "</div>";


                helper.setText(html, true); // 두 번째 인자 true가 HTML 적용

                mailSender.send(message);
                log.info("[MAIL] HTML 인증코드 발송: " + email + ", code=" + code);
            } else {
                log.warn("[MAIL] mailSender 미설정. 콘솔 출력: code=" + code);
            }
            result.put("success", true);
        } catch (Exception e) {
            log.error("[MAIL] 이메일 발송 실패", e);
            result.put("success", false);
            result.put("error", "메일 발송 실패");
        }
        return result;
    }

    /** 3. 인증코드 검증 */
    @PostMapping("/verify")
    public Map<String, Object> verifyCode(@RequestParam String code, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        String savedCode = (String) session.getAttribute("emailCode");
        Long expire = (Long) session.getAttribute("emailExpire");
        String savedEmail = (String) session.getAttribute("emailToVerify");

        boolean valid = false;
        if (savedCode != null && expire != null) {
            long now = System.currentTimeMillis();
            if (savedCode.equals(code) && now <= expire) {
                valid = true;
                session.setAttribute("emailVerified", true);
                session.setAttribute("verifiedEmail", savedEmail);
            }
        }
        result.put("valid", valid);
        return result;
    }
}
