package com.forum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.forum.dto.PBReply2DTO;
@Mapper
public interface PBReply2Dao {
    public ArrayList<PBReply2DTO> rprlist(int pid, int parentPrid);
    public void rprwrite(PBReply2DTO dto);
    public void rprmodify(PBReply2DTO dto);
    public void rprdelete(PBReply2DTO dto);
}