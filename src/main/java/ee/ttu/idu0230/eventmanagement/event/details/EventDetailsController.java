package ee.ttu.idu0230.eventmanagement.event.details;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.HttpClientErrorException;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("events/")
public class EventDetailsController {

    @Resource
    private EventDetailsService eventDetailsService;

    @GetMapping("{id}")
    public String getAll(@PathVariable Integer id, Map<String, Object> model) {
        model.put("event", eventDetailsService.findOneById(id).orElse(null));
        return "eventDetails";
    }

    @PostMapping("{id}/end")
    public String endEventById(@PathVariable Integer id, Map<String, Object> model) {
        eventDetailsService.endEventById(id);
        return "redirect:/activeInactive";
    }
}
