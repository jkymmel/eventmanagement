package ee.ttu.idu0230.eventmanagement.event.details;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class EventDetailsService {
    @Resource
    private EventDetailsRepository eventDetailsRepository;

    public List<EventDetails> getAll() {
        try {
            return eventDetailsRepository.getAll();
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }

    public Optional<EventDetails> findOneById(Integer id) {
        try {
            return eventDetailsRepository.findOneById(id);
        } catch (SQLException e) {
            return Optional.empty();
        }
    }

    public void endEventById(Integer id) {
        try {
            eventDetailsRepository.endEventById(id);
        } catch (SQLException ignored) {
        }
    }
}
