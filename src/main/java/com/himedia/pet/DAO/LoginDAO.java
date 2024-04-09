package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.LoginDTO;

@Mapper
public interface LoginDAO {
    int log(String email, String password);
    
    int saveKakao(String email, String KakaoId);
    int saveNaver(String email, String naverId);
    int saveGoogle(String email, String googleId);
    
    int updateKakao(String email, String KakaoId,int member_id);
    int updateNaver(String email, String naverId,int member_id);
    int updateGoogle(String email, String googleId,int member_id);

    int savelog(String email, String password);
    
    boolean findEmail(String email);
    boolean nemailExists(String email, String naverId);
    boolean kemailExists(String email, String kakaoId);
    boolean gemailExists(String email, String googleId);
    
    int getuserid(String email);
    int adLogin(String email);
    ArrayList<LoginDTO> updateMyList(int id);
    
    
    int addadvertiser(int id);
    int checkad(String email);
    
    
    
    
}

