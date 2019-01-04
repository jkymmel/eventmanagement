package ee.ttu.idu0230.eventmanagement.event.report;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class EventReportService {

    @Resource
    private EventReportRepository eventReportRepository;

    public List<EventReportRow> get() {
        try {
            return eventReportRepository.get();
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }
}
