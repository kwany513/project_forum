package com.forum.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PBReplyDTO {
	private int prid;
	private int pid;
	private String prwriter;
	private String prcontent;
	private Timestamp pregdate;
	private List<PBReply2DTO> rprlist;  // 대댓글 목록 속성
}
