/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.common;

import com.salesfuse.client.authentication.service.CustomUser;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

/**
 * @author hossain
 */
@Component
@PropertySources({
        @PropertySource("classpath:application.properties")})
public class BaseRestTemplate {

    @Autowired
    private Environment env;

    private static String PROTOCOL;


    public static String HOST;


    public static String PORT;

    public static String PATH = "api";

    private static String SERVICE_URL = "";

    private static String FIELD_ATTACHMENT_URL = "";


    @PostConstruct
    void init() {

        PROTOCOL = env.getProperty("api.service.protocol");
        HOST = env.getProperty("api.service.host");
        PORT = env.getProperty("api.service.port");
        PATH = env.getProperty("api.service.context");
        FIELD_ATTACHMENT_URL = env.getProperty("fv.attachment.url");

        if (PORT != null && PORT.length() > 0) {
            SERVICE_URL = PROTOCOL + "://" + HOST + ":" + PORT + "/" + PATH + "/";
        } else {
            SERVICE_URL = PROTOCOL + "://" + HOST + "/" + PATH + "/";
        }

    }

    public static String getUrl() {
        return SERVICE_URL;
    }

    public static String getFieldAttachmentUrl() {
        return FIELD_ATTACHMENT_URL;
    }


    public static String getToken() {
        try {
            CustomUser cUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (cUser != null) {
                return cUser.getToken();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }
    
    public static String getRoleName() {
        try {
            CustomUser cUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (cUser != null) {
                return cUser.getRoleName();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }
}
