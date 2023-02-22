package com.salesfuse.client.play.model;

import com.salesfuse.client.common.payload.ServiceResponse;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateUpdatePlayResponse extends ServiceResponse implements Serializable {

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
    Date playStart;
    Date playEnd;
    List<String> playWinThemes;
    Date createdAt;
    String status;

    public CreateUpdatePlayResponse(boolean status, String message) {
        super(status, message);
    }

    public CreateUpdatePlayResponse(Play play) {
        if(play != null) {
            this.id = play.getId();
            this.playName = play.getPlayName();
            this.attachment = play.getAttachment();
            this.fileName = play.getFileName();
            this.contentType = play.getContentType();
            this.playBusinessOutcome = play.getPlayBusinessOutcome();
            this.playIndustry = play.getPlayIndustry();
            this.playSolutionType = play.getPlaySolutionType();
            this.playProductCategory = play.getPlayProductCategory();
            this.playProductNames = play.getPlayProductNames();
            this.playRoles = play.getPlayRoles();
            this.playWinThemes = play.getPlayWinThemes();
            this.status = play.getStatus();
        }
    }
}
