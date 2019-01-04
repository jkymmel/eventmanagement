package ee.ttu.idu0230.eventmanagement.event.report;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EventReportRow {
    private Short stateCode;
    private String stateName;
    private Long count;
}
