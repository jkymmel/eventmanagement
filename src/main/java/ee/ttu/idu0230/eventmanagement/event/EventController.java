package ee.ttu.idu0230.eventmanagement.event;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("")
public class EventController {

    @Resource
    private EventService eventService;

    @GetMapping("")
    public String getAll(Map<String, Object> model) {
        model.put("events", eventService.getAll());
        return "events";
    }

    @GetMapping("activeInactive")
    public String getActiveOrInactive(Map<String, Object> model) {
        model.put("events", eventService.getActiveorInactive());
        return "activeInactiveEvents";
    }
}
