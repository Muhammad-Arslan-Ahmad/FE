package com.salesfuse.client.user.model;

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
public class CreateSalesFuseUserResponse extends ServiceResponse implements Serializable {

    Integer id;
    String userName;

    public CreateSalesFuseUserResponse(boolean status, String message) {
        super(status, message);
    }

    public CreateSalesFuseUserResponse(Integer id, String userName) {
        super();
        this.id = id;
        this.userName = userName;
    }
}
