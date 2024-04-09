package com.himedia.pet.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.himedia.pet.DAO.BasketDAO;
import com.himedia.pet.DAO.LoginDAO;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class paymentController {

    @Autowired
    private BasketDAO bdao;
    
    @Autowired
    private LoginDAO ldao;

    //주문 성공시 서버내 테이블에 저장
    @GetMapping("/alorder")
    @ResponseBody
    public String alOrder(HttpServletRequest req){
       String orderName = req.getParameter("orderName");
       String amount = req.getParameter("amount");
       String userid = req.getParameter("userid");
       String method = req.getParameter("method");
       int id = ldao.getuserid(userid);
    		   
       int n = bdao.addpayments(id, orderName, 
    		   					Integer.parseInt(amount), method);
       
       return ""+n;
       
    }
}
