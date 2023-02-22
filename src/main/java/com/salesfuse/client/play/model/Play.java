package com.salesfuse.client.play.model;

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
public class Play implements Serializable {

    String id;
    String playName;
    byte[] attachment;
    String fileName;
    String contentType;
    String playBusinessOutcome;
    List<String> playIndustry;
    String playSolutionType;
    String playProductCategory;
    List<String> playProductNames;
    List<String> playRoles;
    String playStartStr;
    String playEndStr;
    List<String> playWinThemes;
    String status;
    List<Narration> narrations;
}
