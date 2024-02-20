package com.forum.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.forum.dto.PBCriteria;
import com.forum.dto.PBDto;

@Mapper
public interface PBDao {
	public ArrayList<PBDto> picture_list();
	public void pwrite(HashMap<String, String> param);
	public PBDto pcontentView(HashMap<String, String> param);
	public void pmodify(HashMap<String, String> param);
	public void pdelete(HashMap<String, String> param);
	public void pincreaseHit(HashMap<String, String> param);
	public void uploadFile(HashMap<String, String> param);

	public ArrayList<PBDto> plistWithPaging(PBCriteria pcri);
	public int getTotalCount(PBCriteria pcri);
}
