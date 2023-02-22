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
public class Address implements Serializable {

    Integer id;
    String street;
    String addressLine1;
    String addressLine2;
    String country;
    String state;
    String city;
    String zip;
    RecordStatus status;

}
