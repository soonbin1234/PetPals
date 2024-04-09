package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.AnswersDTO;
import com.himedia.pet.DTO.QnaDTO;
import com.himedia.pet.DTO.adDTO;
import com.himedia.pet.DTO.boardDTO;
import com.himedia.pet.DTO.dataDTO;

@Mapper
public interface dataDAO {
   ArrayList<dataDTO> searchList(String input,int page);
   int searchTotal(String input);
   
   //a 행거로 카테고리별 목록 뽑아오기
   ArrayList<dataDTO> getHos(String name,int page);      
   ArrayList<dataDTO> citygetHos(String name,int page,String city);
   //문화시설 - 카페,문예회관,음식점 3가지 모아서
   ArrayList<dataDTO> getTotal(String name,String name1,String name2,int page);
   ArrayList<dataDTO> citygetTotal(String str,int page,String city);
   String hospital(String name);
   
   //카테고리별 페이징만들기 총갯수구하기
   int getHos_cnt(String name);
   int citygetHos_cnt(String name,String city);
   int getTotal_cnt(String name,String name1,String name2);
   int citygetTotal_cnt(String str,String city);
   //상세페이지 찾아오기
   ArrayList<dataDTO> getInf(int id);
   //찜하기
   int jjim(int uid,int pid);
   int chekJjim(int uid,int pid);
   int getJjimid(int uid,int pid);
   void delJjim(int jjim_id);
   
   //찜목록 불러오기
   String getjjim_id(String title);
   ArrayList<dataDTO> jjimList(int id);
   
   //리뷰목록 불러오기
   ArrayList<boardDTO> reviewList(int id);
   
   
//상세페이지+리뷰페이징
   dataDTO view(int id);
   int write(int pName,int userId, String content, String rating);
   ArrayList<boardDTO> reviewLoad(int pName,int start);
   int rDelete(int id);
   int rUpdate(String content,String rating,int id);
   boardDTO reLoad(int idDisplay);
   int reviewTotal(int id);
   

   
   //Qna 게시판
   int QnaWrite(String title,String writer, String content);
   ArrayList<QnaDTO> QnaLoad(int start); 
   int QnaTotal();
   int Qmodify(String title, String content, int id);
   int QDelete(int uniq);
   int comment(int qnaid, String awriter, String comment);
   ArrayList<AnswersDTO> QnAanswer();
   int commentModify(int parseInt, String comment);
   int commentDelete(int parseInt);
   
 //광고
   int adsave(int id,String months,int amount,String method);
   int adregistration(String url,String file,int id);
   ArrayList<adDTO> adList();
   ArrayList<adDTO> urlList(String img);
}