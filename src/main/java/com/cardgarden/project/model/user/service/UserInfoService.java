package com.cardgarden.project.model.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.user.dao.UserInfoDAO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;

import lombok.extern.java.Log;

@Service // @Component + 서비스 역할
@Log
public class UserInfoService {

    @Autowired
    @Qualifier("userInfoDAO")
    UserInfoDAO userInfoDAO;

    // 전체 조회
    public List<UserInfoDTO> selectAll() {
        List<UserInfoDTO> dtolist = userInfoDAO.selectAll();
        log.info("UserInfoService에서 로그출력:" + dtolist.size() + "건");
        return dtolist;
    }

    // user_id로 단일 조회
    public UserInfoDTO selectById(int user_id) {
        UserInfoDTO dto = userInfoDAO.selectById(user_id);
        log.info("UserInfoService에서 로그출력:" + (dto != null ? dto.toString() : "null"));
        return dto;
    }

    // email로 단일 조회 (아이디/비밀번호 찾기, 로그인 등)
    public UserInfoDTO selectByEmail(String email) {
        UserInfoDTO dto = userInfoDAO.selectByEmail(email);
        log.info("UserInfoService에서 로그출력: selectByEmail -> " + (dto != null ? dto.toString() : "null"));
        return dto;
    }
    
    // 로그인 아이디로 user_id 찾기
    public int getUserIdByLoginId(String user_name) {
    	int user_id = userInfoDAO.getUserIdByLoginId(user_name);
    	log.info("UserInfoService에서 로그출력: getUserIdByLoginId -> user_id = " + user_id);
    	return user_id;
    }
    
    // 로그인 아이디로 비밀번호 조회
    public String getPasswordByLoginId(String user_name) {
    	String user_password = userInfoDAO.getPasswordByLoginId(user_name);
    	log.info("UserInfoService에서 로그출력: getPasswordByLoginId -> user_password = " + user_password);
    	return user_password;
    }

    // 회원 등록
    public int insert(UserInfoDTO dto) {
        int result = userInfoDAO.insert(dto);
        log.info("UserInfoService에서 로그출력:" + result + "건 insert");
        return result;
    }
    
    // 신규 회원 등록
    public int createUser(UserInfoDTO dto) {
    	int result = userInfoDAO.createUser(dto);
    	log.info("UserInfoService에서 로그출력:" + result + "건 insert");
    	return result;
    }

    // 회원 정보 수정
    public int update(UserInfoDTO dto) {
        int result = userInfoDAO.update(dto);
        log.info("UserInfoService에서 로그출력:" + result + "건 update");
        return result;
    }

    // 회원 탈퇴/삭제
    public int delete(int user_id) {
        int result = userInfoDAO.delete(user_id);
        log.info("UserInfoService에서 로그출력:" + result + "건 delete");
        return result;
    }

    // 아이디(로그인ID) 중복 여부
    public boolean existsByLoginId(String login_id) {
        return userInfoDAO.countByLoginId(login_id) > 0;
    }

    // 닉네임 중복 여부
    public boolean existsByNickname(String nickname) {
        return userInfoDAO.countByNickname(nickname) > 0;
    }

    // 이메일 중복 여부
    public boolean existsByEmail(String email) {
        return userInfoDAO.countByEmail(email) > 0;
    }
}
