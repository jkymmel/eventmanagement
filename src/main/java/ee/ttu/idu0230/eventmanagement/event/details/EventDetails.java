package ee.ttu.idu0230.eventmanagement.event.details;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
public class EventDetails {
    private Integer id;
    private String name;
    private String description;
    private Timestamp startTime;
    private Timestamp endTime;
    private String location;
    private String address;
    private Integer ticketsAvailable;
    private Timestamp createdAt;
    private String createdBy;
    private String email;
    private List<String> categories;
}
