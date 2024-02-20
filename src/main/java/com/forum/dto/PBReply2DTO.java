package com.forum.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PBReply2DTO {
    private int rprid; // 대댓글의 고유 식별자
    private int parentPrid; // 원래 댓글의 prid
    private int pid;
    private String rprwriter;
    private String rprcontent;
    private Timestamp rpregdate;
}
