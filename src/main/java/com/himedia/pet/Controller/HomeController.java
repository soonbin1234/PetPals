package com.himedia.pet.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.himedia.pet.DAO.BasketDAO;
import com.himedia.pet.DAO.HotelDAO;
import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.QnaDAO;
import com.himedia.pet.DAO.cityDAO;
import com.himedia.pet.DAO.dataDAO;
import com.himedia.pet.DTO.BasketDTO;
import com.himedia.pet.DTO.LoginDTO;
import com.himedia.pet.DTO.QnaDTO;
import com.himedia.pet.DTO.RoomsDTO;
import com.himedia.pet.DTO.adDTO;
import com.himedia.pet.DTO.boardDTO;
import com.himedia.pet.DTO.cityDTO;
import com.himedia.pet.DTO.dataDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

   @Autowired
   private dataDAO ddao;
   
   @Autowired
   private LoginDAO ldao;
   
   @Autowired
   private cityDAO cdao;
   
   @Autowired
   private QnaDAO qdao;
   
   @Autowired
   private HotelDAO hdao;
   
   @Autowired
   private BasketDAO bdao;
   
   @GetMapping("/")
   public String goHome() {
      return "popupContent";
   }
   @GetMapping("/home")
   public String go22Home() {
      return "home";
   }
   @GetMapping("/success2")
   public String success2() {
      return "success2";
   }
   
   @GetMapping("/popupContent")
   public String popupContent() {
      return "popupContent";
   }
   
   
   @GetMapping("/review")
   public String goReview(HttpServletRequest req,Model model) {
      String pid = req.getParameter("pid");
      model.addAttribute("pid",pid);
      return "/review";
   }
   
   @GetMapping("/write")
   public String goWrite(HttpServletRequest req,Model model) {
      String pid = req.getParameter("pid");
      model.addAttribute("pid",pid);
      return "/write";
   }
   
   @GetMapping("/page")
   public String gopage(HttpServletRequest req,Model model) {
      String id = req.getParameter("id");
      int petId = Integer.parseInt(id);
      int total=ddao.reviewTotal(petId);
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      
      int page=Integer.parseInt(pageno);
      int lastpage=(int)Math.ceil((double)total/10);
      
      
      model.addAttribute("page",page);
      model.addAttribute("id",petId);
      model.addAttribute("lastpage",lastpage);
      return "/page";
   }
   @GetMapping("/search")
   public String test(HttpServletRequest req,Model model) {
      String text=req.getParameter("search");
      text="*"+text+"*";
      int total=ddao.searchTotal(text);
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      
      int page=Integer.parseInt(pageno);
      int start=(page-1)*10;
      int block=(page-1)/10+1;
      int lastpage=(int)Math.ceil((double)total/10);
//      System.out.println(lastpage);
      int showpage=(block-1)*10;
      ArrayList<Integer> a= new ArrayList<Integer>();
      for (int i=1;i<=10;i++) {
         showpage++;
         a.add(showpage);
         if(showpage==lastpage) break;
      }
      
      
      
      ArrayList<dataDTO> alsearch =ddao.searchList(text,start);
      model.addAttribute("alList",alsearch);
      model.addAttribute("showpage",a);
      model.addAttribute("page",page);
      model.addAttribute("search",text);
      model.addAttribute("lastpage",lastpage);
      return "store";
   }
   
   @GetMapping("/store")
    public String getHospital(HttpServletRequest req,Model model) {
      String text = req.getParameter("text");
      String[] split = text.split(",");
      String search=req.getParameter("search");
      String city=req.getParameter("city");
      String ciGunGu=req.getParameter("ciGunGu");
      System.out.println("search"+search);
      String pageno="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno = req.getParameter("page");
      }
      int page = Integer.parseInt(pageno);
      int start = (page-1)*10;
//      System.out.println("start 는 시작" + start);
      int block = (page-1)/10+1;
//      System.out.println("block 은 페이지열 갯수" + block);
      
//      System.out.println("lastpage 는 끝페이지"+lastpage);
      int showpage=(block-1)*10;
