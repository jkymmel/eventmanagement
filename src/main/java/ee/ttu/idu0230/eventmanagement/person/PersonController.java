package ee.ttu.idu0230.eventmanagement.person;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/people")
public class PersonController {

    @Resource
    private PersonService personService;

    @GetMapping("")
    public String hello(Map<String, Object> model) {
        model.put("people", personService.listPeople());
        return "people";
    }
}
