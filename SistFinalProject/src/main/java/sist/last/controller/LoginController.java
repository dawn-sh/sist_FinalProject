package sist.last.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import sist.last.dto.MemberDto;
import sist.last.service.MemberService;

@Controller
public class LoginController {

	@Autowired
	MemberService service;
	
	@GetMapping("/login/loginform")
	public String loginform()
	{
		return "/login/loginForm";
	}
	
	@GetMapping("/login/fail")
	public String loginfail()
	{
		return "/member/loginFail";
		
	}
	
	@PostMapping("/login/login")
	public String login(@RequestParam String id,
			@RequestParam String pass,
			@RequestParam(required = false) String cbsave,
			HttpSession session)
	{
		HashMap<String, String> map = new HashMap<>();
		int check = service.loginPassCheck(id, pass);
		
		if(check==1) {
			
			session.setMaxInactiveInterval(60*60*8);
			
			session.setAttribute("id", id);
			session.setAttribute("loginok", "yes");
			session.setAttribute("saveok", cbsave);
			
			MemberDto memberDto = service.getDataById(id);
			
			return "redirect:/";
		}else {
			
			return "/login/loginFail";
		}
		
	} 
	
	@GetMapping("/login/logout")
	public String logout(HttpSession session)
	{
		session.removeAttribute("loginok");
		
		return "redirect:/";
	}
	
	
}
