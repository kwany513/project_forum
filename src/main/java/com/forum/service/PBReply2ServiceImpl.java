package com.forum.service;

import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forum.dao.PBReply2Dao;
import com.forum.dto.PBReply2DTO;

@Service
public class PBReply2ServiceImpl implements PBReply2Service{
    @Autowired
    private SqlSession sqlSession;

    @Override
    public ArrayList<PBReply2DTO> rprlist(int pid, int parentPrid) {
        PBReply2Dao dao = sqlSession.getMapper(PBReply2Dao.class);
        ArrayList<PBReply2DTO> rprlist = dao.rprlist(pid, parentPrid);
        return rprlist;
    }

    @Override
    public void rprwrite(PBReply2DTO dto) {
        PBReply2Dao dao = sqlSession.getMapper(PBReply2Dao.class);
        dao.rprwrite(dto);
    }

    @Override
    public void rprmodify(PBReply2DTO dto) {
        PBReply2Dao dao = sqlSession.getMapper(PBReply2Dao.class);
        dao.rprmodify(dto);
    }

    @Override
    public void rprdelete(PBReply2DTO dto) {
        PBReply2Dao dao = sqlSession.getMapper(PBReply2Dao.class);
        dao.rprdelete(dto);
    }
}