package com.cardgarden.project.model.sample;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;

@Service //@Componet + 서비스 역할
@Log
public class SampleService {
	
	@Autowired	//타입이 같으면 Injection, 같은 타입이 여러 개 있으면 이름으로 Injection
	@Qualifier("sampleDAO")
	SampleDAOInterface sampleDAO;

	public List<SampleDTO> selectAll() {
		List<SampleDTO> dtolist = sampleDAO.selectAll();
		log.info("SampleService에서 로그출력:" + dtolist.size() + "건");
		return dtolist;
	}

	// 2.Select(Read)..상세보기
	public SampleDTO selectById(int id) {
		SampleDTO dto = sampleDAO.selectById(id);
		log.info("SampleService에서 로그출력:" + dto.toString());
		return dto;
	}

	// 3.Inert
	public int insert(SampleDTO dto) {
		int result = sampleDAO.insert(dto);
		log.info("SampleService에서 로그출력:" + result + "건 insert");
		return result;
	}

	// 4.Update
	public int update(SampleDTO dto) {
		int result = sampleDAO.update(dto);
		log.info("SampleService에서 로그출력:" + result + "건 update");
		return result;
	}

	// 5.Delete
	public int delete(int id) {
		int result = sampleDAO.delete(id);
		log.info("SampleService에서 로그출력:" + result + "건 delete");
		return result;
	}
}






