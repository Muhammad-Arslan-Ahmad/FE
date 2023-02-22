/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.authentication.payload;

import com.salesfuse.client.authentication.model.UserModel;
import java.io.Serializable;
import lombok.Builder;
import lombok.Data;

/**
 *
 * @author anwar
 */
@Data
@Builder
public class RegistrationRequest implements Serializable {
    private UserModel user;
}