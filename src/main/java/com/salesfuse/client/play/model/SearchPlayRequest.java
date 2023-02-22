package com.salesfuse.client.play.model;

import com.salesfuse.client.common.PlaySortColumn;
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
public class SearchPlayRequest implements Serializable {

    Integer from;
    Integer size;
    PlaySortColumn column;
    SortOrder sortOrder;

    String id;
    String query;
}
