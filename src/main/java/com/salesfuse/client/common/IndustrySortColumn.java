package com.salesfuse.client.common;

public enum IndustrySortColumn {
    NAME("name.keyword"),
    CREATED_AT("createdAt");

    private final String value;

    IndustrySortColumn(String value) {
        this.value = value;
    }

    public String getValue() {
        return this.value;
    }
}
