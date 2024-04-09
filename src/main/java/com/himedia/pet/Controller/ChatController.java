package com.himedia.pet.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.himedia.pet.DAO.LoginDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller

public class ChatController {
   
   @Autowired
   private LoginDAO ldao;
   
    @GetMapping("/error")
    public String index(){
        return "error";
    }
    
    @GetMapping("/chattingRoom")
    public String asd() {
       return "chattingRoom";
    }

    @GetMapping("/chatting")
    @ResponseBody
    public String chattingRoom(HttpServletRequest req, HttpSession session, Model model){
       String email = req.getParameter("email");
       System.out.println("email:"+ email);
       
       
       int n=0;
       if (n == 1) { 
            session.setAttribute("email", email);
            
            int isAdmin = ldao.adLogin(email);
            if (isAdmin == 1) {
                session.setAttribute("admin", "1");
                return "master"; // 관리자인 경우 "master" 반환
            }
            System.out.println("isAdmin:"+isAdmin);
        } 
          return ""+n; 
    }

}
       


