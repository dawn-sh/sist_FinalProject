package sist.last.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import sist.last.dto.BusinessDto;
import sist.last.dto.MemberDto;
import sist.last.service.BusinessService;

@Controller
public class BusinessController {

	@Autowired
	BusinessService businessService;
	
	@GetMapping("/member/business-join")
	public String addbusiness()
	{
		return "/company/businessAddForm";
	}
	
	@GetMapping("/member/business-idcheck")
	@ResponseBody
	public Map<String, Integer> idCheck(@RequestParam String business_id)
	{
		Map<String, Integer> map = new HashMap<>();
		
		int i = businessService.getSearchBusinessId(business_id);
		
		map.put("count", i);
		
		return map;
	}
	
	@PostMapping("/member/join-business")
	public String insert(@ModelAttribute BusinessDto dto,
			@RequestParam String hp1,
			@RequestParam String hp2,
			@RequestParam String hp3,
			@RequestParam String email1,
			@RequestParam String email2,
			HttpSession session)
	{
		String hp = hp1+"-"+hp2+"-"+hp3;
		dto.setBusiness_hp(hp);
		
		String email = email1+"@"+email2;
		dto.setBusiness_email(email);
		
		businessService.insertBusiness(dto);	

		return "/member/welcome";
	}
	
	@GetMapping("/member/business-mypage")
	public String mypage(Model model,
			HttpSession session)
	{
	/*	List<MemberDto> list = service.getAllMembers();
		
		model.addAttribute("list", list);   */
		
		String myid = (String)session.getAttribute("myid");
		//System.out.println(myid);
		
		BusinessDto businessDto = businessService.getDataByBusinessId(myid);
		
		model.addAttribute("businessDto", businessDto);
		
		//System.out.println(myid+businessDto);
		
		
		return "/company/businessMyPage";
	}

}
