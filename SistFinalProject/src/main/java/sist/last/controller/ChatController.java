package sist.last.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @RequestMapping("/chatlist")
    public ModelAndView chat(){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/chat/chat");
        return mv;
    }

}
