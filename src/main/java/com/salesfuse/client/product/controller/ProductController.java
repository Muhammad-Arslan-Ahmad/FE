/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.product.controller;

import com.salesfuse.client.common.Defs;
import com.salesfuse.client.common.ProductSortColumn;
import com.salesfuse.client.common.SortOrder;
import com.salesfuse.client.common.StatusEnum;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.product.model.Product;
import com.salesfuse.client.product.model.SearchProductRequest;
import com.salesfuse.client.product.model.SearchProductResponse;
import com.salesfuse.client.product.model.SmallProductCategory;
import com.salesfuse.client.product.service.ProductService;
import com.salesfuse.client.role.model.Narration;
import com.salesfuse.client.role.model.Role;
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
@RequestMapping(path = "/product/")
public class ProductController {

    @Autowired
    ProductService enrolService;
    
    @Autowired
    private VelocityEngine velocityEngine;

    @ModelAttribute("tab")
    public Integer initTab() {
        return 0;
    }

    @ModelAttribute("productResp")
    public Product initProduct() {
        return new Product();
    }

    @ModelAttribute("searchRequest")
    public SearchProductRequest initSearchRequest() {
        SearchProductRequest request = new SearchProductRequest();
        request.setFrom(0);
        request.setSize(Defs.RPP);
        request.setColumn(ProductSortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);
        return request;
    }

    @GetMapping("home")
    public ModelAndView home(HttpServletRequest req, @ModelAttribute("tab") Integer tab, @ModelAttribute("productResp") Product productResp) {

        ModelAndView mv = new ModelAndView("product/create");
        if (tab == null) {
            tab = 0;
        }
        mv.addObject("tab", tab);
        if (productResp != null && productResp.getId() != null && productResp.getId().length() > 0) {

            mv.addObject("product", productResp);
        }
        List<SmallProductCategory> categories = new ArrayList<>();
        SmallProductCategory category = new SmallProductCategory("1", "test category");
        categories.add(category);
        mv.addObject("categories", categories);
        mv.addObject("product_create_menu", "mm-active");
        return mv;
    }

    @PostMapping(value = "enrolFirst")
    @ResponseBody
    public Product enrolFirst(@ModelAttribute("Product") Product product) {
        Product productResp = null;
        try {
            
            if (product.getId() != null && product.getId().length() > 0) {
                productResp = enrolService.getProduct(product.getId());
            } else {
                productResp = new Product();
            }
            productResp = enrolService.createUpdate(product);
            return productResp;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
    }

    @PostMapping(value = "enrolSecond")
    @ResponseBody
    public Product enrolSecond(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Product productResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][productFeatures]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            productResp = enrolService.getProduct(id);
            productResp.setProductFeatures(params);
            productResp = enrolService.createUpdate(productResp);
            return productResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
    }
    
