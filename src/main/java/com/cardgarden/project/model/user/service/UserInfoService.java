package com.cardgarden.project.model.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.user.dao.UserInfoDAOInterface;
import com.cardgarden.project.model.user.dto.UserInfoDTO;

import lombok.extern.java.Log;

@Service // @Component + 서비스 역할
@Log
public class UserInfoService {

    @Autowired
    @Qualifier("userInfoDAO")
    UserInfoDAOInterface userInfoDAO;

    // 1. 전체 조회
    public List<UserInfoDTO> selectAll() {
        List<UserInfoDTO> dtolist = userInfoDAO.selectAll();
        log.info("UserInfoService에서 로그출력:" + dtolist.size() + "건");
        return dtolist;
    }

    // 2. user_id로 단일 조회
    public UserInfoDTO selectById(int user_id) {
        UserInfoDTO dto = userInfoDAO.selectById(user_id);
        log.info("UserInfoService에서 로그출력:" + (dto != null ? dto.toString() : "null"));
        return dto;
    }

    // 3. email로 단일 조회 (아이디/비밀번호 찾기, 로그인 등)
    public UserInfoDTO selectByEmail(String email) {
        UserInfoDTO dto = userInfoDAO.selectByEmail(email);
        log.info("UserInfoService에서 로그출력: selectByEmail -> " + (dto != null ? dto.toString() : "null"));
        return dto;
    }

    // 4. 회원 등록
    public int insert(UserInfoDTO dto) {
        int result = userInfoDAO.insert(dto);
        log.info("UserInfoService에서 로그출력:" + result + "건 insert");
        return result;
    }

    // 5. 회원 정보 수정
    public int update(UserInfoDTO dto) {
        int result = userInfoDAO.update(dto);
        log.info("UserInfoService에서 로그출력:" + result + "건 update");
        return result;
    }

    // 6. 회원 탈퇴/삭제
    public int delete(int user_id) {
        int result = userInfoDAO.delete(user_id);
        log.info("UserInfoService에서 로그출력:" + result + "건 delete");
        return result;
    }

    // 7. 아이디(로그인ID) 중복 여부
    public boolean existsByLoginId(String login_id) {
        return userInfoDAO.countByLoginId(login_id) > 0;
    }

    // 8. 닉네임 중복 여부
    public boolean existsByNickname(String nickname) {
        return userInfoDAO.countByNickname(nickname) > 0;
    }

    // 9. 이메일 중복 여부
    public boolean existsByEmail(String email) {
        return userInfoDAO.countByEmail(email) > 0;
    }
}
