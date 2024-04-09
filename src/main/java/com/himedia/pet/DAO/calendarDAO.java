package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.calendarDTO;

@Mapper
public interface calendarDAO {
   // 일정 추가
   int addCalendar(String userName, String title, String start,
               String end, String backgroundColor);
   // 일정 보기
   ArrayList<calendarDTO> selectCal(String userName);
   
   // 일정 id가져오기
   String getCal_id(String title);
   // 일정 삭제
   int delCalendar(int id);
}
