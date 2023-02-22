/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.user.controller;

import com.salesfuse.client.user.model.CreateSalesFuseUserRequest;
import com.salesfuse.client.user.model.CreateSalesFuseUserResponse;
import com.salesfuse.client.user.service.UserService;
import com.salesfuse.client.util.Utils;
import java.util.Base64;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping(path = "/user/")
public class UserController {

    @Autowired
    UserService userService;
    
    @ModelAttribute("user")
    public CreateSalesFuseUserRequest initUserModel(){
        return new CreateSalesFuseUserRequest();
    }

    @GetMapping("create")
    public ModelAndView create(HttpServletRequest req, @ModelAttribute("msg") String msg, @ModelAttribute("user") CreateSalesFuseUserRequest user) {

        ModelAndView mv = new ModelAndView("user/create");
        
        if(Utils.isOk(msg)){
            mv.addObject("msg", msg);
        }
        mv.addObject("user_create_menu", "mm-active");
        mv.addObject("user", user);
        return mv;
    }
    
    @PostMapping("create")
    public ModelAndView postCreate(@ModelAttribute("user") CreateSalesFuseUserRequest user, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        String msg = "";
        
        boolean created = true;
        try{
            String imgStr = req.getParameter("profileImg");
            if(Utils.isOk(imgStr)){
                user.setPhoto(Base64.getDecoder().decode(imgStr));
            }
            CreateSalesFuseUserResponse resp = userService.createUser(user);
            if(resp.isStatus()){
                msg = "User Created Successfully";
            }
        }catch(Exception ex){
            msg = "User Creation Failed";
            created = false;
        }
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/user/view"));
        if(!created){
            mv = new ModelAndView(new RedirectView(req.getContextPath() + "/user/create"));
            redirectAttribute.addFlashAttribute("msg", msg);
        }
        mv.addObject("user_create_menu", "mm-active");
        
        redirectAttribute.addFlashAttribute("user", user);
        return mv;
    }
    
    @GetMapping("view")
    public ModelAndView view(@ModelAttribute("user") CreateSalesFuseUserRequest user) {

        ModelAndView mv = new ModelAndView("user/view");
        mv.addObject("user_create_menu", "mm-active");
        try{
            String img = Base64.getEncoder().encodeToString(user.getPhoto());
            mv.addObject("img", img);
        }catch(Exception ex){ex.printStackTrace();}
        mv.addObject("user", user);
        return mv;
    }
    
    @PostMapping(value = "upload")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file) {
        
        String base64 = "";
        try {
            
            if (file != null && file.getOriginalFilename() != null) {
                base64 = Base64.getEncoder().encodeToString(file.getBytes());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return base64;
    }

}
