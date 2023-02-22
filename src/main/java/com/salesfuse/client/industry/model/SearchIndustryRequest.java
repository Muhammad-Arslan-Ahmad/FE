package com.salesfuse.client.industry.model;

import com.salesfuse.client.common.IndustrySortColumn;
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
public class SearchIndustryRequest implements Serializable {

    Integer from;
    Integer size;
    IndustrySortColumn column;
    SortOrder sortOrder;

    String id;
    String query;
}
