package ee.ttu.idu0230.eventmanagement.event;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
public class Event {
    private Integer id;
    private String name;
    private String location;
    private Timestamp startTime;
    private String state;
}
