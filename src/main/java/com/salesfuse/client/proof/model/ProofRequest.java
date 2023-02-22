package com.salesfuse.client.proof.model;

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
public class ProofRequest implements Serializable {

    String id;
    String proof;
    String productAlignment;
    String customerStory1;
    String customerStory2;
    String customerStory3;
    String customerQuote1;
    String customerQuote2;
    String customerQuote3;
    String customerQuote4;
}
