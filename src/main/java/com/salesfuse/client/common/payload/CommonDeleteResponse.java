package com.salesfuse.client.common.payload;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CommonDeleteResponse extends ServiceResponse implements Serializable {
    boolean status;
    
}