//      System.out.println("showpage는 10개페이지"+showpage);
      System.out.println(text);
//      System.out.println("text 는 이름 "+text);
      int lastpage =0;
      if(search==null||search.equals("")) {
         if(city==null||city.equals("")) {
            if(split.length==1) {
               System.out.println("1");
               int hos_cnt = ddao.getHos_cnt(split[0]);
               lastpage = (int)Math.ceil((double)hos_cnt/10);
               ArrayList<dataDTO> alHospital=ddao.getHos(text,start);
               model.addAttribute("alList",alHospital);
               model.addAttribute("text",text);
            }else {
               System.out.println("2");
               
               int total_cnt=ddao.getTotal_cnt(split[0],split[1],split[2]);
               lastpage = (int)Math.ceil((double)total_cnt/10);
               ArrayList<dataDTO> alTotal=ddao.getTotal(split[0],split[1],split[2],start);
               model.addAttribute("alList",alTotal);
               model.addAttribute("text",text);
            }
         } else {
            String fcity=city+" "+ciGunGu;
            if(split.length==1) {
               int hos_cnt = ddao.citygetHos_cnt(split[0],fcity);
               lastpage = (int)Math.ceil((double)hos_cnt/10);
               ArrayList<dataDTO> alHospital=ddao.citygetHos(text,start,fcity);
               model.addAttribute("alList",alHospital);
               model.addAttribute("text",text);
               model.addAttribute("city",city);
               model.addAttribute("ciGunGu",ciGunGu);
            }else {
               String str=split[0]+"|"+split[1]+"|"+split[2];
               int total_cnt=ddao.citygetTotal_cnt(str,fcity);
               lastpage = (int)Math.ceil((double)total_cnt/10);
               ArrayList<dataDTO> alTotal=ddao.citygetTotal(str,start,fcity);
               System.out.println("altotal"+alTotal);
               model.addAttribute("alList",alTotal);
               model.addAttribute("text",text);
               model.addAttribute("city",city);
               model.addAttribute("ciGunGu",ciGunGu);
            }
         }
      } else {
         int total=ddao.searchTotal(search);
         lastpage=(int)Math.ceil((double)total/10);
         ArrayList<dataDTO> alsearch =ddao.searchList(search,start);
         model.addAttribute("alList",alsearch);
         model.addAttribute("search",search);
      }
      ArrayList<Integer> a = new ArrayList<Integer>();
      for(int i=1;i<=10;i++) {
         showpage++;
         a.add(showpage);
         if(showpage==lastpage) break;
      }
      ArrayList<Integer> tblnum= new ArrayList<Integer>();
      for(int i=1;i<=10;i++) {
          start++;
          tblnum.add(start);
       }
      System.out.println(tblnum);
      model.addAttribute("tblnum",tblnum);
      
      //페이지를 위한 모델들
      model.addAttribute("showpage",a);
      model.addAttribute("page",page);
      model.addAttribute("lastpage",lastpage);
      
        return "store";
    }
   
   @PostMapping("like") // 찜하기
   @ResponseBody
   public String JJim(HttpServletRequest req) {
      String pid=req.getParameter("id");
      String userid=req.getParameter("userid");
      String jjim_id=req.getParameter("jjim_id");
      int uid=ldao.getuserid(userid);
      if(jjim_id==null ||jjim_id.equals("")) {
         int n=ddao.jjim(uid, Integer.parseInt(pid));
         int y=ddao.getJjimid(uid, Integer.parseInt(pid));
         return ""+y;
      }else {
         ddao.delJjim(Integer.parseInt(jjim_id));
         return "-1";
      }
   }
   
   @PostMapping("cheklike") // 찜체크하기
   @ResponseBody
   public String chekJJim(HttpServletRequest req) {
      String pid=req.getParameter("id");
      String userid=req.getParameter("userid");
      int uid=ldao.getuserid(userid);
      int n=ddao.chekJjim(uid, Integer.parseInt(pid));
      if(n==1) {
         int y=ddao.getJjimid(uid, Integer.parseInt(pid));
         return  ""+y;
      }
      return ""+n;
   }
   
   @PostMapping("/doload") // 상세페이지에 db가져오기
   @ResponseBody
   public String doload(HttpServletRequest req) {
      String id = req.getParameter("id");   
      dataDTO ddto = ddao.view(Integer.parseInt(id));
            
      JSONObject jo = new JSONObject();   
      jo.put("name", ddto.name);
       jo.put("localAddress",ddto.loadAddress);
       jo.put("category",ddto.category);
       System.out.println("jo: "+jo);
       jo.put("number", ddto.number);
       jo.put("homepage", ddto.homepage);
       jo.put("time", ddto.operatingTime);
       jo.put("holiday", ddto.holiday);
       jo.put("petben", ddto.petben);
       jo.put("size", ddto.petSize);
       jo.put("areain", ddto.areaIn);
       jo.put("areaout",ddto.areaOut);
       jo.put("parking", ddto.parking);
       jo.put("wido",ddto.wido);
       jo.put("gyeongdo", ddto.gyeongdo);
                
      return jo.toJSONString();
   }
   
   @PostMapping("/doReview") // 리뷰 로딩
   @ResponseBody
   public String review(HttpServletRequest req) {
       String id = req.getParameter("id");
       
       if (id == null || id.isEmpty()) {
           return "Error: Invalid pet_id";
       }// 유효한 값인 경우에만 숫자로 변환
       try {
           int petId = Integer.parseInt(id);
           
           int total=ddao.reviewTotal(petId);
         String pageno ="1";

         if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
            pageno=req.getParameter("page");
         }
         int page=Integer.parseInt(pageno);
         
         int start=(page-1)*10;
         
           ArrayList<boardDTO> data = ddao.reviewLoad(petId,start);
           JSONArray ja = new JSONArray();
           for (int i = 0; i < data.size(); i++) {
               JSONObject jo = new JSONObject();
               jo.put("id", data.get(i).id);
               jo.put("userid", data.get(i).userId);
               jo.put("email", data.get(i).email);
               jo.put("content", data.get(i).content);
               jo.put("rating", data.get(i).rating);
               jo.put("time", data.get(i).created);
               ja.add(jo);
           }
         /* System.out.println(ja); */
           return ja.toJSONString();
       } catch (NumberFormatException e) { // 숫자로 변환할 수 없는 경우에 대한 예외 처리.
           e.printStackTrace(); //
           return "Error: Invalid pet_id";
       }
   }
   
   @PostMapping("/doWrite") // 리뷰작성
   @ResponseBody
   public String doWrite(HttpServletRequest req) {
      String pName=req.getParameter("pName");
 
      String content = req.getParameter("content");
      String idDisplay = req.getParameter("idDisplay");
      String rating = req.getParameter("rating");
      String userId = req.getParameter("userId");
      System.out.println("userID"+userId);
      
      
      int n=0;
      if(idDisplay == null || idDisplay.equals("")) {
         n = ddao.write(Integer.parseInt(pName),Integer.parseInt(userId),content,rating);
         System.out.println("n"+n);
      } else {
         n = ddao.rUpdate(content,rating,Integer.parseInt(idDisplay));
         System.out.println("n"+n);
      }
      System.out.println("n"+n);
      return ""+n;
   }
   
   @GetMapping("/rDelet") // 리뷰 삭제
   @ResponseBody
   public String rDelet(HttpServletRequest req) {
      String id=req.getParameter("id");
      int n=ddao.rDelete(Integer.parseInt(id));
       
      return ""+n; 
   }
   
   
   @PostMapping("/reLoad") // 수정할 리뷰 로딩
   @ResponseBody
   public String reviewLoad(HttpServletRequest req) {
      int idDisplay = Integer.parseInt(req.getParameter("idDisplay")); 
      boardDTO ddto2 = ddao.reLoad(idDisplay);
      JSONObject jo = new JSONObject();   
    
      jo.put("content",ddto2.content);
      jo.put("rating", ddto2.rating);
      
      
      System.out.println("수정할 리뷰 내용: "+ jo);
      
      return jo.toJSONString();
   }
   
   @GetMapping("/showpage") // 페이징
   @ResponseBody
   public String showpage(HttpServletRequest req) {
      String id = req.getParameter("id");
      int petId = Integer.parseInt(id);
      int total=ddao.reviewTotal(petId);
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
   
   
   
   
   
   //마이페이지 만들기
      @GetMapping("/mypage")
      public String gomypage() {
         return "mypage";
      }
      //포인트샵만들기
      @GetMapping("/pointShop")
      public String gopointShop() {
         return "pointShop";
      }
      
      
      @GetMapping("/updateMy")
      @ResponseBody
      public String goprofileList(HttpServletRequest req) {
         String id = req.getParameter("id");
         int mem_id = ldao.getuserid(id);
         System.out.println("member_id는 넘버"+mem_id);
         String pass = req.getParameter("pass");
         System.out.println("id 는 업데이트"+id);
         System.out.println("pass는비번"+pass);
         
         ArrayList<LoginDTO> alUpdateMy = ldao.updateMyList(mem_id);
         JSONArray ja = new JSONArray();
         for(int i=0;i<alUpdateMy.size();i++) {
            JSONObject jo = new JSONObject();
            jo.put("id",alUpdateMy.get(i).getId());
            jo.put("email",alUpdateMy.get(i).getEmail());
            jo.put("password",alUpdateMy.get(i).getPassword());
            jo.put("kakaoId",alUpdateMy.get(i).getKakaoId());
            jo.put("naverId",alUpdateMy.get(i).getNaverId());
            ja.add(jo);   
         }
         return ja.toJSONString();
      
         
      }
   
      @GetMapping("/cityList")
      @ResponseBody
      public String cityList(HttpServletRequest req) {
         ArrayList<cityDTO> alcity = cdao.cityList();
         JSONArray ja = new JSONArray();
         for(int i=0;i<alcity.size();i++) {
            JSONObject jo = new JSONObject();
            jo.put("city",alcity.get(i).getCity());
            ja.add(jo);
            
         }
         return ja.toJSONString();
      }
      
      @GetMapping("/ciGunGuList")
      @ResponseBody
      public String ciGunGuList(HttpServletRequest req) {
         String city=req.getParameter("city");
         ArrayList<cityDTO> alcity = cdao.ciGunGuList(city);
         JSONArray ja = new JSONArray();
         for(int i=0;i<alcity.size();i++) {
            JSONObject jo = new JSONObject();
            jo.put("ciGunGu",alcity.get(i).getCiGunGu());
            ja.add(jo);
         }
         return ja.toJSONString();
      }
   
   @PostMapping("/citysearch")
   public String citysearch(HttpServletRequest req,Model model) {
      String city=req.getParameter("city");
      String ciGunGu=req.getParameter("ciGunGu");
      String text=req.getParameter("text");
      String[] split = text.split(",");
      String fcity=city+" "+ciGunGu;
      String pageno ="1";
      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
         pageno=req.getParameter("page");
      }
      
      int page=Integer.parseInt(pageno);
      int start = (page-1)*10;
      int block = (page-1)/10+1;
      int showpage=(block-1)*10;
      

      int lastpage =0;
      if(split.length==1) {
         int hos_cnt = ddao.citygetHos_cnt(split[0],fcity);
         lastpage = (int)Math.ceil((double)hos_cnt/10);
         ArrayList<dataDTO> alHospital=ddao.citygetHos(text,start,fcity);
         model.addAttribute("alList",alHospital);
         model.addAttribute("text",text);
         model.addAttribute("city",city);
         model.addAttribute("ciGunGu",ciGunGu);
      }else {
         String str="'"+split[0]+"|"+split[1]+"|"+split[2]+"'";
         int total_cnt=ddao.citygetTotal_cnt(str,fcity);
         lastpage = (int)Math.ceil((double)total_cnt/10);
         ArrayList<dataDTO> alTotal=ddao.citygetTotal(str,start,fcity);
         model.addAttribute("alList",alTotal);
         model.addAttribute("text",text);
         model.addAttribute("city",city);
         model.addAttribute("ciGunGu",ciGunGu);
      }
      ArrayList<Integer> a = new ArrayList<Integer>();
      for(int i=1;i<=10;i++) {
         showpage++;
         a.add(showpage);
         if(showpage==lastpage) break;
      }
      ArrayList<Integer> tblnum= new ArrayList<Integer>();
      for(int i=1;i<=10;i++) {
          start++;
          tblnum.add(start);
       }
      System.out.println(tblnum);
      model.addAttribute("tblnum",tblnum);
      model.addAttribute("showpage",a);
      model.addAttribute("page",page);
      model.addAttribute("lastpage",lastpage);
      return "store";
   }
   
   
   //찜목록으로 이동하기
   @GetMapping("/myjjim")
   public String myjjim(HttpServletRequest req) {
      return "myjjim";
   }
   
   
   //찜목록 제이슨으로 띄우기 리뷰,qna,찜 모두 가능
   @GetMapping("/myList")
   @ResponseBody
   public String showJJim(HttpServletRequest req) {
      String userid = req.getParameter("userid");
      System.out.println("userid는"+userid);
      String data = req.getParameter("data");
      System.out.println("data는 "+data);
      String email = req.getParameter("userid");
      String emailId = ddao.getjjim_id(email);
      JSONArray ja = new JSONArray();
      
      if(data.equals("1")) {
         int id=ldao.getuserid(userid);
         ArrayList<boardDTO> alReview = ddao.reviewList(id);
            for(int i=0;i<alReview.size();i++) {
               JSONObject jo = new JSONObject();
               jo.put("id",alReview.get(i).getId());
               jo.put("content",alReview.get(i).getContent());
               jo.put("email",alReview.get(i).getEmail());
               jo.put("rating",alReview.get(i).getRating());
               ja.add(jo);
            }
            return ja.toJSONString();

      } else if(data.equals("2")){
         int id = ldao.getuserid(userid);
         ArrayList<QnaDTO> alQNA = qdao.qnaList(id);
            for(int i=0;i<alQNA.size();i++) {
               JSONObject jo = new JSONObject();
               jo.put("id",alQNA.get(i).getId());
               jo.put("content",alQNA.get(i).getContent());
               jo.put("title",alQNA.get(i).getTitle());
               jo.put("email",alQNA.get(i).getEmail());
               ja.add(jo);
            }
            return ja.toJSONString();

      } else if(data.equals("3")){
         ArrayList<dataDTO> alJJim = ddao.jjimList(Integer.parseInt(emailId));
         for(int i=0;i<alJJim.size();i++) {
            JSONObject jo = new JSONObject();
            jo.put("id",alJJim.get(i).getId());
            jo.put("name",alJJim.get(i).getName());
            jo.put("number",alJJim.get(i).getNumber());
            jo.put("loadAddress",alJJim.get(i).getLoadAddress());
            ja.add(jo);
         }
            return ja.toJSONString();
      }  else if(data.equals("4")){
          ArrayList<RoomsDTO> alBook = hdao.bookList(Integer.parseInt(emailId));
          System.out.println("alBook은 예약"+alBook);
          for(int i=0;i<alBook.size();i++) {
             JSONObject jo = new JSONObject();
             jo.put("id",alBook.get(i).getBookId());
             jo.put("name",alBook.get(i).getName());
             jo.put("rname",alBook.get(i).getRname());
             jo.put("howmuch",alBook.get(i).getHowmuch());
             jo.put("mobile",alBook.get(i).getMobile());
             ja.add(jo);
          }
             return ja.toJSONString();
       } else if(data.equals("5")){
           int id = ldao.getuserid(userid);
           System.out.println("id: "+ id);
            ArrayList<BasketDTO> alPayment = bdao.payBasketList(id);
            System.out.println("alBook은 예약"+alPayment);
            for(int i=0;i<alPayment.size();i++) {
               JSONObject jo = new JSONObject();
               jo.put("email",alPayment.get(i).getEmail());
               jo.put("orderName",alPayment.get(i).getOrderName());
               jo.put("amount",alPayment.get(i).getAmount());
               jo.put("order_time",alPayment.get(i).getOrder_time());
               ja.add(jo);
            }
          
            ArrayList<BasketDTO> alPayment1 = bdao.payBookList(id);
            for(int i=0;i<alPayment1.size();i++) {
               JSONObject jo = new JSONObject();
               jo.put("email",alPayment1.get(i).getEmail());
               jo.put("orderName",alPayment1.get(i).getOrderName());
               jo.put("amount",alPayment1.get(i).getAmount());
               jo.put("order_time",alPayment1.get(i).getOrder_time());
               ja.add(jo);
            }
               return ja.toJSONString();
         }
         else {
         return "0";
      }
   }
   
   @GetMapping("/adrequest")
   public String adRequest() {
      return "adrequest";
   }
   
   @GetMapping("/adregistration")
   public String adregistration() {
      return "adregistration";
   }
   
   @PostMapping("/adsave")
   public String adsave(@RequestParam(value="file", required=false) MultipartFile file,
         HttpServletRequest req) throws IOException {
      String url=req.getParameter("url");
      String userid=req.getParameter("userid");
      String savePath = "G:\\디지털java국비\\eclipse\\workspace\\pet\\src\\main\\resources\\static\\image";
       String uploadFolderPath = Paths.get(savePath).toString();
       System.out.println("uploadFolderPath:" + uploadFolderPath);

       // 원본 파일 이름 가져오기
       String n_image = file.getOriginalFilename();
       // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
       String ori_file_name = System.currentTimeMillis() + "_" + n_image;
       System.out.println(ori_file_name);
       
       // 서버에 파일 저장
       String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
       System.out.println("Uploaded File Path: " + filePath);
       file.transferTo(new File(filePath));
       System.out.println("Uploaded File Name: " + n_image);
       
       int id = ldao.getuserid(userid);
       
       int n= ddao.adregistration(url,ori_file_name,id);
       
       return "redirect:/";
   }
   
   @PostMapping("/completead")
   @ResponseBody
   public String completeAD(HttpSession session,HttpServletRequest req) {
      String userid=req.getParameter("userid");
      String month = req.getParameter("month");
      String money=req.getParameter("amount");
      String method=req.getParameter("method");
      month=month+"개월";
      int id=ldao.getuserid(userid);
      session.setAttribute("advertiser", "1");
      int a=ldao.addadvertiser(id);
      System.out.println("a="+a);
      int n=ddao.adsave(id, month, Integer.parseInt(money), method);
      
      return ""+n; 
   }
   @PostMapping("/adupload")
   public ResponseEntity<String> handleFileUpload(@RequestParam("file") MultipartFile file) {
      try {
           // 업로드 디렉토리에 파일 저장
         String savePath = "C:\\Users\\1234\\git\\petbnb\\src\\main\\resources\\static\\image";
         String uploadFolderPath = Paths.get(savePath).toString();
         System.out.println("uploadFolderPath:" + uploadFolderPath);
      
         // 원본 파일 이름 가져오기
         String n_image = file.getOriginalFilename();
         // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
         String ori_file_name = System.currentTimeMillis() + "_" + n_image;
         System.out.println(ori_file_name);
         
         // 서버에 파일 저장
         String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
         System.out.println("Uploaded File Path: " + filePath);
         file.transferTo(new File(filePath));
         System.out.println("Uploaded File Name: " + n_image);
           return new ResponseEntity<>("파일이 성공적으로 업로드되었습니다.", HttpStatus.OK);
       } catch (IOException e) {
           return new ResponseEntity<>("파일 업로드 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
       }
   }
   
   @GetMapping("/showad")
   @ResponseBody
   public String showad() { 
     ArrayList<adDTO> alad = ddao.adList();
     JSONArray ja = new JSONArray();
      for(int i=0;i<alad.size();i++) {
         JSONObject jo = new JSONObject();
         jo.put("img",alad.get(i).getImg());
         ja.add(jo);
      }
      return ja.toJSONString();
   }
   @GetMapping("/bringurl")
   @ResponseBody
   public String bringurl(HttpServletRequest req) {
      String img=req.getParameter("img");
      ArrayList<adDTO> alad = ddao.urlList(img);
        JSONArray ja = new JSONArray();
         for(int i=0;i<alad.size();i++) {
            JSONObject jo = new JSONObject();
            jo.put("url",alad.get(i).getUrl());
            ja.add(jo);
         }
         return ja.toJSONString();
      
   }
   
   
   
   
   
   
   
   
//   @GetMapping("/ajax")
//   public String ajax(HttpServletRequest req,Model model) {
//      String text=req.getParameter("text");
//      int total=ddao.searchTotal(text);
//      String pageno ="1";
//      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
//         pageno=req.getParameter("page");
//      }
//      
//      int page=Integer.parseInt(pageno);
//      int start=(page-1)*10;
//      int block=(page-1)/10+1;
//      int lastpage=(int)Math.ceil((double)total/10);
////      System.out.println(lastpage);
//      int showpage=(block-1)*10;
//      ArrayList<Integer> a= new ArrayList<Integer>();
//      for (int i=1;i<=10;i++) {
//         showpage++;
//         a.add(showpage);
//         if(showpage==lastpage) break;
//      }
//      
//      model.addAttribute("page",page);
//      model.addAttribute("lastpage",lastpage);
//      model.addAttribute("text",text);
//      
//      return "pagingAjax";
//   }
//   
//   
//   @GetMapping("/testajax")
//   @ResponseBody
//   public String testajax(HttpServletRequest req) {
//      String text=req.getParameter("text");
//      System.out.println(text);
//      int total=ddao.searchTotal(text);
//      String pageno ="1";
//      System.out.println(req.getParameter("page"));
//      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
//         pageno=req.getParameter("page");
//      }
//      int page=Integer.parseInt(pageno);
//      System.out.println("page"+page);
//      int start=(page-1)*10;
//      int block=(page-1)/10+1;
//      int lastpage=(int)Math.ceil((double)total/10);
////      System.out.println(lastpage);
//      int showpage=(block-1)*10;
//      ArrayList<Integer> a= new ArrayList<Integer>();
//      for (int i=1;i<=10;i++) {
//         showpage++;
//         a.add(showpage);
//         if(showpage==lastpage) break;
//      }
//      
//      
//      
//      ArrayList<dataDTO> alsearch =ddao.searchList(text,start);
//      JSONArray ja = new JSONArray();
//      for (int i = 0; i < alsearch.size(); i++) {
////         System.out.println("들어옴");
//         JSONObject jo = new JSONObject();
//         jo.put("id", alsearch.get(i).getId());
//         jo.put("loadAddress", alsearch.get(i).getLoadAddress());
////         System.out.println(alsearch.get(i).getImage());
//         jo.put("name", alsearch.get(i).getName());
//         ja.add(jo);
//      }
//
//      return ja.toJSONString();
//   }
//   
//   @GetMapping("/showpage")
//   @ResponseBody
//   public String showpage(HttpServletRequest req) {
//      String text=req.getParameter("text");
//      int total=ddao.searchTotal(text);
//      String pageno ="1";
//      if(req.getParameter("page")!=null && !req.getParameter("page").equals("")) {
//         pageno=req.getParameter("page");
//      }
//      
//      int page=Integer.parseInt(pageno);
//      int start=(page-1)*10;
//      int block=(page-1)/10+1;
//      int lastpage=(int)Math.ceil((double)total/10);
////      System.out.println(lastpage);
//      int showpage=(block-1)*10;
//      ArrayList<Integer> a= new ArrayList<Integer>();
//      for (int i=1;i<=10;i++) {
//         showpage++;
//         a.add(showpage);
//         if(showpage==lastpage) break;
//      }
//
//      return ""+a;
//   }
   
}