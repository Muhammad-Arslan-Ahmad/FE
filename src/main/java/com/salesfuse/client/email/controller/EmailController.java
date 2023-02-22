/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.email.controller;

import com.salesfuse.client.email.model.EmailCreateRequest;
import com.salesfuse.client.message.model.SearchMessageRequest;
import com.salesfuse.client.message.model.SearchMessageResponse;
import com.salesfuse.client.message.service.MessageService;
import com.salesfuse.client.play.model.Play;
import com.salesfuse.client.play.model.SearchPlayRequest;
import com.salesfuse.client.play.model.SearchPlayResponse;
import com.salesfuse.client.play.service.PlayService;
import com.salesfuse.client.proof.model.ProofSearchRequest;
import com.salesfuse.client.proof.model.ProofSearchResponse;
import com.salesfuse.client.proof.service.ProofService;
import com.salesfuse.client.role.model.Narration;
import com.salesfuse.client.role.model.Role;
import com.salesfuse.client.role.service.RoleService;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author anwar
 */
@Controller
@RequestMapping(path = "/email/")
public class EmailController {

    @Autowired
    RoleService roleService;
    
    @Autowired
    ProofService proofService;
    
    @Autowired
    PlayService playService;
    
    @Autowired
    MessageService messageService;
    
    @Autowired
    private VelocityEngine velocityEngine;

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("email/create");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public ModelAndView enrolFirst(@ModelAttribute("emailRequest") EmailCreateRequest request) {

        ModelAndView mv = new ModelAndView("email/create");
        try {
            List<Narration> narrations = new ArrayList<>();
            if (request.getType().equals("Role")) {
                String id = request.getId();
                Role role = roleService.getRole(id);
                if (role != null && role.getNarrations() != null) {
                    narrations = role.getNarrations();
                }
            }
            if (request.getType().equals("Proof")) {

            }
            if (request.getType().equals("Product")) {

            }
            if (request.getType().equals("Proof")) {

            }
            Collections.sort(narrations, new Comparator<Narration>() {
                @Override
                public int compare(Narration o1, Narration o2) {
                    return o1.getOrder().compareTo(o2.getOrder());
                }

            });
            for(Narration n : narrations){
                if(n.getItems() != null){
                    StringWriter stringWriter = new StringWriter();
                    VelocityContext velocityContext = new VelocityContext();
                    for(String key : n.getItems().keySet()){
                        velocityContext.put(key, n.getItems().get(key));
                    }
                    if(request.getType().equals("Role")){
                        velocityEngine.mergeTemplate("role_narration.vm", "UTF-8", velocityContext, stringWriter);
                    }
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }

            mv.addObject("narrations", narrations);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        mv.addObject("emailRequest", request);
        mv.addObject("tab", 1);
        return mv;
    }
    
    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public ModelAndView enrolSecond(@ModelAttribute("emailRequest") EmailCreateRequest request) {

        ModelAndView mv = new ModelAndView("email/create");
        try {
            if (request.getType().equals("Role")) {
                String id = request.getId();
                Role role = roleService.getRole(id);
                if (role != null) {
                    if(role.getNarrations() != null){
                        for(Narration n : role.getNarrations()){
                            if(n.getOrder() == request.getNarrationOrder()){
                                mv.addObject("map", n.getItems());
                            }
                        }
                    }
                }
            }
            if (request.getType().equals("Proof")) {

            }
            if (request.getType().equals("Product")) {

            }
            if (request.getType().equals("Proof")) {

            }
            
            ProofSearchRequest psr = new ProofSearchRequest();
            psr.setSize(100);
            ProofSearchResponse psrr = proofService.getProofs(psr);
            if(psrr != null){
                mv.addObject("proofs", psrr.getResult());
            }
            
            SearchPlayRequest spr = new SearchPlayRequest();
            SearchPlayResponse sprr = playService.getPlays(spr);
            if(sprr != null){
                mv.addObject("plays", sprr.getPlays());
            }
            
            SearchMessageRequest smr = new SearchMessageRequest();
            SearchMessageResponse smrr = messageService.getMessages(smr);
            if(smrr != null){
                mv.addObject("messages", smrr.getMessages());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        mv.addObject("emailRequest", request);
        mv.addObject("tab", 2);
        return mv;
    }

}
