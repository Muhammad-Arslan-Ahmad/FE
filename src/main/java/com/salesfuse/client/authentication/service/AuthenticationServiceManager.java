/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.service;

import com.google.gson.Gson;
import com.salesfuse.client.authentication.model.UserModel;
import com.salesfuse.client.authentication.payload.RegistrationRequest;
import com.salesfuse.client.authentication.payload.RegistrationResponse;
import com.salesfuse.client.authentication.payload.TokenResponse;
import com.salesfuse.client.authentication.payload.TokenRequest;
import com.salesfuse.client.common.BaseRestTemplate;
import static com.salesfuse.client.common.BaseRestTemplate.getToken;
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
public class AuthenticationServiceManager extends BaseRestTemplate{
    @Autowired
    RestTemplate restTemplate;
    
    public TokenResponse login(TokenRequest tokenRequest) throws Exception{        
        TokenResponse tr = new TokenResponse();
        String url= getUrl() + "/api/auth/signin";
        tr = restTemplate.postForObject(url, tokenRequest, TokenResponse.class);
        tr.setUserId(1);
        tr.setRole("ADMIN");
        return tr;
    }
    
    public ChangePasswordResponse changePassword(ChangePasswordRequest request) throws Exception{        
        ChangePasswordResponse tr;
        String url= getUrl()+"/api/auth/changePassword";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        
        Gson gson = new Gson();
        String entityStr = gson.toJson(request);
        
        HttpEntity<String> entity = new HttpEntity<>(entityStr, headers);
        tr = restTemplate.postForObject(url, entity, ChangePasswordResponse.class);
        return tr;
    }
    
    public RegistrationResponse register(RegistrationRequest request) throws Exception{        
        RegistrationResponse tr;
        String url= getUrl()+"/api/auth/register";
        tr = restTemplate.postForObject(url, request, RegistrationResponse.class);
        return tr;
    }
    
    public UserModel userProfile(Integer userId) throws Exception{
        String url= getUrl()+"/api/auth/userProfile/" + userId;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", "Bearer " + getToken());
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<UserModel> response = restTemplate.exchange(url,
        HttpMethod.GET,entity, new ParameterizedTypeReference<UserModel>() {});
        return response.getBody(); 
    }
    
}
