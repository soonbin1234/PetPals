package com.himedia.pet.DTO;

import lombok.Data;

@Data
public class QnaDTO {
	int id;
	String title;
	String content;
	String writer;
	String created_at;
	String view;
	String email;
}
