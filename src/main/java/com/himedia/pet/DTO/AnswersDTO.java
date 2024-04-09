package com.himedia.pet.DTO;

import lombok.Data;

@Data
public class AnswersDTO {
   int id;
   int  question_id;
   String content;
   String  writer_answer;
   String created;
   String email;
}
