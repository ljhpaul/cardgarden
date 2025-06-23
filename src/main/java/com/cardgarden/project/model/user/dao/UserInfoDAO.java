package com.cardgarden.project.model.user.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UserInfoDAO implements UserInfoDAOInterface {

    @Autowired
    SqlSession sqlSession;
    
    String namespace = "com.cardgarden.project.mapper.UserInfoMapper.";

    @Override
    public List<UserInfoDTO> selectAll() {
        List<UserInfoDTO> dtolist = sqlSession.selectList(namespace + "selectAll");
        log.info(dtolist.size() + "건 조회됨(lombok_Slf4j)");
        return dtolist;
    }

    @Override
    public UserInfoDTO selectById(int user_id) {
        UserInfoDTO user = sqlSession.selectOne(namespace + "selectById", user_id);
        log.info(user != null ? user.toString() : "No user found");
        return user;
    }

    @Override
    public UserInfoDTO selectByEmail(String email) {
        return sqlSession.selectOne(namespace + "selectByEmail", email);
    }
    
    @Override
    public int getUserIdByLoginId(String user_name) {
    	return sqlSession.selectOne(namespace + "getUserIdByLoginId", user_name);
    }

    @Override
    public int countByLoginId(String user_name) {
        return sqlSession.selectOne(namespace + "countByLoginId", user_name);
    }

    @Override
    public int countByNickname(String nickname) {
        return sqlSession.selectOne(namespace + "countByNickname", nickname);
    }

    @Override
    public int countByEmail(String email) {
        return sqlSession.selectOne(namespace + "countByEmail", email);
    }

    @Override
    public int insert(UserInfoDTO dto) {
        int result = sqlSession.insert(namespace + "insert", dto);
        log.info(result + "건 입력됨(lombok_Slf4j)");
        return result;
    }

	@Override
	public int createUser(UserInfoDTO dto) {
        int result = sqlSession.insert(namespace + "createUser", dto);
        log.info(result + "건 입력됨(lombok_Slf4j)");
		return result;
	}

    @Override
    public int update(UserInfoDTO dto) {
        int result = sqlSession.update(namespace + "update", dto);
        log.info(result + "건 수정됨(lombok_Slf4j)");
        return result;
    }

    @Override
    public int delete(int user_id) {
        int result = sqlSession.delete(namespace + "delete", user_id);
        log.info(result + "건 삭제됨(lombok_Slf4j)");
        return result;
    }
}
