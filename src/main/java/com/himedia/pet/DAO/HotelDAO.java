package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.HotelDTO;
import com.himedia.pet.DTO.HotelRoomDTO;
import com.himedia.pet.DTO.RoomsDTO;

@Mapper
public interface HotelDAO {

   ArrayList<HotelDTO> room_getList();
   ArrayList<HotelRoomDTO> room_hotelRoom();
   int room_add(String name, int type, int howmany, int howmuch);
   ArrayList<HotelRoomDTO> room_doList();
   int room_remove(int id);
   int room_modify(int id, String name, int type, int howmany, int howmuch);
   int room_plus(int id, int howmany, int howmuch, String checkin,String checkout,String name, String mobile,int bookId);   
   ArrayList<RoomsDTO> room_rList();
   int room_remove2(int id);
   int room_update(int id, String name, String mobile);
   ArrayList<HotelRoomDTO> room_roomselect(String start, String end, int parseInt);

   ArrayList<RoomsDTO> bookList(int bookId);
   
   //결제 
   RoomsDTO bookload(int id);
   int orderDelete3(int parseInt);
   int addpayments3(int id,String orderName, int amount, String paymentMethod);
   
}