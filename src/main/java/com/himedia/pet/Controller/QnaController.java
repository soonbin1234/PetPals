package com.himedia.pet.Controller;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.QnaDAO;
import com.himedia.pet.DAO.dataDAO;
import com.himedia.pet.DTO.AnswersDTO;
import com.himedia.pet.DTO.QnaDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QnaController {
   
   @Autowired dataDAO ddao;
   @Autowired QnaDAO qdao;
   @Autowired LoginDAO ldao;
   
   @PostMapping("/doQna") // Qna로딩
   @ResponseBody
   public String doQna(HttpServletRequest req) {
       
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      int page=Integer.parseInt(pageno);
      int start=(page-1)*10;
      
        ArrayList<QnaDTO> data = qdao.QnaLoad(start);
        JSONArray ja = new JSONArray();
        
        for (int i = 0; i < data.size(); i++) {
            JSONObject jo = new JSONObject();
            jo.put("id",data.get(i).getId());
            jo.put("title", data.get(i).getTitle());
            jo.put("email", data.get(i).getEmail());
            jo.put("content", data.get(i).getContent());
            jo.put("time", data.get(i).getCreated_at());
            ja.add(jo);
        }
         return ja.toJSONString();
       
   }
   
   @GetMapping("/Qna")
   public String goQna(HttpServletRequest req,Model model) {
      int total=qdao.QnaTotal();
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      
      int page=Integer.parseInt(pageno);
      int lastpage=(int)Math.ceil((double)total/10);


      model.addAttribute("page",page);
      model.addAttribute("lastpage",lastpage);
      return "/Qna";
   }
   
   @PostMapping("/addQna") // Qna작성
   @ResponseBody
   public String addQna(HttpServletRequest req) {
      String title=req.getParameter("title");
      String content = req.getParameter("content");
      String userId = req.getParameter("userId");
      
      int id = ldao.getuserid(userId);
      int n = qdao.QnaWrite(title, id, content);
//         n = ddao.rUpdate(content,Integer.parseInt(idDisplay));
      return ""+n;
   }
   
   @GetMapping("/Qnapage") // 페이징
   @ResponseBody
   public String Qnapage(HttpServletRequest req) {
      int total=qdao.QnaTotal();
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      
      int page=Integer.parseInt(pageno);
      int block=(page-1)/10+1;
      int lastpage=(int)Math.ceil((double)total/10);
      int showpage=(block-1)*10;
      
      ArrayList<Integer> a= new ArrayList<Integer>();
      for (int i=1;i<=10;i++) {
         showpage++;
         a.add(showpage);
         if(showpage==lastpage) break;
      } 
      if(total==0) {
         return "";
      }
      
      return ""+a;
   }
   
   @PostMapping("/QnaModify") // 글 수정
   @ResponseBody
   public String QnaModify(HttpServletRequest req) {
       String title = req.getParameter("title");
       String content = req.getParameter("content");
       int uniq = Integer.parseInt(req.getParameter("uniq"));

           int n = qdao.Qmodify(title, content, uniq);
      
       return ""+n;
   }
   
   @PostMapping("/QnaDelete") // 글 삭제
   @ResponseBody
   public String QnaDelete(HttpServletRequest req) {
       int uniq = Integer.parseInt(req.getParameter("uniq"));
          int a = qdao.qnacommentdelete(uniq);
        int n = qdao.QDelete(uniq);
       
       return ""+n;
   }
   @PostMapping("/commentLoad") // 답변 로딩
   @ResponseBody
   public String commentLoad (HttpServletRequest req) {
      ArrayList<AnswersDTO> answer = qdao.QnAanswer();
      
      JSONArray ja=new JSONArray();
      for(int i=0; i<answer.size(); i++) {
         JSONObject jo = new JSONObject();
         jo.put("id",answer.get(i).getId());
         jo.put("content", answer.get(i).getContent());
         jo.put("question_id",answer.get(i).getQuestion_id());
         jo.put("email",answer.get(i).getEmail());
         ja.add(jo);
      }
      return ja.toJSONString();
         
   }
   @PostMapping("/doComment") // 답변 작성 및 수정
   @ResponseBody
   public String doComment(HttpServletRequest req) {
       int Qnaid = Integer.parseInt(req.getParameter("uniq"));// 글번호 
       String awriter = req.getParameter("login");
       String comment = req.getParameter("comment");
       String comment_id=req.getParameter("comment_id");
       int id=ldao.getuserid(awriter);
       int n ;
       
       if(comment_id == "" || comment_id.equals("")) {
         n = qdao.comment(Qnaid, id, comment);
         return ""+n;
      } else {
         qdao.commentModify(Integer.parseInt(comment_id), comment);
         return "2";
      }
   }
       @PostMapping("/comment_delete") // 답변 삭제
      @ResponseBody
      public String cdelete(HttpServletRequest req) {
          String comment_id = req.getParameter("comment_id");

          if (comment_id != null && !comment_id.isEmpty()) {
              int n = qdao.commentDelete(Integer.parseInt(comment_id));
              return ""+n;
          } else {
              return "0"; 
         }
      }
       
   }
