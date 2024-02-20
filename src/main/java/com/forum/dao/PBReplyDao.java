package com.forum.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.forum.dto.PBReply2DTO;
import com.forum.dto.PBReplyDTO;

@Mapper
public interface PBReplyDao {
    public ArrayList<PBReplyDTO> prlist(int pid);
    public void prwrite(PBReplyDTO dto);
    public void prmodify(PBReplyDTO dto);
    public void prdelete(PBReplyDTO dto);
    public List<PBReply2DTO> rprlist(Map<String, Object> params);
}