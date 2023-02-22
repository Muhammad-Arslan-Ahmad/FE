package com.salesfuse.client.proof.model;

import com.salesfuse.client.role.model.Narration;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Proof implements Serializable {

    String id;
    String proofName;
    byte[] attachment;
    String fileName;
    String contentType;
    String proofOrganization;
    String proofImpact;
    String productAlignment;
    String proofType;
    String proofTitle;
    String proofAltitude;
    String proofContent;
    String proofLink;
    String proofReferenceableAccount;
    List<String> customerStories;
    List<String> customerQuotes;
    List<Narration> narrations;
    String status;
}
