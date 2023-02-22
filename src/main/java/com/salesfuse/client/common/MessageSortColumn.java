package com.salesfuse.client.common;

public enum MessageSortColumn {

    NAME("name.keyword"),
    CREATED_AT("createdAt");

    private final String value;

    MessageSortColumn(String value) {
        this.value = value;
    }

    public String getValue() {
        return this.value;
    }
}
