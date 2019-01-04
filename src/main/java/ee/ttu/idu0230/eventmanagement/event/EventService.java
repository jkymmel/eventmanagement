package ee.ttu.idu0230.eventmanagement.event;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class EventService {

    @Resource
    private EventRepository eventRepository;

    public List<Event> getAll() {
        try {
            return eventRepository.getAll();
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }

    public List<Event> getActiveorInactive() {
        try {
            return eventRepository.getAllActiveOrInactive();
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }
}
