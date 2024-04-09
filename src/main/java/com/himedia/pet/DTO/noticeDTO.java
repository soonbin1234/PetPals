package com.himedia.pet.DTO;

import lombok.Data;

@Data
public class noticeDTO {
   int id;
   String title;
   String detail;
   String image;
   String created_at;
   int views;
   String email;

   public String getImage() {
       return this.image;
   }

}