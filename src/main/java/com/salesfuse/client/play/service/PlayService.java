/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.play.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
import static com.salesfuse.client.common.BaseRestTemplate.getUrl;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.play.model.GetSmallPlayRequest;
import com.salesfuse.client.play.model.GetSmallPlayResponse;
import com.salesfuse.client.play.model.Play;
import com.salesfuse.client.play.model.SearchPlayRequest;
import com.salesfuse.client.play.model.SearchPlayResponse;
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
public class PlayService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Play createUpdate(Play request) throws Exception{        
        Play resp;
        String url= getUrl() + "/api/play/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Play.class);
        return resp;
    }
    
    public Play getPlay(String id) throws Exception{        
        String url= getUrl() + "/api/play/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Play> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Play>() {});
        return response.getBody(); 
    }
    
    
    public SearchPlayResponse getPlays(SearchPlayRequest request) throws Exception{        
        SearchPlayResponse resp;
        String url= getUrl() + "/api/play/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchPlayResponse.class);
        return resp; 
    }
    
    public SearchPlayResponse searchPlay(GlobalSearchRequest request) throws Exception{        
        SearchPlayResponse resp;
        String url= getUrl() + "/api/play/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, SearchPlayResponse.class);
        return resp; 
    }
    
    public GetSmallPlayResponse getSmallPlayList(GetSmallPlayRequest request) throws Exception{        
        GetSmallPlayResponse resp;
        String url= getUrl() + "/api/play/small";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, GetSmallPlayResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/play/delete";
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
