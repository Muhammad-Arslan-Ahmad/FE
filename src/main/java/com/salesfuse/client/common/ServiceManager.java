package com.salesfuse.client.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ServiceManager extends BaseRestTemplate {

    @Autowired
    RestTemplate restTemplate;
}
