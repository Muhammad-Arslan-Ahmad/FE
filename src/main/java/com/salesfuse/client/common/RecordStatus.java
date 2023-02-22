package com.salesfuse.client.common;

public enum RecordStatus {

    ACTIVE(1),
    INACTIVE(0);

    private final Integer value;

    RecordStatus(Integer value) {
        this.value = value;
    }

    public Integer getValue() {
        return this.value;
    }

    public static RecordStatus getStatus(Integer value) {
        for (RecordStatus status : RecordStatus.values()) {
            if (status.value == value) {
                return status;
            }
        }
        return RecordStatus.ACTIVE;
    }
}
