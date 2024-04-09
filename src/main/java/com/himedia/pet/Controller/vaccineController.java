package com.himedia.pet.Controller;

import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.protobuf.compiler.PluginProtos.CodeGeneratorResponse.File;
import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.vaccineDAO;
import com.himedia.pet.DTO.LoginDTO;
import com.himedia.pet.DTO.vpetDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class vaccineController {
   
   @Autowired
   private vaccineDAO vdao;
   
    @GetMapping("/vaccine")
      public String vaccine() {
         return "vaccine";
    }
    @PostMapping("/petadd") //펫 등록
    @ResponseBody
      public String addpet(HttpServletRequest req) {
      String num = req.getParameter("num");
      String petId = req.getParameter("petId");
      if (num== null || num.isEmpty()) {
         num="정보없음";
      }
      String name= req.getParameter("name");
      String birth = req.getParameter("birth");
      String id= req.getParameter("loginid");
      int loginid=vdao.idload(id);
        
      int n = vdao.petadd(num, name, birth,loginid);
      
      return ""+n;
         
    }
//    @PostMapping("/petadd") // 펫 등록
//    @ResponseBody
//    public String addPet(@RequestParam("num") String num,
//                         @RequestParam("petId") String petId,
//                         @RequestParam("name") String name,
//                         @RequestParam("birth") String birth,
//                         @RequestParam("loginid") String id,
//                         @RequestParam("file") MultipartFile file) {
//        try {
//            if (num == null || num.isEmpty()) {
//                num = "정보없음";
//            }
//
//            int loginid = vdao.idload(id);
//
//            String oriFileName = null; // 파일이 선택되지 않았을 때의 파일 이름
//
//            // 파일이 선택되었을 때만 파일을 저장하도록 처리
//            if (file != null && !file.isEmpty()) {
//                String savePath = "G:\\디지털java국비\\eclipse\\workspace\\pet\\src\\main\\resources\\static\\image";
//                String uploadFolderPath = Paths.get(savePath).toString();
//                System.out.println("uploadFolderPath:" + uploadFolderPath);
//
//                // 원본 파일 이름 가져오기
//                String originalFileName = file.getOriginalFilename();
//                // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
//                oriFileName = System.currentTimeMillis() + "_" + originalFileName;
//                System.out.println(oriFileName);
//
//                // 서버에 파일 저장
//                String filePath = Paths.get(uploadFolderPath, oriFileName).toString();
//                System.out.println("Uploaded File Path: " + filePath);
//                file.transferTo(new File(filePath));
//                System.out.println("Uploaded File Name: " + originalFileName);
//            }
//
//            // 펫 추가 코드
//            int n = vdao.petadd(num, name, birth, loginid, oriFileName);
//
//            return "" + n;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "Error occurred while processing request";
//        }
//    }
   

    @PostMapping("/petload") // 펫 리스트 띄우기
    @ResponseBody
      public String loadpet(HttpServletRequest req) {
      String id= req.getParameter("loginid");
      
      int loginid=vdao.idload(id);
      System.out.println("loginid: "+ loginid);
    
      JSONArray ja = new JSONArray();
      ArrayList<vpetDTO> data = vdao.petload(loginid);
      for (int i=0; i<data.size(); i++) {
         JSONObject jo = new JSONObject();
         jo.put("name", data.get(i).getPetname());
         jo.put("number", data.get(i).getPetnumber());
         jo.put("birth", data.get(i).getPetbirth());
         jo.put("id", data.get(i).getId());
         
         ja.add(jo);
      }
   
      return ja.toJSONString();    
         
    }
    @PostMapping("/petchoice") //선택한 펫 올리기
    @ResponseBody
      public String choicepet(HttpServletRequest req) {
      int petId= Integer.parseInt(req.getParameter("petId"));
      vpetDTO bdto =vdao.petchoice(petId);
      JSONObject jo =new JSONObject();
      jo.put("name",bdto.getPetname());
      jo.put("number",bdto.getPetnumber());
      jo.put("birth",bdto.getPetbirth());

      return jo.toJSONString();
     
    }
    @PostMapping("/petvaccine") // 백신 접종 날짜 구하기
    @ResponseBody
    public List<String> vaccinepet(HttpServletRequest req) {
       List<String> date = new ArrayList<> ();
        String petbirth = req.getParameter("petbirth");
        
        for(int num=6; num<19; num+=2) {
//           System.out.println(num);
           String n = vdao.dateadd(petbirth, num);
//           System.out.println(n);
           date.add(n);
        }
     
        return date;
    }
    @PostMapping("/petmodify") // 펫 정보 수정하기 
    @ResponseBody
    public String petmodify(HttpServletRequest req) {
        String petId = req.getParameter("petId");
        String petno = req.getParameter("petno");
        String petname = req.getParameter("petname");
        String birth = req.getParameter("birth");

        int n = vdao.pmodify(Integer.parseInt(petId), petno, petname, birth);
        System.out.println("Modified rows: " +n);
        
        return ""+n;
    }
    @PostMapping("/petdelete") // 펫 정보 삭제하기 
    @ResponseBody
    public String petdeletey(HttpServletRequest req) {
        String petId = req.getParameter("petId");
     
        int n = vdao.pdelete(petId);
        
        return ""+n;
    }
    



    
}