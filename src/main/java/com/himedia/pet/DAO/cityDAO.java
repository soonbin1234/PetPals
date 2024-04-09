package com.himedia.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.pet.DTO.cityDTO;

@Mapper
public interface cityDAO {
	ArrayList<cityDTO> cityList();
	ArrayList<cityDTO> ciGunGuList(String city);
}
