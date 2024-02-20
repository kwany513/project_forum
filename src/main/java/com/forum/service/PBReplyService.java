package com.forum.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.forum.dto.PBReply2DTO;
import com.forum.dto.PBReplyDTO;

public interface PBReplyService {
    public ArrayList<PBReplyDTO> prlist(int pid);
    public void prwrite(PBReplyDTO dto);
    public void prmodify(PBReplyDTO dto);
    public void prdelete(PBReplyDTO dto);
    public List<PBReply2DTO> rprlist(Map<String, Object> params);
}
