package com.himedia.pet.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.himedia.pet.DAO.LoginDAO;
import com.himedia.pet.DAO.noticeDAO;
import com.himedia.pet.DTO.noticeDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class noticeController {

	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {

		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}

	@Autowired
	private noticeDAO ndao;

	@Autowired
	private LoginDAO ldao;
	// 공지사항 리스트

	// 공지사항 상세보기
	@GetMapping("/noticeView")
	public String doViews(@RequestParam("id") int id, Model model) {
		noticeDTO ntdo = ndao.textView(id);
		ndao.updateViews(id);
		model.addAttribute("notice", ntdo);
		System.out.println(model);
		return "noticeView";
	}

	// 공지사항 추가
	@GetMapping("/noticeWrite")
	public String doWrite() {
		return "noticeWrite";
	}

	// 공지사항 수정
	@GetMapping("/noticeUpdate")
	public String doUpdate(@RequestParam("id") int id, Model model) {
		noticeDTO notice = ndao.noticeList(id);
		model.addAttribute("notice", notice);
		System.out.println(model);
		return "noticeUpdate";
	}

	@PostMapping("/upload")
	public String donotice(@RequestParam(value = "id", required = false) String id, @RequestParam("title") String title,
			@RequestParam("writer") String writer, @RequestParam("userid") String email,
			@RequestParam(value = "file", required = false) MultipartFile file, @RequestParam("detail") String detail,
			@RequestParam(value = "views", required = false) String views, HttpServletRequest req,
			HttpServletResponse res) throws IOException {

		// 현재 시간 생성
		LocalDateTime currentTime = LocalDateTime.now();

		// 현재 시간을 원하는 형식으로 변환하여 문자열로 사용
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String created_at = currentTime.format(formatter);

		System.out.println("id: " + id);
		System.out.println("title: " + title);
		System.out.println("file: " + file);
		System.out.println("detail: " + detail);
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");

		String ori_file_name = null; // 파일이 선택되지 않았을 때의 파일 이름

		// 파일이 선택되었을 때만 파일을 저장하도록 처리
		if (file != null && !file.isEmpty()) {
			String savePath = "G:\\디지털java국비\\eclipse\\workspace\\pet\\src\\main\\resources\\static\\image";
			String uploadFolderPath = Paths.get(savePath).toString();
			System.out.println("uploadFolderPath:" + uploadFolderPath);

			// 원본 파일 이름 가져오기
			String n_image = file.getOriginalFilename();
			// 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
			ori_file_name = System.currentTimeMillis() + "_" + n_image;
			System.out.println(ori_file_name);

			// 서버에 파일 저장
			String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
			System.out.println("Uploaded File Path: " + filePath);
			file.transferTo(new File(filePath));
			System.out.println("Uploaded File Name: " + n_image);
		} else if (id != null && !id.isEmpty()) {
			// 파일이 선택되지 않은 경우, 기존 파일 이름을 유지하기 위해 이전 파일 이름을 가져옵니다.
			noticeDTO existingNotice = ndao.textView(Integer.parseInt(id));
			ori_file_name = existingNotice.getImage(); // 기존 파일명 가져오기
		}

		int userid = ldao.getuserid(email);
		int viewsInt = (views != null && !views.isEmpty()) ? Integer.parseInt(views) : 0;
		int n;
		if (id == null || id.isEmpty()) {
			n = ndao.addNotice(title, userid, ori_file_name, detail, viewsInt, created_at);
		} else {
			n = ndao.modify(Integer.parseInt(id), title, userid, ori_file_name, detail);
		}
		return "redirect:/notice";
	}

	@GetMapping("/notice")
	public String notice(HttpServletRequest req, Model model) {

		String pageno = "1";
		if (req.getParameter("page") != null && !req.getParameter("page").equals("")) {
			pageno = req.getParameter("page");
		}

		int page = Integer.parseInt(pageno);
		int start = (page - 1) * 10;
		int block = (page - 1) / 10 + 1;
		int total = ndao.total();
		System.out.println(total);
		int lastpage = (int) Math.ceil((double) total / 10);
		int showpage = (block - 1) * 10;
		ArrayList<Integer> a = new ArrayList<Integer>();
		for (int i = 1; i <= 10; i++) {
			showpage++;
			a.add(showpage);
			if (showpage == lastpage)
				break;
		}

		model.addAttribute("showpage", a);
		model.addAttribute("page", page);
		model.addAttribute("lastpage", lastpage);

		return "notice";
	}

	@PostMapping("/delete")
	@ResponseBody
	public String doRemove(HttpServletRequest req) {
		String id = req.getParameter("id");
		System.out.println("id= " + id);
		int n = ndao.remove(Integer.parseInt(id));
		return "" + n;
	}

	@GetMapping("/noticelist")
	@ResponseBody
	public String noticelist(HttpServletRequest req) {
		String email = req.getParameter("email");
		int id = ldao.getuserid(email);
		String pageno = "1";
		if (req.getParameter("page") != null && !req.getParameter("page").equals("")) {
			pageno = req.getParameter("page");
		}

		int page = Integer.parseInt(pageno);
		int start = (page - 1) * 10;
		ArrayList<noticeDTO> data = ndao.notice(start);
		JSONArray ja = new JSONArray();
		for (int i = 0; i < data.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", data.get(i).getId());
			jo.put("email", data.get(i).getEmail());
			jo.put("title", data.get(i).getTitle());
			jo.put("created_at", data.get(i).getCreated_at());
			jo.put("views", data.get(i).getViews());
			ja.add(jo);
		}
		System.out.println("1" + ja);
		return ja.toJSONString();
	}

}