package com.forum.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PBDto {
	private int pid;
	private String pname;
	private String ptitle;
	private String pcontent;
	private Timestamp pdate;
	private int phit;
	private int pempno;
	private String filename;
	private String uploadPath;
	private byte[] imagebyte;
}
