/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.role.service;

import com.google.gson.Gson;
import com.salesfuse.client.common.BaseRestTemplate;
import com.salesfuse.client.common.payload.CommonDeleteRequest;
import com.salesfuse.client.common.payload.CommonDeleteResponse;
import com.salesfuse.client.common.payload.GlobalSearchRequest;
import com.salesfuse.client.role.model.GetSmallRoleRequest;
import com.salesfuse.client.role.model.GetSmallRoleResponse;
import com.salesfuse.client.role.model.Role;
import com.salesfuse.client.role.model.RoleSearchRequest;
import com.salesfuse.client.role.model.RoleSearchResponse;
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
public class RoleService extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public Role createUpdate(Role request) throws Exception{        
        Role resp;
        String url= getUrl() + "/api/role/create-update";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, Role.class);
        return resp;
    }
    
    public Role getRole(String id) throws Exception{        
        String url= getUrl() + "/api/role/"+id;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<Role> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<Role>() {});
        return response.getBody(); 
    }
    
    public GetSmallRoleResponse getSmallRoleList(GetSmallRoleRequest request) throws Exception{        
        GetSmallRoleResponse resp;
        String url= getUrl() + "/api/role/small";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, GetSmallRoleResponse.class);
        return resp; 
    }
    
    public RoleSearchResponse searchRole(GlobalSearchRequest request) throws Exception{        
        RoleSearchResponse resp;
        String url= getUrl() + "/api/role/global-search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, RoleSearchResponse.class);
        return resp; 
    }
    
    public RoleSearchResponse getRoles(RoleSearchRequest request) throws Exception{        
        RoleSearchResponse resp;
        String url= getUrl() + "/api/role/search";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        
        resp = restTemplate.postForObject(url, entity, RoleSearchResponse.class);
        return resp; 
    }
    
    public CommonDeleteResponse delete(CommonDeleteRequest request) throws Exception{        
        CommonDeleteResponse resp;
        String url= getUrl() + "/api/role/delete";
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
