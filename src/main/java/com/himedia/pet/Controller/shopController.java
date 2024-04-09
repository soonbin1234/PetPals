package com.himedia.pet.Controller;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.himedia.pet.DAO.BasketDAO;
import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.itemDAO;
import com.himedia.pet.DTO.BasketDTO;
import com.himedia.pet.DTO.itemDTO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class shopController {
   
   @Autowired
   private itemDAO idao;
   @Autowired
   private BasketDAO bdao;
   
   @Autowired
   private LoginDAO ldao;
   
   @GetMapping("/itemList")
   public String itemView(Model model) {
          
      ArrayList<itemDTO> item = idao.itemList();
      model.addAttribute("itemList", item);
      return "/itemList";
      
   }
   @GetMapping("/goodorder")
   public String goodorder(HttpServletRequest req, Model model) {
          
	   String id = req.getParameter("id");
       model.addAttribute("id",id);
       System.out.println("model"+model);
      return "/goodorder";
      
   }
   @PostMapping("/itemLoad") 
      @ResponseBody
      public String itemLoad(HttpServletRequest req) {
         int id = Integer.parseInt(req.getParameter("id"));
         System.out.println(id);
         
         itemDTO idto = idao.itemLoad(id);
         JSONObject jo = new JSONObject();
         jo.put("title", idto.getTitle());
         jo.put("img", idto.getImg());
         jo.put("price",idto.getPrice());
       
         System.out.println("내용: "+ jo);
         
         return jo.toJSONString();
      }
   
   @PostMapping("/basket")
   @ResponseBody
   public String Basket(HttpServletRequest req) {
	   String orderid = req.getParameter("orderid");
	   String userid = req.getParameter("userid");
	   String title = req.getParameter("title");
	   String price = req.getParameter("price");
	   String count = req.getParameter("count");
	   String amount = req.getParameter("amount");
	   String img = req.getParameter("img");
	   System.out.println("-------------------");
	   System.out.println("orderid:" + orderid);
	   System.out.println("userid:" + userid);
	   System.out.println("title:" + title);
	   System.out.println("price:" + price);
	   System.out.println("count:" + count);
	   System.out.println("amount:" + amount);
	   System.out.println("img:" + img);
	   
	   int id = ldao.getuserid(userid);
	   
	   ArrayList<BasketDTO> alList =bdao.basketList(); 
	   System.out.println("alList: "+ alList);
	   int n = bdao.basketadd(Integer.parseInt(orderid),
			   				  id,
			   				  title,
			   				  Integer.parseInt(price),
			   				  Integer.parseInt(amount),
			   				  Integer.parseInt(count),
			   				  img);
	   
	   return ""+n;
   }
   

}
