package com.salesfuse.client.user.model;

import com.salesfuse.client.common.RecordStatus;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateAccessRoleRequest implements Serializable {
    
    String roleName;
    RecordStatus status;
}
