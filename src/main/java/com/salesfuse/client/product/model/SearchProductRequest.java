package com.salesfuse.client.product.model;


import com.salesfuse.client.common.ProductSortColumn;
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
public class SearchProductRequest implements Serializable {
    Integer from;
    Integer size;
    ProductSortColumn column;
    SortOrder sortOrder;

    String id;
    String query;
}
