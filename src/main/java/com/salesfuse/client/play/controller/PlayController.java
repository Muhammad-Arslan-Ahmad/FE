/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.play.controller;

import com.salesfuse.client.common.Defs;
import com.salesfuse.client.common.PlaySortColumn;
import com.salesfuse.client.common.SortOrder;
import com.salesfuse.client.common.StatusEnum;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.industry.model.GetSmallIndustryRequest;
import com.salesfuse.client.industry.model.GetSmallIndustryResponse;
import com.salesfuse.client.industry.model.SmallIndustry;
import com.salesfuse.client.industry.service.IndustryService;
import com.salesfuse.client.play.model.Play;
import com.salesfuse.client.play.model.SearchPlayRequest;
import com.salesfuse.client.play.model.SearchPlayResponse;
import com.salesfuse.client.play.service.PlayService;
import com.salesfuse.client.product.model.GetSmallProductRequest;
import com.salesfuse.client.product.model.GetSmallProductResponse;
import com.salesfuse.client.product.model.SmallProduct;
import com.salesfuse.client.product.service.ProductService;
import com.salesfuse.client.role.model.GetSmallRoleRequest;
import com.salesfuse.client.role.model.GetSmallRoleResponse;
import com.salesfuse.client.role.model.Narration;
import com.salesfuse.client.role.model.Role;
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
@RequestMapping(path = "/play/")
public class PlayController {

    @Autowired
    PlayService enrolService;

    @Autowired
    RoleService roleService;

    @Autowired
    ProductService productService;

    @Autowired
    IndustryService industryService;

    @Autowired
    private VelocityEngine velocityEngine;

    @ModelAttribute("tab")
    public Integer initTab() {
        return 0;
    }

    @ModelAttribute("playResp")
    public Play initPlay() {
        return new Play();
    }

