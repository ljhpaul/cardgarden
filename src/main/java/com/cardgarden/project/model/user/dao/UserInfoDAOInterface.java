package com.cardgarden.project.model.user.dao;

import java.util.List;
import com.cardgarden.project.model.user.dto.UserInfoDTO;

public interface UserInfoDAOInterface {
    List<UserInfoDTO> selectAll();
    UserInfoDTO selectById(int user_id);
    UserInfoDTO selectByEmail(String email);
    int countByLoginId(String login_id);
    int countByNickname(String nickname);
    int countByEmail(String email);
    int insert(UserInfoDTO dto);
    int update(UserInfoDTO dto);
    int delete(int user_id);
}
