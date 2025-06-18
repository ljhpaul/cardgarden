package com.cardgarden.project.model.auth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;

@Service //@Componet + ���� ����
@Log
public class UserInfoService {
	
	@Autowired	//Ÿ���� ������ Injection, ���� Ÿ���� ���� �� ������ �̸����� Injection
	@Qualifier("userInfoDAO")
	UserInfoDAOInterface userInfoDAO;

	public List<UserInfoDTO> selectAll() {
		List<UserInfoDTO> dtolist = userInfoDAO.selectAll();
		log.info("SampleService���� �α����:" + dtolist.size() + "��");
		return dtolist;
	}

	// 2.Select(Read)..�󼼺���
	public UserInfoDTO selectById(int id) {
		UserInfoDTO dto = userInfoDAO.selectById(id);
		log.info("SampleService���� �α����:" + dto.toString());
		return dto;
	}

	// 3.Inert
	public int insert(UserInfoDTO dto) {
		int result = userInfoDAO.insert(dto);
		log.info("SampleService���� �α����:" + result + "�� insert");
		return result;
	}

	// 4.Update
	public int update(UserInfoDTO dto) {
		int result = userInfoDAO.update(dto);
		log.info("SampleService���� �α����:" + result + "�� update");
		return result;
	}

	// 5.Delete
	public int delete(int id) {
		int result = userInfoDAO.delete(id);
		log.info("SampleService���� �α����:" + result + "�� delete");
		return result;
	}
}






