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

import com.himedia.pet.DAO.BasketDAO;
import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.paymentsDAO;
import com.himedia.pet.DTO.BasketDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BasketController {
	
	@Autowired
	private BasketDAO bdao;
	
	@Autowired
	private LoginDAO ldao;
	
	@GetMapping("/basket")
	public String Basket() {
		return "basket";
	}
	
	@PostMapping("/basketrev")
	@ResponseBody
	public String doBasketrev(HttpServletRequest req) {
	    String userid = req.getParameter("userid"); // 세션에서 사용자 아이디 가져오기
	    System.out.println(userid);
	    int id = ldao.getuserid(userid);
	    ArrayList<BasketDTO> alList = bdao.userbasketList(id);
	    System.out.println("alList"+alList);
	    JSONArray ja = new JSONArray();
	    for (int i = 0; i < alList.size(); i++) {
	        JSONObject jo = new JSONObject();
	        jo.put("id", alList.get(i).getId());
	        jo.put("userid", alList.get(i).getUserid());
	        jo.put("orderid", alList.get(i).getOrderid());
	        jo.put("orderName", alList.get(i).getTitle());
	        jo.put("price", alList.get(i).getPrice());
	        jo.put("amount", alList.get(i).getAmount());
	        jo.put("count", alList.get(i).getCount());
	        jo.put("img", alList.get(i).getImg());
	        ja.add(jo);
	    }
	    return ja.toJSONString();
	}
	
	@PostMapping("/basketRemove")
	@ResponseBody
	public String Remove(HttpServletRequest req) {
		String id = req.getParameter("id");
   	 	System.out.println("id:" + id);
   	 	int n = bdao.basketRemove(Integer.parseInt(id));
   	 	System.out.println(n);
   	 	return ""+n;
	}
	
	   //장바구니 아이디 세션등록
	   @PostMapping("/doSession")
	   @ResponseBody
	   public String doSession(HttpServletRequest req) {
	       // 단일 문자열로 받기
	       String sessions = req.getParameter("session");
	       if(sessions != null && !sessions.equals("")) {
	           HttpSession sess = req.getSession();
	           sess.setAttribute("session", sessions);
	       } 
	        System.out.println(sessions);
	        return "1";
	   }
	        
	      
	   //주문 성공시 서버내 오더테이블 삭제 
	   @GetMapping("/orderDelete")
	   @ResponseBody 
	   public String orderDelete(HttpServletRequest req){ 
		   String orderid = req.getParameter("id"); 
		   System.out.println("orderid:"+ orderid);
		   String[] orderidArray = orderid.split(","); 
		   int n = 0; 
		   for(int i = 0; i < orderidArray.length; i++){
			   n = bdao.orderDelete(Integer.parseInt(orderidArray[i])); 
		   }
		   return "" + n;
	   }
	
	
	
}
