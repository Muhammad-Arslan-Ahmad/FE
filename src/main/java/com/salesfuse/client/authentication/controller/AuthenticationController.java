/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.controller;

import com.salesfuse.client.authentication.model.PasswordChangeRequest;
import com.salesfuse.client.authentication.model.UserModel;
import com.salesfuse.client.authentication.payload.RegistrationRequest;
import com.salesfuse.client.authentication.payload.RegistrationResponse;
import com.salesfuse.client.authentication.service.AuthenticationServiceManager;
import com.salesfuse.client.authentication.service.ChangePasswordRequest;
import com.salesfuse.client.authentication.service.ChangePasswordResponse;
import com.salesfuse.client.authentication.service.CustomUser;
import com.salesfuse.client.common.RoleEnum;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

/**
 *
 * @author hossain
 */
@Controller
public class AuthenticationController {
    
    
    @Autowired
    private ServletContext mcontext;
    
    @Autowired
    private AuthenticationServiceManager authService;
    
    
    @Autowired
    private AuthenticationServiceManager authServiceManager;
    
    

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String loginPage(Model model, boolean error) {
        String errorMsg = "";
        if(error){
            errorMsg = (String)mcontext.getAttribute("c_error");
            System.out.println(errorMsg);
            model.addAttribute("error", "Invalid username or password!");
        }
        
        return "login";
    }
    
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView regPage(@ModelAttribute("userModel") UserModel userModel, String msg) {
        ModelAndView mv = new ModelAndView("register");
        if(msg != null && !msg.isEmpty()){
            System.out.println(msg);
            mv.addObject("msg", msg);
        }
        
        mv.addObject("user", userModel);
        return mv;
    }
    
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView postRegister(@ModelAttribute("userModel") UserModel userModel, HttpServletRequest req, final RedirectAttributes redirectAttributes) {
        String msg = "";
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/register"));
        try{
//            if(userModel.getPassword() != null){
//                String encPass = passwordEncoder.encode(userModel.getPassword());
//                System.out.println("enc :: " + encPass);
//                userModel.setPassword(encPass);
//            }
            userModel.setRole(RoleEnum.USER.name());
            RegistrationRequest request = RegistrationRequest.builder()
                    .user(userModel).build();
            RegistrationResponse resp = authService.register(request);
            if(resp != null && resp.isStatus() && resp.getId() != null){
                msg = "User Successfully Registered.";
                userModel = new UserModel();
            }
            else{
                if(resp != null && !resp.isStatus() && resp.getMessage() != null){
                    msg = resp.getMessage();
                }
                else{
                    msg = "User registration failed. Please contact with administrator.";
                }
            }
        }catch(Exception ex){
            ex.printStackTrace();
            msg = ex.getMessage();
        }
        redirectAttributes.addFlashAttribute("msg", msg);
        redirectAttributes.addFlashAttribute("userModel", userModel);
        return mv;
    }

//    @RequestMapping(value = "/", method = RequestMethod.GET)
//    public String loginPageRedirect(Model model) {
//        return "redirect:login";
//    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(Model model) {
        return "login";
    }

    @RequestMapping(value = "/signout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        SecurityContextHolder.clearContext();
        session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        for (javax.servlet.http.Cookie cookie : request.getCookies()) {
            cookie.setMaxAge(0);
        }

        return "redirect:/?signout=true";
    }
    
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView profile() {
        ModelAndView mv = new ModelAndView("common/profile");
        CustomUser principal = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Integer userId = principal.getUserId();
        UserModel userModel = new UserModel();
        try{
            userModel = authService.userProfile(userId);
        }catch(Exception ex){}
        mv.addObject("user", userModel);
        return mv;
    }
    
    @GetMapping("/changePassword")
    public ModelAndView changePassword(@ModelAttribute("message") String message, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, Model model) {
        ModelAndView mv = new ModelAndView("common/password_input");
        if(message.contains("Password Successfully Changed")){
            mv.addObject("msg", message);
        }
        else{
            if(message.contains("User not authenticated")){
                message = "Please type correct old password";
            }
            mv.addObject("errMsg", message);
        }
        
        return mv;
    }
    
    @PostMapping("/changePassword")
    public ModelAndView postChangePassword(@ModelAttribute("ChangePasswordRequest") PasswordChangeRequest passwordChangeRequest, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, Model model) {
       
        ModelAndView mv = new ModelAndView(new RedirectView(request.getContextPath() + "/changePassword"));
        String message = "";

        if (!passwordChangeRequest.getNewPassword().equals(passwordChangeRequest.getConfirmPassword())) {
            message = "New Password & confirm Password are not same !";
            System.out.println(" }}}}}}}}} " + message);
            redirectAttributes.addFlashAttribute("message", message);
            return mv;
        }
        CustomUser principal = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Integer userId = principal.getUserId();
        ChangePasswordRequest changePasswordRequest = new ChangePasswordRequest();

        changePasswordRequest.setUserId(userId);
        changePasswordRequest.setOldPassword(passwordChangeRequest.getOldPassword());
        changePasswordRequest.setNewPassword(passwordChangeRequest.getNewPassword());

        System.out.println(" ******************* pass chng req id : " + passwordChangeRequest.getUserId() + " " + changePasswordRequest.toString());

        try {
            ChangePasswordResponse resObject = authServiceManager.changePassword(changePasswordRequest);
            if (resObject != null) {
                message = resObject.getMessage();
            }

        } catch (Exception ex) {
            System.err.println("************** " + ex.getMessage());
            message = ex.getMessage();
        }
        redirectAttributes.addFlashAttribute("message", message);
        return mv;
    }
}
