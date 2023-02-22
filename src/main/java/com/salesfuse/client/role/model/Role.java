/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.role.model;

import java.util.List;
import lombok.Data;

/**
 *
 * @author anwar
 */
@Data
public class Role {
    private String id;
    String roleName;
    String jobTitle;
    String roleAltitudeLevel;
    String reportingRole;
    byte[] attachment;
    String fileName;
    String contentType;
    List<String> expectations;
    List<String> painAndGains;
    List<String> possibilities;
    List<String> impactedWorks;
    List<String> hiddenPitfalls;
    List<Narration> narrations;
    String status;
}
