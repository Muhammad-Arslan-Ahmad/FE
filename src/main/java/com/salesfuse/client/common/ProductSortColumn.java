package com.salesfuse.client.common;

public enum ProductSortColumn {

    NAME("name.keyword"),
    CREATED_AT("createdAt");

    private final String value;

    ProductSortColumn(String value) {
        this.value = value;
    }

    public String getValue() {
        return this.value;
    }
}
