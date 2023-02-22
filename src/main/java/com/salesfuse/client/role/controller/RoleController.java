/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.role.controller;

import com.salesfuse.client.common.Defs;
import com.salesfuse.client.common.RoleSortColumn;
import com.salesfuse.client.common.SortOrder;
import com.salesfuse.client.common.StatusEnum;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.role.model.GetSmallRoleRequest;
import com.salesfuse.client.role.model.GetSmallRoleResponse;
import com.salesfuse.client.role.model.Narration;
import com.salesfuse.client.role.model.Role;
import com.salesfuse.client.role.model.RoleSearchRequest;
import com.salesfuse.client.role.model.RoleSearchResponse;
import com.salesfuse.client.role.model.SmallRole;
import com.salesfuse.client.role.service.RoleService;
import com.salesfuse.client.util.PagingUtil;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
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
@RequestMapping(path = "/role/")
public class RoleController {

    @Autowired
    RoleService enrolService;
    
    @Autowired
    private VelocityEngine velocityEngine;

    @ModelAttribute("tab")
    public Integer initTab() {
        return 0;
    }

    @ModelAttribute("roleResp")
    public Role initRole() {
        return new Role();
    }

    @ModelAttribute("searchRequest")
    public RoleSearchRequest initSearchRequest() {
        RoleSearchRequest request = new RoleSearchRequest();
        request.setFrom(0);
        request.setSize(Defs.RPP);
        request.setColumn(RoleSortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);
        return request;
    }

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req, @ModelAttribute("tab") Integer tab, @ModelAttribute("roleResp") Role roleResp) {

        ModelAndView mv = new ModelAndView("role/create");
        if (tab == null) {
            tab = 0;
        }
        mv.addObject("tab", tab);
        if (roleResp != null && roleResp.getId() != null && roleResp.getId().length() > 0) {

            mv.addObject("role", roleResp);
        }
        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse resp = enrolService.getSmallRoleList(request);
            if (resp != null && resp.getRoles() != null) {
                roles = resp.getRoles();
            }
        } catch (Exception ex) {
        }
        mv.addObject("roles", roles);
        mv.addObject("role_create_menu", "mm-active");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public Role enrolFirst(@ModelAttribute("Role") Role role) {
        Role roleResp = null;
        try {
            
            if (role.getId() != null && role.getId().length() > 0) {
                roleResp = enrolService.getRole(role.getId());
            } else {
                roleResp = new Role();
            }

            roleResp.setRoleName(role.getRoleName());
            roleResp.setRoleAltitudeLevel(role.getRoleAltitudeLevel());
            roleResp.setJobTitle(role.getJobTitle());
            roleResp.setReportingRole(role.getReportingRole());
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }

    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public Role enrolSecond(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Role roleResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][expectations]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            roleResp = enrolService.getRole(id);
            roleResp.setExpectations(params);
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }
    
    @PostMapping(value = "enrolThird")
    @ResponseBody
    public Role enrolThird(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Role roleResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][painAndGains]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            roleResp = enrolService.getRole(id);
            roleResp.setPainAndGains(params);
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }
    
    @PostMapping(value = "enrolFourth")
    @ResponseBody
    public Role enrolFourth(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Role roleResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][possibilities]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            roleResp = enrolService.getRole(id);
            roleResp.setPossibilities(params);
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }
    
    @PostMapping(value = "enrolFifth")
    @ResponseBody
    public Role enrolFifth(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Role roleResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][impactedWorks]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            roleResp = enrolService.getRole(id);
            roleResp.setImpactedWorks(params);
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }
    
    @PostMapping(value = "enrolSixth")
    public ModelAndView enrolSixth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute, @ModelAttribute("file") MultipartFile file) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/role/home"));
        List<String> hiddenPitfalls = new ArrayList<>();

        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][hiddenPitfalls]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                hiddenPitfalls.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            Role roleResp = enrolService.getRole(id);
            roleResp.setHiddenPitfalls(hiddenPitfalls);
            enrolService.createUpdate(roleResp);
            redirectAttribute.addFlashAttribute("roleResp", roleResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if(hiddenPitfalls.size() == 0){
            redirectAttribute.addFlashAttribute("tab", 5);
        }
        else{
            redirectAttribute.addFlashAttribute("tab", 6);
        }
        return mv;
    }

    @PostMapping(value = "enrolSeventh")
    public ModelAndView enrolSeventh(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute, @ModelAttribute("file") MultipartFile file) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/role/list"));

        List<Narration> statements = new ArrayList<>();

        try {
            for (int i = 0;; i++) {
                
                String key = "inner-group[" + i + "][statement]";
                String itemsName = "inner-group[" + i + "][items]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                Narration n = new Narration();
                n.setNarration(val);
                
                String items = req.getParameter(itemsName);
                if (items != null) {
                    Map<String, String> itemMap = new HashMap<>();
                    String[] vars = items.split(",");
                    if (vars != null) {
                        for (String v : vars) {
                            String[] vals = v.split("=");
                            if (vals != null && vals.length == 2) {
                                itemMap.put(vals[0], vals[1]);
                            }
                        }
                    }
                    n.setItems(itemMap);
                }
                
                String orderKey = "inner-group[" + i + "][position]";
                String orderVal = req.getParameter(orderKey);
                if(orderVal == null || orderVal.length() == 0){
                    n.setOrder(i+1);
                }else{
                    n.setOrder(Integer.parseInt(orderVal));
                }
                statements.add(n);
            }
        } catch (Exception ex) {
        }

        try {
            
            Role roleResp = enrolService.getRole(id);
            roleResp.setNarrations(statements);
            roleResp.setStatus(StatusEnum.COMPLETED.name());
            enrolService.createUpdate(roleResp);
            Thread.sleep(2000);
            redirectAttribute.addFlashAttribute("roleResp", roleResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mv;
    }

    @GetMapping("list")
    public ModelAndView home(@ModelAttribute("searchRequest") RoleSearchRequest request) {

        request.setColumn(RoleSortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);
        
        if (request.getFrom() == null) {
            request.setFrom(0);
        }

        if (request.getSize() == null) {
            request.setSize(Defs.RPP);
        }

        ModelAndView mv = new ModelAndView("role/list");
        List<Role> result = new ArrayList<>();

        RoleSearchResponse resp = null;
        try {
            if (request.getQuery() != null && request.getQuery().length() > 0) {
                GlobalSearchRequest gRequest = new GlobalSearchRequest();
                gRequest.setFrom(request.getFrom());
                gRequest.setSize(request.getSize());
                gRequest.setQuery(request.getQuery());
                resp = enrolService.searchRole(gRequest);
            } else {
                resp = enrolService.getRoles(request);
            }
            if (resp != null && resp.getRoles() != null) {
                result = resp.getRoles();
                PagingUtil paging = new PagingUtil(resp.getTotalCount().intValue(), request.getFrom(), Defs.RPP);
                mv.addObject("results", result);
                mv.addObject("paging", paging.getPagingStr());
                mv.addObject("queryString", request.getQuery());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("request", request);
        mv.addObject("role_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("view")
    public ModelAndView home(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("role/view");
        Role resp = new Role();
        try {
            resp = enrolService.getRole(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        if(resp.getNarrations() != null){
            Collections.sort(resp.getNarrations(), new Comparator<Narration>(){
                @Override
                public int compare(Narration o1, Narration o2) {
                    return o1.getOrder().compareTo(o2.getOrder());
                }
                
            });
            
            for(Narration n : resp.getNarrations()){
                if(n.getItems() != null){
                    StringWriter stringWriter = new StringWriter();
                    VelocityContext velocityContext = new VelocityContext();
                    for(String key : n.getItems().keySet()){
                        velocityContext.put(key, n.getItems().get(key));
                    }
                    velocityEngine.mergeTemplate("role_narration.vm", "UTF-8", velocityContext, stringWriter);
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }
        }
        
        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse roleResp = enrolService.getSmallRoleList(request);
            if (roleResp != null && roleResp.getRoles() != null) {
                roles = roleResp.getRoles();
            }
        } catch (Exception ex) {
        }
        mv.addObject("roles", roles);

        mv.addObject("role", resp);
        mv.addObject("role_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("edit")
    public ModelAndView edit(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("role/create");
        Role resp = new Role();
        try {
            resp = enrolService.getRole(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse roleResp = enrolService.getSmallRoleList(request);
            if (roleResp != null && roleResp.getRoles() != null) {
                roles = roleResp.getRoles();
            }
        } catch (Exception ex) {
        }
        mv.addObject("roles", roles);

        mv.addObject("role", resp);
        mv.addObject("role_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("download")
    public @ResponseBody
    void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {

        Role resp = new Role();
        try {
            resp = enrolService.getRole(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        response.setContentType(resp.getContentType());
        response.setHeader(
                HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=\"" + resp.getFileName() + "\"");
        response.getOutputStream().write(resp.getAttachment());
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }


    @PostMapping(value = "upload")
    @ResponseBody
    public Role upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id) {
        Role roleResp = null;
        try {
            

            if (id != null && id.length() > 0) {
                roleResp = enrolService.getRole(id);
            }

            if (roleResp == null) {
                roleResp = new Role();
            }
            if (file != null && file.getOriginalFilename() != null) {
                roleResp.setAttachment(file.getBytes());
                roleResp.setFileName(file.getOriginalFilename());
            }
            roleResp = enrolService.createUpdate(roleResp);
            return roleResp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return roleResp;
    }
    
    @GetMapping("delete")
    public ResponseEntity<?> delete(@RequestParam("id") String id, HttpServletRequest req) {
        CommonDeleteRequest request = new CommonDeleteRequest();
        request.setId(id);
        try {
            enrolService.delete(request);
            Thread.sleep(2000);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ResponseEntity.ok(true);
    }
    
    @GetMapping(value = "smallRoles")
    @ResponseBody
    public List<SmallRole> smallRoles() {
        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse roleResp = enrolService.getSmallRoleList(request);
            if (roleResp != null && roleResp.getRoles() != null) {
                roles = roleResp.getRoles();
            }
        } catch (Exception ex) {
        }
        return roles;
    }

}
