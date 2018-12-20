package ee.ttu.idu0230.eventmanagement.util;

import lombok.Getter;

public enum MessageType {

    INFO("alert-info"), SUCCESS("alert-success"), ERROR("alert-danger"), WARNING("alert-warning");

    public final String alertType;

    MessageType(String alertType) {
        this.alertType = alertType;
    }
}