package com.cardgarden.project.model.user;

import java.util.List;

public interface UserInfoDAOInterface {
	
	public List<UserInfoDTO> selectAll();
	public UserInfoDTO selectById(int id);
	public int insert(UserInfoDTO dto);
	public int update(UserInfoDTO dto);
	public int delete(int id);
	
}