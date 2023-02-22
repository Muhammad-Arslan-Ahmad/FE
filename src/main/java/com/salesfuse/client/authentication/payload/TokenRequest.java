package com.salesfuse.client.authentication.payload;

import java.io.Serializable;
import lombok.Data;

@Data
public class TokenRequest implements Serializable {
    private String userName;
    private String password;
    
}