    @ModelAttribute("searchRequest")
    public SearchPlayRequest initSearchRequest() {
        SearchPlayRequest request = new SearchPlayRequest();
        request.setFrom(0);
        request.setSize(Defs.RPP);
        request.setColumn(PlaySortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);
        return request;
    }

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req, @ModelAttribute("tab") Integer tab, @ModelAttribute("playResp") Play playResp) {

        ModelAndView mv = new ModelAndView("play/create");
        if (tab == null) {
            tab = 0;
        }
        mv.addObject("tab", tab);
        if (playResp != null && playResp.getId() != null && playResp.getId().length() > 0) {
            mv.addObject("play", playResp);
        }
        mv.addObject("play_create_menu", "mm-active");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public Play enrolFirst(@ModelAttribute("Play") Play play) {
        Play playResp = null;
        try {

            if (play.getId() != null && play.getId().length() > 0) {
                playResp = enrolService.getPlay(play.getId());
            } else {
                playResp = new Play();
            }
            playResp = enrolService.createUpdate(play);
            return playResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return playResp;
    }

    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public Play enrolSecond(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Play playResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][playProductNames]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            playResp = enrolService.getPlay(id);
            playResp.setPlayProductNames(params);
            playResp = enrolService.createUpdate(playResp);
            return playResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return playResp;
    }

    @PostMapping(value = "enrolThird")
    @ResponseBody
    public Play enrolThird(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Play playResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][playRoles]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            playResp = enrolService.getPlay(id);
            playResp.setPlayRoles(params);
            playResp = enrolService.createUpdate(playResp);
            return playResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return playResp;
    }

    @PostMapping(value = "enrolFourth")
    @ResponseBody
    public Play enrolFourth(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Play playResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][playIndustry]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            playResp = enrolService.getPlay(id);
            playResp.setPlayIndustry(params);
            playResp = enrolService.createUpdate(playResp);
            return playResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return playResp;
    }

    @PostMapping(value = "enrolFifth")
    public ModelAndView enrolFifth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/play/home"));

        List<String> params = new ArrayList<>();

        try {
            for (int i = 0;; i++) {

                String key = "inner-group[" + i + "][playWinThemes]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {

            Play playResp = enrolService.getPlay(id);
            playResp.setPlayWinThemes(params);
            enrolService.createUpdate(playResp);
            redirectAttribute.addFlashAttribute("playResp", playResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if (params.size() == 0) {
            redirectAttribute.addFlashAttribute("tab", 4);
        } else {
            redirectAttribute.addFlashAttribute("tab", 5);
        }
        return mv;
    }

    @PostMapping(value = "enrolSixth")
    public ModelAndView enrolSixth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/play/list"));

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

            Play playResp = enrolService.getPlay(id);
            playResp.setNarrations(statements);
            playResp.setStatus(StatusEnum.COMPLETED.name());
            enrolService.createUpdate(playResp);
            Thread.sleep(2000);
            redirectAttribute.addFlashAttribute("playResp", playResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mv;
    }

    @GetMapping("list")
    public ModelAndView home(@ModelAttribute("searchRequest") SearchPlayRequest request, HttpServletRequest req) {

        request.setColumn(PlaySortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);

        if (request.getFrom() == null) {
            request.setFrom(0);
        }

        if (request.getSize() == null) {
            request.setSize(Defs.RPP);
        }

        ModelAndView mv = new ModelAndView("play/list");
        List<Play> result = new ArrayList<>();
        SearchPlayResponse resp = null;
        try {
            if (request.getQuery() != null && request.getQuery().length() > 0) {
                GlobalSearchRequest gRequest = new GlobalSearchRequest();
                gRequest.setFrom(request.getFrom());
                gRequest.setSize(request.getSize());
                gRequest.setQuery(request.getQuery());
                resp = enrolService.searchPlay(gRequest);
            } else {
                resp = enrolService.getPlays(request);
            }
            if (resp != null && resp.getPlays() != null) {
                result = resp.getPlays();
                PagingUtil paging = new PagingUtil(resp.getTotalCount().intValue(), request.getFrom(), Defs.RPP);
                mv.addObject("results", result);
                mv.addObject("paging", paging.getPagingStr());
                mv.addObject("queryString", request.getQuery());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("request", request);
        mv.addObject("play_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("view")
    public ModelAndView home(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("play/view");
        Play respponse = new Play();
        try {
            respponse = enrolService.getPlay(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        if (respponse.getNarrations() != null) {
            Collections.sort(respponse.getNarrations(), new Comparator<Narration>() {
                @Override
                public int compare(Narration o1, Narration o2) {
                    return o1.getOrder().compareTo(o2.getOrder());
                }

            });
            
            for(Narration n : respponse.getNarrations()){
                if(n.getItems() != null){
                    StringWriter stringWriter = new StringWriter();
                    VelocityContext velocityContext = new VelocityContext();
                    for(String key : n.getItems().keySet()){
                        velocityContext.put(key, n.getItems().get(key));
                    }
                    velocityEngine.mergeTemplate("play_narration.vm", "UTF-8", velocityContext, stringWriter);
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }
        }
        

        mv.addObject("play", respponse);
        mv.addObject("play_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("edit")
    public ModelAndView edit(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("play/create");
        Play response = new Play();
        try {
            response = enrolService.getPlay(id);
        } catch (Exception ex) {
            ex.printStackTrace();
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

        GetSmallProductRequest productReq = new GetSmallProductRequest();
        List<SmallProduct> products = new ArrayList<>();
        try {
            GetSmallProductResponse resp = productService.getSmallProductList(productReq);
            if (resp != null && resp.getProducts() != null) {
                products = resp.getProducts();
            }
        } catch (Exception ex) {
        }
        mv.addObject("products", products);

        GetSmallIndustryRequest industryReq = new GetSmallIndustryRequest();
        List<SmallIndustry> industries = new ArrayList<>();
        try {
            GetSmallIndustryResponse resp = industryService.getSmallIndustryList(industryReq);
            if (resp != null && resp.getIndustries() != null) {
                industries = resp.getIndustries();
            }
        } catch (Exception ex) {
        }
        mv.addObject("industries", industries);

        mv.addObject("play", response);
        mv.addObject("play_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("download")
    public @ResponseBody
    void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {

        Play resp = new Play();
        try {
            resp = enrolService.getPlay(id);
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
    public Play upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id) {
        Play playResp = null;
        try {

            if (id != null && id.length() > 0) {
                playResp = enrolService.getPlay(id);
            }

            if (playResp == null) {
                playResp = new Play();
            }
            if (file != null && file.getOriginalFilename() != null) {
                playResp.setAttachment(file.getBytes());
                playResp.setFileName(file.getOriginalFilename());
            }
            playResp = enrolService.createUpdate(playResp);
            return playResp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return playResp;
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
