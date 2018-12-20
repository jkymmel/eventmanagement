package ee.ttu.idu0230.eventmanagement.event;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class EventService {

    @Resource
    private EventRepository eventRepository;

    public List<Event> findAll() {
        return (List<Event>) eventRepository.findAll();
    }

    public Optional<Event> get(Integer id) {
        return eventRepository.findById(id);
    }

    public Event save(Event event) {
        return eventRepository.save(event);
    }
}
