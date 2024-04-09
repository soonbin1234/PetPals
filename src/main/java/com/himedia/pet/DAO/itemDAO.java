package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.BasketDTO;
import com.himedia.pet.DTO.itemDTO;

@Mapper
public interface itemDAO {
   ArrayList<itemDTO> itemList();

   itemDTO itemLoad(int id);  
   
   
   ArrayList<BasketDTO> userCartList(String userid);
}