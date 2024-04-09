package com.himedia.pet.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.himedia.pet.DAO.BasketDAO;
import com.himedia.pet.DAO.HotelDAO;
import com.himedia.pet.DAO.LoginDAO;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class payment3Controller {
   
    @Autowired
    private BasketDAO bdao;
    
    @Autowired
    private LoginDAO ldao;
    
    @Autowired
    private HotelDAO hdao;
   
   //주문 성공시 서버내 테이블에 저장
    @GetMapping("/alorder3")
    @ResponseBody
    public String alOrder3(HttpServletRequest req){
       String orderName = req.getParameter("orderName");
       String amount = req.getParameter("amount");
       String userid = req.getParameter("userid");
       String method = req.getParameter("method");
       System.out.println(orderName);
       System.out.println(amount);
       System.out.println(userid);
       System.out.println(method);
       
       int id = ldao.getuserid(userid);
             
       int n = hdao.addpayments3(id, orderName, 
                            Integer.parseInt(amount), method);
       System.out.println(n);
       return ""+n;
       
    }
 // 주문 성공시 서버내 오더테이블 삭제 
    @GetMapping("/orderDelete3")
    @ResponseBody 
    public String orderDelete(HttpServletRequest req){ 
       String orderid = req.getParameter("id"); 
       System.out.println("orderid:"+ orderid);
       String[] orderidArray = orderid.split(","); 
       int n = 0; 
       for(int i = 0; i < orderidArray.length; i++){
          n = hdao.orderDelete3(Integer.parseInt(orderidArray[i])); 
       }
       return "" + n;
    }

}
