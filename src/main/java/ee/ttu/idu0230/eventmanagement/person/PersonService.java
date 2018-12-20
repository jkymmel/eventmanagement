package ee.ttu.idu0230.eventmanagement.person;

import ee.ttu.idu0230.eventmanagement.event.Event;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class PersonService {

    @Resource
    private PersonRepository personRepository;

    public List<Person> listPeople() {
        return (List<Person>) personRepository.findAll();
    }
}
