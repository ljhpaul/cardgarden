package com.cardgarden.project.model.user.dao;

import java.util.List;

import com.cardgarden.project.model.user.dto.UserInfoDTO;

public interface UserInfoDAOInterface {
	
	public List<UserInfoDTO> selectAll();
	public UserInfoDTO selectById(int id);
	public int insert(UserInfoDTO dto);
	public int update(UserInfoDTO dto);
	public int delete(int id);
	
}