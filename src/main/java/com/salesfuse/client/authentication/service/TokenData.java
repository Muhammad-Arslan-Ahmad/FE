/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.service;

import lombok.Data;

/**
 *
 * @author hossain
 */
@Data
public class TokenData {
    private String access_token;
    private String refresh_token;
}
