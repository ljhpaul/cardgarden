package com.cardgarden.project.model.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cardgarden.project.model.user.dto.UserAgreementDTO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UserAgreementDAO {

    @Autowired
    SqlSession sqlSession;
    
    String namespace = "com.cardgarden.project.mapper.UserAgreementMapper.";
    
    public List<UserAgreementDTO> selectByUserId(int user_id) {
    	List<UserAgreementDTO> dtolist = sqlSession.selectList(namespace + "selectByUserId", user_id);
    	log.info(dtolist.size() + "건 조회됨(lombok_Slf4j)");
    	return dtolist;
    }
    
    public String getAgreedByUserIdAndTermId(UserAgreementDTO dto) {
        String is_agreed = sqlSession.selectOne(namespace + "selectUserAgreement", dto);
        log.info(is_agreed + "건 조회됨(lombok_Slf4j)");
        return is_agreed;
    }
    
    public int insert(UserAgreementDTO dto) {
        int result = sqlSession.insert(namespace + "insert", dto);
        log.info(result + "건 입력됨(lombok_Slf4j)");
        return result;
    }
    
    public int update(UserAgreementDTO dto) {
        int result = sqlSession.update(namespace + "update", dto);
        log.info(result + "건 수정됨(lombok_Slf4j)");
        return result;
    }
    
    public int delete(UserAgreementDTO dto) {
        int result = sqlSession.delete(namespace + "delete", dto);
        log.info(result + "건 삭제됨(lombok_Slf4j)");
        return result;
    }
}
