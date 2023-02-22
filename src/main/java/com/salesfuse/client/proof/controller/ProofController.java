/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.proof.controller;

import com.salesfuse.client.common.Defs;
import com.salesfuse.client.common.StatusEnum;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.product.model.GetSmallProductRequest;
import com.salesfuse.client.product.model.GetSmallProductResponse;
import com.salesfuse.client.product.model.SmallProduct;
import com.salesfuse.client.product.service.ProductService;
import com.salesfuse.client.proof.model.Proof;
import com.salesfuse.client.proof.model.ProofSearchRequest;
import com.salesfuse.client.proof.model.ProofSearchResponse;
import com.salesfuse.client.proof.service.ProofService;
import com.salesfuse.client.role.model.Narration;
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
@RequestMapping(path = "/proof/")
public class ProofController {

    @Autowired
    ProofService enrolService;
    
    @Autowired
    ProductService productService;
    
    @Autowired
    private VelocityEngine velocityEngine;

    @ModelAttribute("tab")
    public Integer initTab() {
        return 0;
    }

    @ModelAttribute("proofResp")
    public Proof initProof() {
        return new Proof();
    }

    @ModelAttribute("searchRequest")
    public ProofSearchRequest initSearchRequest() {
        ProofSearchRequest request = new ProofSearchRequest();
        request.setFrom(0);
        request.setSize(Defs.RPP);
        
        return request;
    }

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req, @ModelAttribute("tab") Integer tab, @ModelAttribute("proofResp") Proof proofResp) {

        ModelAndView mv = new ModelAndView("proof/create");
        if (tab == null) {
            tab = 0;
        }
        mv.addObject("tab", tab);
        if (proofResp != null && proofResp.getId() != null && proofResp.getId().length() > 0) {

            mv.addObject("proof", proofResp);
        }
        
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
        
        mv.addObject("proof_create_menu", "mm-active");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public Proof enrolFirst(@ModelAttribute("Proof") Proof proof) {
        Proof proofResp = null;
        try {
            
            if (proof.getId() != null && proof.getId().length() > 0) {
                proofResp = enrolService.getProof(proof.getId());
            } 
            
            if(proofResp != null && proofResp.getId() != null && proofResp.getId().length() > 0){
                proof.setId(proofResp.getId());
            }
            proofResp = enrolService.createUpdate(proof);
            return proofResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return proofResp;
    }

    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public Proof enrolSecond(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Proof proofResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][customerStories]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            proofResp = enrolService.getProof(id);
            proofResp.setCustomerStories(params);
            proofResp = enrolService.createUpdate(proofResp);
            return proofResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return proofResp;
    }
    
    @PostMapping(value = "enrolThird")
    public ModelAndView enrolSeventh(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute, @ModelAttribute("file") MultipartFile file) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/proof/home"));

        List<String> params = new ArrayList<>();

        try {
            for (int i = 0;; i++) {
                
                String key = "inner-group[" + i + "][customerQuotes]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            
            Proof proofResp = enrolService.getProof(id);
            proofResp.setCustomerQuotes(params);
            enrolService.createUpdate(proofResp);
            redirectAttribute.addFlashAttribute("proofResp", proofResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        redirectAttribute.addFlashAttribute("tab", 3);
        
        
        return mv;
    }
    
    @PostMapping(value = "enrolFourth")
    public ModelAndView enrolFourth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/proof/list"));

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

            Proof proofResp = enrolService.getProof(id);
            proofResp.setNarrations(statements);
            proofResp.setStatus(StatusEnum.COMPLETED.name());
            enrolService.createUpdate(proofResp);
            Thread.sleep(2000);
            redirectAttribute.addFlashAttribute("proofResp", proofResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mv;
    }

    @GetMapping("list")
    public ModelAndView home(@ModelAttribute("searchRequest") ProofSearchRequest request) {

        ModelAndView mv = new ModelAndView("proof/list");
        
//        request.setColumn(PlaySortColumn.CREATED_AT);
//        request.setSortOrder(SortOrder.DESC);
        
        if (request.getFrom() == null) {
            request.setFrom(0);
        }

        if (request.getSize() == null) {
            request.setSize(Defs.RPP);
        }
        
        List<Proof> result = new ArrayList<>();
        ProofSearchResponse resp = null;
        try {
            if (request.getQuery() != null && request.getQuery().length() > 0) {
                GlobalSearchRequest gRequest = new GlobalSearchRequest();
                gRequest.setFrom(request.getFrom());
                gRequest.setSize(request.getSize());
                gRequest.setQuery(request.getQuery());
                resp = enrolService.searchProof(gRequest);
            } else {
                resp = enrolService.getProofs(request);
            }
            if (resp != null && resp.getResult() != null) {
                result = resp.getResult();
                PagingUtil paging = new PagingUtil(resp.getTotalCount().intValue(), request.getFrom(), Defs.RPP);
                mv.addObject("results", result);
                mv.addObject("paging", paging.getPagingStr());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("request", request);
        mv.addObject("proof_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("view")
    public ModelAndView home(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("proof/view");
        Proof respponse = new Proof();
        try {
            respponse = enrolService.getProof(id);
            
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
                    velocityEngine.mergeTemplate("proof_narration.vm", "UTF-8", velocityContext, stringWriter);
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }
        }
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("proof", respponse);
        mv.addObject("proof_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("edit")
    public ModelAndView edit(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("proof/create");
        Proof resp = new Proof();
        try {
            resp = enrolService.getProof(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        GetSmallProductRequest productReq = new GetSmallProductRequest();
        List<SmallProduct> products = new ArrayList<>();
        try {
            GetSmallProductResponse prodResp = productService.getSmallProductList(productReq);
            if (prodResp != null && prodResp.getProducts() != null) {
                products = prodResp.getProducts();
            }
        } catch (Exception ex) {
        }
        mv.addObject("products", products);
        
        mv.addObject("proof", resp);
        mv.addObject("proof_list_menu", "mm-active");
        return mv;
    }
    
    @GetMapping("download")
    public @ResponseBody
    void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {

        Proof resp = new Proof();
        try {
            resp = enrolService.getProof(id);
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
    public Proof upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id) {
        Proof proofResp = null;
        try {

            if (id != null && id.length() > 0) {
                proofResp = enrolService.getProof(id);
            }

            if (proofResp == null) {
                proofResp = new Proof();
            }
            if (file != null && file.getOriginalFilename() != null) {
                proofResp.setAttachment(file.getBytes());
                proofResp.setFileName(file.getOriginalFilename());
            }
            proofResp = enrolService.createUpdate(proofResp);
            return proofResp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return proofResp;
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
