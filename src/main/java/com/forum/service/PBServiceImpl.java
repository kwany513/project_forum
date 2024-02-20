package com.forum.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forum.dao.PBDao;
import com.forum.dto.PBCriteria;
import com.forum.dto.PBDto;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service("PBService")
public class PBServiceImpl implements PBService{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<PBDto> picture_list() {
        PBDao dao = sqlSession.getMapper(PBDao.class);
        ArrayList<PBDto> plist = dao.picture_list();

       

        return plist;
    }

    

	@Override
	public void pwrite(HashMap<String, String> param) {
		log.info("@# PBServiceImpl.write() start");
		
		PBDao dao = sqlSession.getMapper(PBDao.class);
		dao.pwrite(param);
		
	}

	@Override
	public PBDto pcontentView(HashMap<String, String> param) {
		PBDao dao = sqlSession.getMapper(PBDao.class);
		PBDto dto = dao.pcontentView(param);
		
		return dto;
	}

	@Override
	public void pmodify(HashMap<String, String> param) {
		PBDao dao = sqlSession.getMapper(PBDao.class);
		dao.pmodify(param);
	}

	@Override
	public void pdelete(HashMap<String, String> param) {
		PBDao dao = sqlSession.getMapper(PBDao.class);
		dao.pdelete(param);
	}

	@Override
	public void pincreaseHit(HashMap<String, String> param) {
		PBDao dao = sqlSession.getMapper(PBDao.class);
		 dao.pincreaseHit(param);
	}

	@Override
	public ArrayList<PBDto> plist(PBCriteria pcri) {
		PBDao dao = sqlSession.getMapper(PBDao.class);
		ArrayList<PBDto> plist = dao.plistWithPaging(pcri);
		 // 각각의 PBDto에 대해 이미지를 바이트 배열로 변환하여 저장
        for (PBDto pdto : plist) {
            String imagePath = pdto.getUploadPath();
            try {
                byte[] imageBytes = readBytesFromFile(imagePath);
                pdto.setImagebyte(imageBytes);
                
              
            } catch (IOException e) {
                e.printStackTrace();
                
            }
        }
		return plist;
	}

	private byte[] readBytesFromFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        return Files.readAllBytes(path);
    }

	
	@Override
	public int getTotalCount(PBCriteria pcri) {
	log.info("@# PBServiceImpl.getTotalCount() start");
	
	PBDao dao = sqlSession.getMapper(PBDao.class);
	
	log.info("@# PBServiceImpl.getTotalCount() end");
	return dao.getTotalCount(pcri);
	}

	@Override
	public void uploadFile(HashMap<String, String> param) {
		log.info("@# PBServiceImpl.uploadFile() start");
		
		PBDao dao = sqlSession.getMapper(PBDao.class);
		dao.uploadFile(param);
		
		log.info("@# PBServiceImpl.uploadFile() end");
	}
}
