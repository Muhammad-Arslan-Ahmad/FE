package com.salesfuse.client.product.model;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SmallProductCategory implements Serializable {

    String id;
    String name;
    
    
}
