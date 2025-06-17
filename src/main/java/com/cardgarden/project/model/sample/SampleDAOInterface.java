package com.cardgarden.project.model.sample;

import java.util.List;

public interface SampleDAOInterface {
	
	public List<SampleDTO> selectAll();
	public SampleDTO selectById(int id);
	public int insert(SampleDTO dto);
	public int update(SampleDTO dto);
	public int delete(int id);
	
}