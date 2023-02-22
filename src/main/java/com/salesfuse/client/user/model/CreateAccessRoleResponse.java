package com.salesfuse.client.user.model;

import com.salesfuse.client.common.RecordStatus;
import com.salesfuse.client.common.payload.ServiceResponse;
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
public class CreateAccessRoleResponse extends ServiceResponse implements Serializable {

    Integer id;
    String roleName;
    RecordStatus status;

    public CreateAccessRoleResponse(boolean status, String message) {
        super(status, message);
    }

    public CreateAccessRoleResponse(Integer id, String roleName, RecordStatus status) {
        super();
        this.id = id;
        this.roleName = roleName;
        this.status = status;
    }
}
