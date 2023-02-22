package com.salesfuse.client.message.model;

import com.salesfuse.client.role.model.Narration;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Message implements Serializable {

    String id;
    String name;
    byte[] attachment;
    String fileName;
    String contentType;
    String messageProductAlignment;
    String messageRoleAlignment;
    List<String> messageValuePoints;
    boolean messageValueHighlight;
    List<String> messageQuestions;
    boolean messageVeryImportant;
    String messageQuestionType;
    List<String> messageObjections;
    String messageResponseName;
    List<String> messageResponses;
    List<String> messageProblemResolutions;
    String messageWinThemeAlignment;
    String messageIndustryAlignment;
    boolean messageProblemCritical;
    String status;
    List<Narration> narrations;
}
