/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.user.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import com.salesfuse.client.user.model.CreateSalesFuseUserRequest;
import com.salesfuse.client.user.model.CreateSalesFuseUserResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author hossainul
 */
@Service
public class UserService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public CreateSalesFuseUserResponse createUser(CreateSalesFuseUserRequest request) throws Exception{        
        CreateSalesFuseUserResponse resp;
        String url= getUrl() + "/api/access/user/create";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, CreateSalesFuseUserResponse.class);
        return resp;
    }
    
    
}
