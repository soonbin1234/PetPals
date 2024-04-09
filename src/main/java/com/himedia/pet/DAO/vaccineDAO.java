package com.himedia.pet.DAO;

import java.time.LocalDate;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.LoginDTO;
import com.himedia.pet.DTO.vpetDTO;


@Mapper
public interface vaccineDAO {

   int petadd(String num, String name, String birth, int loginid);
   
   ArrayList<vpetDTO> petload(int loginid);
   vpetDTO petchoice(int petId);
   String dateadd(String petbirth, int num);
   int pmodify(int petId, String petno, String petname, String birth);
   int pdelete(String petId);
   
   int idload(String id);

}