/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.product.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
import static com.salesfuse.client.common.BaseRestTemplate.getUrl;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.product.model.GetSmallProductRequest;
import com.salesfuse.client.product.model.GetSmallProductResponse;
import com.salesfuse.client.product.model.Product;
import com.salesfuse.client.product.model.SearchProductRequest;
import com.salesfuse.client.product.model.SearchProductResponse;
import com.salesfuse.client.role.model.GetSmallRoleResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author hossainul
 */
@Service
public class ProductService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Product createUpdate(Product request) throws Exception{        
        Product resp;
        String url= getUrl() + "/api/product/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Product.class);
        return resp;
    }
    
    public Product getProduct(String id) throws Exception{        
        String url= getUrl() + "/api/product/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Product> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Product>() {});
        return response.getBody(); 
    }
    
    
    public SearchProductResponse getProducts(SearchProductRequest request) throws Exception{        
        SearchProductResponse resp;
        String url= getUrl() + "/api/product/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchProductResponse.class);
        return resp; 
    }
    
    public SearchProductResponse searchProducts(GlobalSearchRequest request) throws Exception{        
        SearchProductResponse resp;
        String url= getUrl() + "/api/product/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchProductResponse.class);
        return resp; 
    }
    
    public GetSmallProductResponse getSmallProductList(GetSmallProductRequest request) throws Exception{        
        GetSmallProductResponse resp;
        String url= getUrl() + "/api/product/small";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, GetSmallProductResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/product/delete";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, CommonDeleteResponse.class);
        return resp; 
    }
    
}
