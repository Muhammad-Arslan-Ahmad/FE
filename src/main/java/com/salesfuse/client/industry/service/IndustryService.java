/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.industry.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
import static com.salesfuse.client.common.BaseRestTemplate.getUrl;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.industry.model.GetSmallIndustryRequest;
import com.salesfuse.client.industry.model.GetSmallIndustryResponse;
import com.salesfuse.client.industry.model.Industry;
import com.salesfuse.client.industry.model.SearchIndustryRequest;
import com.salesfuse.client.industry.model.SearchIndustryResponse;
import com.salesfuse.client.proof.model.Proof;
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
public class IndustryService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Industry createUpdate(Industry request) throws Exception{        
        Industry resp;
        String url= getUrl() + "/api/industry/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Industry.class);
        return resp;
    }
    
    public Industry getIndustry(String id) throws Exception{        
        String url= getUrl() + "/api/industry/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Industry> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Industry>() {});
        return response.getBody(); 
    }
    
    
    public SearchIndustryResponse getIndustries(SearchIndustryRequest request) throws Exception{        
        SearchIndustryResponse resp;
        String url= getUrl() + "/api/industry/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchIndustryResponse.class);
        return resp; 
    }
    
    public SearchIndustryResponse searchIndustry(GlobalSearchRequest request) throws Exception{        
        SearchIndustryResponse resp;
        String url= getUrl() + "/api/industry/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchIndustryResponse.class);
        return resp; 
    }
    
    public GetSmallIndustryResponse getSmallIndustryList(GetSmallIndustryRequest request) throws Exception{        
        GetSmallIndustryResponse resp;
        String url= getUrl() + "/api/industry/small";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, GetSmallIndustryResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/industry/delete";
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
