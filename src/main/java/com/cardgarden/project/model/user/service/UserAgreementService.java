package com.cardgarden.project.model.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.user.dao.UserAgreementDAO;
import com.cardgarden.project.model.user.dto.UserAgreementDTO;

import lombok.extern.java.Log;

@Service // @Component + 서비스 역할
@Log
public class UserAgreementService {

    @Autowired
    @Qualifier("userAgreementDAO")
    UserAgreementDAO userAgreementDAO;

    // user_id로 특정 회원의 약관 동의 내역 조회
    public List<UserAgreementDTO> selectByUserId(int user_id) {
    	List<UserAgreementDTO> dtolist = userAgreementDAO.selectByUserId(user_id);
        log.info("UserAgreementService에서 로그출력:" + dtolist.toString());
        return dtolist;
    }

    // 단일 약관 항목에 대한 동의 여부 확인
    public boolean getAgreedByUserIdAndTermId(int user_id, int term_id) {
    	UserAgreementDTO dto = new UserAgreementDTO();
    	dto.setUser_id(user_id);
    	dto.setTerm_id(term_id);
        String is_agreed = userAgreementDAO.getAgreedByUserIdAndTermId(dto);
        log.info("UserAgreementService에서 로그출력: " + user_id + "번 회원의 " + term_id + "번째 약관의 동의 내역 -> " + is_agreed);
        
        if(is_agreed.equals("Y")) return true;
        else return false;
    }

    // 약관 동의 여부 등록
    public int insert(UserAgreementDTO dto) {
        int result = userAgreementDAO.insert(dto);
        log.info("UserAgreementService에서 로그출력:" + result + "건 insert");
        return result;
    }

    // 약관 동의 여부 수정
    public int update(UserAgreementDTO dto) {
        int result = userAgreementDAO.update(dto);
        log.info("UserAgreementService에서 로그출력:" + result + "건 update");
        return result;
    }

    // 약관 동의 여부 삭제
    public int delete(int user_id, int term_id) {
    	UserAgreementDTO dto = new UserAgreementDTO();
    	dto.setUser_id(user_id);
    	dto.setTerm_id(term_id);
        int result = userAgreementDAO.delete(dto);
        log.info("UserAgreementService에서 로그출력:" + result + "건 delete");
        return result;
    }
}
