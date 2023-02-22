package com.salesfuse.client.industry.model;

import com.salesfuse.client.role.model.Narration;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Industry implements Serializable {

    String id;
    String name;
    byte[] attachment;
    String fileName;
    String contentType;
    String industryExternalForce;
    boolean industryExternalForceEmphasize;
    List<String> industryExternalForceImpacts;
    String industrySelected;
    List<String> industryTrends;
    String industryRoleSelected;
    boolean industryTrendPrioritize;
    String status;
    List<Narration> narrations;
}
