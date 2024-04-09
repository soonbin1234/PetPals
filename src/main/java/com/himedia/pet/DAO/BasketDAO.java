package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.BasketDTO;


@Mapper
public interface BasketDAO {
	ArrayList<BasketDTO> basketList();
	ArrayList<BasketDTO> userbasketList(int userid);
	
	int basketadd(int orderid, int id, String title, int price,
			int amount, int count, String img);
	
	int basketRemove(int id);
	
	int orderDelete(int id);
	
	int addpayments(int userid,String orderName, int amount, String paymentMethod);
	
	ArrayList<BasketDTO> payBasketList(int id);
	ArrayList<BasketDTO> payBookList(int id);
	
}
