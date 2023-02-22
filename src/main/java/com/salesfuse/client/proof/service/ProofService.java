/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.proof.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
import static com.salesfuse.client.common.BaseRestTemplate.getUrl;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.proof.model.Proof;
import com.salesfuse.client.proof.model.ProofSearchRequest;
import com.salesfuse.client.proof.model.ProofSearchResponse;
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
public class ProofService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Proof createUpdate(Proof request) throws Exception{        
        Proof resp;
        String url= getUrl() + "/api/proof/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Proof.class);
        return resp;
    }
    
    public Proof getProof(String id) throws Exception{        
        String url= getUrl() + "/api/proof/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Proof> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Proof>() {});
        return response.getBody(); 
    }
    
    
    public ProofSearchResponse getProofs(ProofSearchRequest request) throws Exception{        
        ProofSearchResponse resp;
        String url= getUrl() + "/api/proof/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, ProofSearchResponse.class);
        return resp; 
    }
    
    public ProofSearchResponse searchProof(GlobalSearchRequest request) throws Exception{        
        ProofSearchResponse resp;
        String url= getUrl() + "/api/proof/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, ProofSearchResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/proof/delete";
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
