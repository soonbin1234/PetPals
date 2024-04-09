package com.himedia.pet.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.himedia.pet.DAO.LoginDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
    
    @Autowired
    private LoginDAO ldao;
    
    @PostMapping("/googleLogin")
    @ResponseBody
    public String googleLogin(@RequestParam("googleId") String googleId, @RequestParam("email") String email, HttpServletRequest req) {
       HttpSession sess = req.getSession();
       if(ldao.findEmail(email)) {
           if (!ldao.gemailExists(email,googleId)) {
              int member_id=ldao.getuserid(email);
               sess.setAttribute("email", email);
               sess.setAttribute("googleId", googleId);
               ldao.updateGoogle(email, googleId,member_id);
           } else {
              sess.setAttribute("email", email);
           }
        } else {
           if (!ldao.gemailExists(email,googleId)) {
               sess.setAttribute("email", email);
               sess.setAttribute("googleId", googleId);
               ldao.saveGoogle(email, googleId);
           } else {
              sess.setAttribute("email", email);
           }
        }
       int a= ldao.checkad(email);
       sess.setAttribute("advertiser", a);
       return "1";
    }
    
    @PostMapping("/naverLogin")
    @ResponseBody
    public String naaverLogin(@RequestParam("naverId") String naverId, @RequestParam("email") String email, HttpServletRequest req) {
        HttpSession sess = req.getSession();
        if(ldao.findEmail(email)) {
           int member_id=ldao.getuserid(email);
           if (!ldao.nemailExists(email,naverId)) {
               sess.setAttribute("email", email);
               sess.setAttribute("naverId", naverId);
               ldao.updateNaver(email, naverId,member_id);
           } else {
              sess.setAttribute("email", email);
           }
        } else {
           if (!ldao.nemailExists(email,naverId)) {
               sess.setAttribute("email", email);
               sess.setAttribute("naverId", naverId);
               ldao.saveNaver(email, naverId);
           } else {
              sess.setAttribute("email", email);
           }
        }
        int a= ldao.checkad(email);
        sess.setAttribute("advertiser", a);
        return "1"; 
        
    }
    
    
    @PostMapping("/kakaoLogin")
    @ResponseBody
    public String kakaoLogin(@RequestParam("kakaoId") String kakaoId, @RequestParam("email") String email, HttpServletRequest req) {
        HttpSession sess = req.getSession();
        if(ldao.findEmail(email)) {
           System.out.println("잉");
           if (!ldao.kemailExists(email,kakaoId)) {
              int member_id=ldao.getuserid(email);
               sess.setAttribute("email", email);
               sess.setAttribute("kakaoId", kakaoId);
               ldao.updateKakao(email, kakaoId,member_id);
           } else {
              sess.setAttribute("email", email);
           }
        } else {
           if (!ldao.kemailExists(email,kakaoId)) {
               sess.setAttribute("email", email);
               sess.setAttribute("kakaoId", kakaoId);
               ldao.saveKakao(email, kakaoId);
           } else {
              sess.setAttribute("email", email);
           }
        }
        int a= ldao.checkad(email);
        sess.setAttribute("advertiser", a);
        return "1"; 
    }

    
    @GetMapping("/login")
    public String dologin() {
       return "login";
    }
    
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/"; 
    }
    
    @GetMapping("/kakaoLogout")
    public String kakaologout(HttpSession session) {
       session.invalidate(); 
        return "redirect:/"; 
    }
    
    @PostMapping("/dologin")
    public String doLogin(HttpSession session, Model model, HttpServletRequest req) {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        int n = ldao.log(email, password); // 사용자 인증을 시도합니다.
        int a= ldao.checkad(email);
        session.setAttribute("advertiser", a);
        
        if (n == 1) { 
            session.setAttribute("email", email);
            
            int isAdmin = ldao.adLogin(email);
            if (isAdmin == 1) {
                session.setAttribute("admin", "1");
            }
            System.out.println(isAdmin);
            return "redirect:/home"; 
        } else { 
            model.addAttribute("message", "로그인 실패");
            return "login"; // 로그인 실패 시 로그인 페이지로 이동
        }
    }


    
    //로그아웃
    @GetMapping("/dologout")
    @ResponseBody
    public String dologout(HttpSession session) {
        session.invalidate();
        return "1";
    }
    
    //회원가입
    
    @PostMapping("/dosignup")
    public String dosignup(HttpServletRequest req) { 
        String email = req.getParameter("email"); 
        String password = req.getParameter("password");
        String kakaoId = req.getParameter("kakaoId");
        String naverId = req.getParameter("naverId");
        if (email == null || email.equals("")) {
            return "redirect:/login";
        } 
        
        if (ldao.kemailExists(email, kakaoId)) {
            return "redirect:/login";
        }else if(ldao.nemailExists(email, naverId)){
           return "redirect:/login";
        } else {
            int n = ldao.savelog(email, password);
            if (n > 0) {
                return "redirect:/login";
            } else {

                return "redirect:/login";
            }
        }
        
    }
    
   
    
}