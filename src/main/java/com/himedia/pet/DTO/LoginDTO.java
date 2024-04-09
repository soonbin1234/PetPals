package com.himedia.pet.DTO;
import lombok.Data;

@Data
public class LoginDTO {
	int id;
	String email;
	String password;
	String kakaoId;
	String naverId;
	String googleId;
	String admin;
	
	int advertiser;
}

