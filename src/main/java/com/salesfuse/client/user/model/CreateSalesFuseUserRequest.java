package com.salesfuse.client.user.model;

import com.salesfuse.client.common.RecordStatus;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateSalesFuseUserRequest implements Serializable {

    String firstName;
    String lastName;
    String phoneNumber;
    String email;
    String userName;
    String password;
    String confirmPassword;
    String temporaryPassword;
    byte[] photo;
    Date passwordExpiryDate;
    String companyName;
    String designation;
    String companyPhone;
    String companyEmail;
    String companyWeb;
    Address companyAddress;
    Address presentAddress;
    Address permanentAddress;
    RecordStatus status;
}
