package sist.last.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatController {

    @RequestMapping("/chat/chatting")

    public ModelAndView chat(){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/chat/chat");
        return mv;
    }

}
