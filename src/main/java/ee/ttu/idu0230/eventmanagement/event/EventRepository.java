package ee.ttu.idu0230.eventmanagement.event;

import org.springframework.data.repository.CrudRepository;

import java.util.Iterator;

public interface EventRepository extends CrudRepository<Event, Integer> {

    public Iterable<Event> findAllOrOrderByStartTime();
}
