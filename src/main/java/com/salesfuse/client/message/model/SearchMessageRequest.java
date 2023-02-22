package com.salesfuse.client.message.model;


import com.salesfuse.client.common.MessageSortColumn;
import com.salesfuse.client.common.SortOrder;
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
public class SearchMessageRequest implements Serializable {

    Integer from;
    Integer size;
    MessageSortColumn column;
    SortOrder sortOrder;

    String id;
    String query;
}
