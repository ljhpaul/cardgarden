package com.cardgarden.project.model.sample;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;

@Service //@Componet + ���� ����
@Log
public class SampleService {
	
	@Autowired	//Ÿ���� ������ Injection, ���� Ÿ���� ���� �� ������ �̸����� Injection
	@Qualifier("sampleDAO")
	SampleDAOInterface sampleDAO;

	public List<SampleDTO> selectAll() {
		List<SampleDTO> dtolist = sampleDAO.selectAll();
		log.info("SampleService���� �α����:" + dtolist.size() + "��");
		return dtolist;
	}

	// 2.Select(Read)..�󼼺���
	public SampleDTO selectById(int id) {
		SampleDTO dto = sampleDAO.selectById(id);
		log.info("SampleService���� �α����:" + dto.toString());
		return dto;
	}

	// 3.Inert
	public int insert(SampleDTO dto) {
		int result = sampleDAO.insert(dto);
		log.info("SampleService���� �α����:" + result + "�� insert");
		return result;
	}

	// 4.Update
	public int update(SampleDTO dto) {
		int result = sampleDAO.update(dto);
		log.info("SampleService���� �α����:" + result + "�� update");
		return result;
	}

	// 5.Delete
	public int delete(int id) {
		int result = sampleDAO.delete(id);
		log.info("SampleService���� �α����:" + result + "�� delete");
		return result;
	}
}






