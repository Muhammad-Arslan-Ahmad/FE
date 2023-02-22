/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.industry.controller;

import com.salesfuse.client.common.Defs;
import com.salesfuse.client.common.IndustrySortColumn;
import com.salesfuse.client.common.SortOrder;
import com.salesfuse.client.common.StatusEnum;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.industry.model.Industry;
import com.salesfuse.client.industry.model.SearchIndustryRequest;
import com.salesfuse.client.industry.model.SearchIndustryResponse;
import com.salesfuse.client.industry.service.IndustryService;
import com.salesfuse.client.role.model.GetSmallRoleRequest;
import com.salesfuse.client.role.model.GetSmallRoleResponse;
import com.salesfuse.client.role.model.Narration;
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
@RequestMapping(path = "/industry/")
public class IndustryController {

    @Autowired
    IndustryService enrolService;

    @Autowired
    RoleService roleService;

    @Autowired
    private VelocityEngine velocityEngine;

    @ModelAttribute("tab")
    public Integer initTab() {
        return 0;
    }

    @ModelAttribute("industryResp")
    public Industry initIndustry() {
        return new Industry();
    }

    @ModelAttribute("searchRequest")
    public SearchIndustryRequest initSearchRequest() {
        SearchIndustryRequest request = new SearchIndustryRequest();
        request.setFrom(0);
        request.setSize(Defs.RPP);

        return request;
    }

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req, @ModelAttribute("tab") Integer tab, @ModelAttribute("industryResp") Industry industryResp) {

        ModelAndView mv = new ModelAndView("industry/create");
        if (tab == null) {
            tab = 0;
        }
        mv.addObject("tab", tab);
        if (industryResp != null && industryResp.getId() != null && industryResp.getId().length() > 0) {

            mv.addObject("industry", industryResp);
        }
        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse resp = roleService.getSmallRoleList(request);
            if (resp != null && resp.getRoles() != null) {
                roles = resp.getRoles();
            }
        } catch (Exception ex) {
        }
        mv.addObject("roles", roles);

        mv.addObject("industry_create_menu", "mm-active");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public Industry enrolFirst(@ModelAttribute("Industry") Industry industry) {
        Industry industryResp = null;
        try {

            if (industry.getId() != null && industry.getId().length() > 0) {
                industryResp = enrolService.getIndustry(industry.getId());
            }

            if (industryResp != null && industryResp.getId() != null && industryResp.getId().length() > 0) {
                industry.setId(industryResp.getId());
            }
            industryResp = enrolService.createUpdate(industry);
            return industryResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return industryResp;
    }

    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public Industry enrolSecond(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Industry industryResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][industryTrends]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            industryResp = enrolService.getIndustry(id);
            industryResp.setIndustryTrends(params);
            industryResp = enrolService.createUpdate(industryResp);
            return industryResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return industryResp;
    }

    @PostMapping(value = "enrolThird")
    public ModelAndView enrolThird(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/industry/home"));

        List<String> params = new ArrayList<>();

        try {
            for (int i = 0;; i++) {

                String key = "inner-group[" + i + "][industryExternalForceImpacts]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {

            Industry industryResp = enrolService.getIndustry(id);
            industryResp.setIndustryExternalForceImpacts(params);
            enrolService.createUpdate(industryResp);
            redirectAttribute.addFlashAttribute("industryResp", industryResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if (params.size() == 0) {
            redirectAttribute.addFlashAttribute("tab", 2);
        } else {
            redirectAttribute.addFlashAttribute("tab", 3);
        }
        return mv;
    }

    @PostMapping(value = "enrolFourth")
    public ModelAndView enrolFourth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/industry/list"));

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
                if (orderVal == null || orderVal.length() == 0) {
                    n.setOrder(i + 1);
                } else {
                    n.setOrder(Integer.parseInt(orderVal));
                }
                statements.add(n);
            }
        } catch (Exception ex) {
        }

        try {

            Industry industryResp = enrolService.getIndustry(id);
            industryResp.setNarrations(statements);
            industryResp.setStatus(StatusEnum.COMPLETED.name());
            enrolService.createUpdate(industryResp);
            Thread.sleep(2000);
            redirectAttribute.addFlashAttribute("industryResp", industryResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mv;
    }

    @GetMapping("list")
    public ModelAndView home(@ModelAttribute("searchRequest") SearchIndustryRequest request) {

        request.setColumn(IndustrySortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);

        if (request.getFrom() == null) {
            request.setFrom(0);
        }

        if (request.getSize() == null) {
            request.setSize(Defs.RPP);
        }

        ModelAndView mv = new ModelAndView("industry/list");
        List<Industry> result = new ArrayList<>();
        SearchIndustryResponse resp = null;
        try {
            if (request.getQuery() != null && request.getQuery().length() > 0) {
                GlobalSearchRequest gRequest = new GlobalSearchRequest();
                gRequest.setFrom(request.getFrom());
                gRequest.setSize(request.getSize());
                gRequest.setQuery(request.getQuery());
                resp = enrolService.searchIndustry(gRequest);
            } else {
                resp = enrolService.getIndustries(request);
            }
            if (resp != null && resp.getIndustries() != null) {
                result = resp.getIndustries();
                PagingUtil paging = new PagingUtil(resp.getTotalCount().intValue(), request.getFrom(), Defs.RPP);
                mv.addObject("results", result);
                mv.addObject("paging", paging.getPagingStr());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("request", request);
        mv.addObject("industry_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("view")
    public ModelAndView home(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("industry/view");
        Industry resp = new Industry();
        try {
            resp = enrolService.getIndustry(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        if (resp.getNarrations() != null) {
            Collections.sort(resp.getNarrations(), new Comparator<Narration>() {
                @Override
                public int compare(Narration o1, Narration o2) {
                    return o1.getOrder().compareTo(o2.getOrder());
                }

            });

            for (Narration n : resp.getNarrations()) {
                if (n.getItems() != null) {
                    StringWriter stringWriter = new StringWriter();
                    VelocityContext velocityContext = new VelocityContext();
                    for (String key : n.getItems().keySet()) {
                        velocityContext.put(key, n.getItems().get(key));
                    }
                    velocityEngine.mergeTemplate("industry_narration.vm", "UTF-8", velocityContext, stringWriter);
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }
        }

        mv.addObject("industry", resp);
        mv.addObject("industry_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("edit")
    public ModelAndView edit(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("industry/create");
        Industry resp = new Industry();
        try {
            resp = enrolService.getIndustry(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        GetSmallRoleRequest request = new GetSmallRoleRequest();
        List<SmallRole> roles = new ArrayList<>();
        try {
            GetSmallRoleResponse roleResp = roleService.getSmallRoleList(request);
            if (roleResp != null && roleResp.getRoles() != null) {
                roles = roleResp.getRoles();
            }
        } catch (Exception ex) {
        }
        mv.addObject("roles", roles);

        mv.addObject("industry", resp);
        mv.addObject("industry_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("download")
    public @ResponseBody
    void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {

        Industry resp = new Industry();
        try {
            resp = enrolService.getIndustry(id);
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
    public Industry upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id) {
        Industry indsutryResp = null;
        try {

            if (id != null && id.length() > 0) {
                indsutryResp = enrolService.getIndustry(id);
            }

            if (indsutryResp == null) {
                indsutryResp = new Industry();
            }
            if (file != null && file.getOriginalFilename() != null) {
                indsutryResp.setAttachment(file.getBytes());
                indsutryResp.setFileName(file.getOriginalFilename());
            }
            indsutryResp = enrolService.createUpdate(indsutryResp);
            return indsutryResp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return indsutryResp;
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

}
