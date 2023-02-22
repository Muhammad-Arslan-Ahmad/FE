/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.payload;


import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author hossain
 */

@Getter
@Setter
public class TokenResponse implements Serializable {
    private Integer userId;
    private String userName;
    private String token;
    private String expiredIn;
    private String role;
    
    public TokenResponse(){
        super();
    }    

}