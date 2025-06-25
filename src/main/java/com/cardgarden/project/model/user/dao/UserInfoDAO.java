package com.cardgarden.project.model.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.CardSearchCondition.CardDTO;
import com.cardgarden.project.model.user.dto.UserConsumptionPatternResponseDTO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import com.cardgarden.project.model.user.dto.UserUpdateInfoDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UserInfoDAO {

    @Autowired
    SqlSession sqlSession;
    
    String namespace = "com.cardgarden.project.mapper.UserInfoMapper.";
    
    
    public List<UserInfoDTO> selectAll() {
        List<UserInfoDTO> dtolist = sqlSession.selectList(namespace + "selectAll");
        log.info(dtolist.size() + "건 조회됨(lombok_Slf4j)");
        return dtolist;
    }
    
    public UserInfoDTO selectById(int user_id) {
        UserInfoDTO user = sqlSession.selectOne(namespace + "selectById", user_id);
        log.info(user != null ? user.toString() : "No user found");
        return user;
    }
    
    public UserInfoDTO selectByEmail(String email) {
        return sqlSession.selectOne(namespace + "selectByEmail", email);
    }
    
    
    public int getUserIdByLoginId(String user_name) {
    	return sqlSession.selectOne(namespace + "getUserIdByLoginId", user_name);
    }
    
	public String getLoginIdByNameAndEmail(Map<String, Object> paramMap) {
		return sqlSession.selectOne(namespace + "getLoginIdByNameAndEmail", paramMap);
	}
	
    public String getPasswordByLoginId(String user_name) {
    	return sqlSession.selectOne(namespace + "getPasswordByLoginId", user_name);
    }
	
	public String getPasswordByLoginIdAndEmail(Map<String, Object> paramMap) {
		return sqlSession.selectOne(namespace + "getPasswordByLoginIdAndEmail", paramMap);
	}
	
    public int countByLoginId(String user_name) {
        return sqlSession.selectOne(namespace + "countByLoginId", user_name);
    }
    
    public int countByName(String name) {
        return sqlSession.selectOne(namespace + "countByName", name);
    }
    
    public int countByNickname(String nickname) {
        return sqlSession.selectOne(namespace + "countByNickname", nickname);
    }

    public int countByEmail(String email) {
        return sqlSession.selectOne(namespace + "countByEmail", email);
    }

    public int insert(UserInfoDTO dto) {
        int result = sqlSession.insert(namespace + "insert", dto);
        log.info(result + "건 입력됨(lombok_Slf4j)");
        return result;
    }
    
	public int createUser(UserInfoDTO dto) {
        int result = sqlSession.insert(namespace + "createUser", dto);
        log.info(result + "건 입력됨(lombok_Slf4j)");
		return result;
	}


    public int update(UserUpdateInfoDTO dto) {
        int result = sqlSession.update(namespace + "update", dto);
        log.info(result + "건 수정됨(lombok_Slf4j)");
        return result;
    }

    public int delete(int user_id) {
        int result = sqlSession.delete(namespace + "delete", user_id);
        log.info(result + "건 삭제됨(lombok_Slf4j)");
        return result;
    }

    public List<UserConsumptionPatternResponseDTO> selectMyConsumptionPattern(int userId) {
        return sqlSession.selectList(namespace + "selectMyConsumptionPattern", userId);
    }


	public List<CardDTO> myLikeCardList(int userId) {
		return sqlSession.selectList(namespace + "userLikeCard", userId);
	}
}
