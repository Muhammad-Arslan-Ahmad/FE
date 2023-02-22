package com.salesfuse.client.product.model;

import com.salesfuse.client.common.payload.ServiceResponse;
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
public class GetSmallProductResponse extends ServiceResponse implements Serializable {

    List<SmallProduct> products;
    Long totalCount;

    public GetSmallProductResponse(boolean status, String message) {
        super(status, message);
    }

    public GetSmallProductResponse(List<SmallProduct> products, Long totalCount) {
        super();
        this.products = products;
        this.totalCount = totalCount;
    }
}
