/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.email.model;

import lombok.Data;

/**
 *
 * @author anwar
 */
@Data
public class EmailCreateRequest {
    private String type;
    private String id;
    private Integer narrationOrder;
}
