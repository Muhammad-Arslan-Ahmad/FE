/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.service;

import javax.servlet.http.HttpServletRequest;
import org.springframework.security.authentication.AuthenticationDetailsSource;

/**
 *
 * @author Asus
 */
public class CustomAuthenticationDetailSource implements AuthenticationDetailsSource {

    @Override
    public Object buildDetails(Object c) {
        String pass = ((HttpServletRequest)c).getParameter("password");
        ((HttpServletRequest)c).getServletContext().setAttribute("the_pass", pass);
        return pass;
    }
    
}
