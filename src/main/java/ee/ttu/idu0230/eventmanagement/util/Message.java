package ee.ttu.idu0230.eventmanagement.util;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.core.NestedRuntimeException;

@Data
@AllArgsConstructor
public class Message {
    private MessageType type;
    private String title;
    private String text;

    public static Message ofError(NestedRuntimeException exception) {
        return new Message(MessageType.ERROR, "Error!", exception.getMostSpecificCause().getMessage());
    }

    public static Message ofError(RuntimeException exception) {
        return new Message(MessageType.ERROR, "Error!", exception.getMessage());
    }
}
