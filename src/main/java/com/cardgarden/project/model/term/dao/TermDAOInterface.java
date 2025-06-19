package com.cardgarden.project.model.term.dao;

import java.util.List;

import com.cardgarden.project.model.term.dto.TermDTO;

public interface TermDAOInterface {
	
	public List<TermDTO> selectAll();
	public TermDTO selectById(int id);
	public int insert(TermDTO dto);
	public int update(TermDTO dto);
	public int delete(int id);
	
}