    @PostMapping(value = "enrolThird")
    @ResponseBody
    public Product enrolThird(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Product productResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][productBenefits]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            productResp = enrolService.getProduct(id);
            productResp.setProductBenefits(params);
            productResp = enrolService.createUpdate(productResp);
            return productResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
    }
    
    @PostMapping(value = "enrolFourth")
    @ResponseBody
    public Product enrolFourth(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Product productResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][productCapabilities]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            productResp = enrolService.getProduct(id);
            productResp.setProductCapabilities(params);
            productResp = enrolService.createUpdate(productResp);
            return productResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
    }
    
    @PostMapping(value = "enrolFifth")
    @ResponseBody
    public Product enrolFifth(@RequestParam("id") String id, HttpServletRequest req) {
        List<String> params = new ArrayList<>();
        Product productResp = null;
        try {
            for (int i = 0;; i++) {
                String key = "inner-group[" + i + "][productRisks]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            productResp = enrolService.getProduct(id);
            productResp.setProductRisks(params);
            productResp = enrolService.createUpdate(productResp);
            return productResp;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
    }
    
    @PostMapping(value = "enrolSixth")
    public ModelAndView enrolSixth(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute, @ModelAttribute("file") MultipartFile file) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/product/home"));

        List<String> params = new ArrayList<>();

        try {
            for (int i = 0;; i++) {
                
                String key = "inner-group[" + i + "][proofNames]";
                String val = req.getParameter(key);
                if (val == null || val.length() == 0) {
                    break;
                }
                params.add(val);
            }
        } catch (Exception ex) {
        }

        try {
            
            Product productResp = enrolService.getProduct(id);
            productResp.setProofNames(params);
            enrolService.createUpdate(productResp);
            redirectAttribute.addFlashAttribute("productResp", productResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        redirectAttribute.addFlashAttribute("tab", 6);
        
        return mv;
    }
    
    @PostMapping(value = "enrolSeventh")
    public ModelAndView enrolSeventh(@ModelAttribute("id") String id, HttpServletRequest req, final RedirectAttributes redirectAttribute) {
        ModelAndView mv = new ModelAndView(new RedirectView(req.getContextPath() + "/product/list"));

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
            
            Product productResp = enrolService.getProduct(id);
            productResp.setNarrations(statements);
            productResp.setStatus(StatusEnum.COMPLETED.name());
            enrolService.createUpdate(productResp);
            Thread.sleep(2000);
            redirectAttribute.addFlashAttribute("productResp", productResp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mv;
    }

    @GetMapping("list")
    public ModelAndView home(@ModelAttribute("searchRequest") SearchProductRequest request) {

        request.setColumn(ProductSortColumn.CREATED_AT);
        request.setSortOrder(SortOrder.DESC);
        
        if (request.getFrom() == null) {
            request.setFrom(0);
        }

        if (request.getSize() == null) {
            request.setSize(Defs.RPP);
        }

        ModelAndView mv = new ModelAndView("product/list");
        List<Product> result = new ArrayList<>();
        SearchProductResponse resp = null;
        try {
            if (request.getQuery() != null && request.getQuery().length() > 0) {
                GlobalSearchRequest gRequest = new GlobalSearchRequest();
                gRequest.setFrom(request.getFrom());
                gRequest.setSize(request.getSize());
                gRequest.setQuery(request.getQuery());
                resp = enrolService.searchProducts(gRequest);
            } else {
                resp = enrolService.getProducts(request);
            }
            if (resp != null && resp.getProducts() != null) {
                result = resp.getProducts();
                PagingUtil paging = new PagingUtil(resp.getTotalCount().intValue(), request.getFrom(), Defs.RPP);
                mv.addObject("results", result);
                mv.addObject("paging", paging.getPagingStr());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        mv.addObject("request", request);
        mv.addObject("product_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("view")
    public ModelAndView home(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("product/view");
        Product resp = new Product();
        try {
            resp = enrolService.getProduct(id);
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
            
            for(Narration n : resp.getNarrations()){
                if(n.getItems() != null){
                    StringWriter stringWriter = new StringWriter();
                    VelocityContext velocityContext = new VelocityContext();
                    for(String key : n.getItems().keySet()){
                        velocityContext.put(key, n.getItems().get(key));
                    }
                    velocityEngine.mergeTemplate("product_narration.vm", "UTF-8", velocityContext, stringWriter);
                    System.out.println(stringWriter.toString());
                    n.setNarration(stringWriter.toString());
                }
            }
        }
        

        mv.addObject("product", resp);
        mv.addObject("product_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("edit")
    public ModelAndView edit(@RequestParam("id") String id) {

        ModelAndView mv = new ModelAndView("product/create");
        Product resp = new Product();
        try {
            resp = enrolService.getProduct(id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        List<SmallProductCategory> categories = new ArrayList<>();
        SmallProductCategory category = new SmallProductCategory("1", "test category");
        categories.add(category);
        mv.addObject("categories", categories);
        mv.addObject("product", resp);
        mv.addObject("product_list_menu", "mm-active");
        return mv;
    }

    @GetMapping("download")
    public @ResponseBody
    void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {

        Product resp = new Product();
        try {
            resp = enrolService.getProduct(id);
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
    public Product upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id) {
        Product productResp = null;
        try {
            

            if (id != null && id.length() > 0) {
                productResp = enrolService.getProduct(id);
            }

            if (productResp == null) {
                productResp = new Product();
            }
            if (file != null && file.getOriginalFilename() != null) {
                productResp.setAttachment(file.getBytes());
                productResp.setFileName(file.getOriginalFilename());
            }
            productResp = enrolService.createUpdate(productResp);
            return productResp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productResp;
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
