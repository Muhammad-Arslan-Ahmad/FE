/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.model;

import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author anwar
 */
@Data
public class UserModel implements Serializable {

    private Integer id;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String status;
    private String role;
}
