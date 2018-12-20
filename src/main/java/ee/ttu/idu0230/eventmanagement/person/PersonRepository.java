package ee.ttu.idu0230.eventmanagement.person;

import ee.ttu.idu0230.eventmanagement.event.Event;
import org.springframework.data.repository.CrudRepository;

public interface PersonRepository extends CrudRepository<Person, Integer> {

}
