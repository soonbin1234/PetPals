package com.himedia.pet.DTO;

import lombok.Data;

@Data
public class paymentDTO {
    int paymentsid;
     String orderName;
     String userid;
     int amount;
     String paymentMethod;
     String orderTime;
     String orderQuantity;
}