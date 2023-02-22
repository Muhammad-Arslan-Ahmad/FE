/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.message.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
import static com.salesfuse.client.common.BaseRestTemplate.getUrl;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.message.model.Message;
import com.salesfuse.client.message.model.SearchMessageRequest;
import com.salesfuse.client.message.model.SearchMessageResponse;
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
public class MessageService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Message createUpdate(Message request) throws Exception{        
        Message resp;
        String url= getUrl() + "/api/message/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Message.class);
        return resp;
    }
    
    public Message getMessage(String id) throws Exception{        
        String url= getUrl() + "/api/message/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Message> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Message>() {});
        return response.getBody(); 
    }
    
    
    public SearchMessageResponse getMessages(SearchMessageRequest request) throws Exception{        
        SearchMessageResponse resp;
        String url= getUrl() + "/api/message/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchMessageResponse.class);
        return resp; 
    }
    
    public SearchMessageResponse searchMessage(GlobalSearchRequest request) throws Exception{        
        SearchMessageResponse resp;
        String url= getUrl() + "/api/message/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchMessageResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/message/delete";
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
