package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.AnswersDTO;
import com.himedia.pet.DTO.QnaDTO;

@Mapper
public interface QnaDAO {
   //Qna 게시판
   int QnaWrite(String title,int id, String content );
   ArrayList<QnaDTO> QnaLoad(int start); 
   int QnaTotal();
   int Qmodify(String title, String content, int id);
   int QDelete(int uniq);
   int comment(int qnaid, int userid, String comment);
   ArrayList<AnswersDTO> QnAanswer();
   int commentModify(int parseInt, String comment);
   int commentDelete(int parseInt);
   int qnacommentdelete(int id);
   //qna 목록 불러오기
    ArrayList<QnaDTO> qnaList(int id);
}