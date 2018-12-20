package ee.ttu.idu0230.eventmanagement.event;

import ee.ttu.idu0230.eventmanagement.location.LocationService;
import ee.ttu.idu0230.eventmanagement.util.Message;
import ee.ttu.idu0230.eventmanagement.util.MessageType;
import ee.ttu.idu0230.eventmanagement.util.TimeStampFormatter;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.HttpClientErrorException;

import javax.annotation.Resource;
import java.util.Map;
import java.util.Optional;

@Controller
public class EventController {

    @Resource
    private EventService eventService;

    @Resource
    private LocationService locationService;

    @GetMapping("")
    public String findAll(Map<String, Object> model) {
        model.put("events", eventService.findAll());
        return "events";
    }

    @GetMapping("events/{id}")
    public String get(@PathVariable Integer id, Map<String, Object> model) {
        Optional<Event> optionalEvent = eventService.get(id);
        if (optionalEvent.isPresent()) {
            model.put("event", optionalEvent.get());
            return "event";
        } else {
            throw new HttpClientErrorException(HttpStatus.NOT_FOUND);
        }

    }

    @GetMapping("events/{id}/edit")
    public String edit(@PathVariable Integer id, Map<String, Object> model) {
        Optional<Event> optionalEvent = eventService.get(id);
        if (optionalEvent.isPresent()) {
            model.put("event", optionalEvent.get());
            model.put("locations", locationService.findAll());
            return "eventEdit";
        } else {
            throw new HttpClientErrorException(HttpStatus.NOT_FOUND);
        }

    }

    @PostMapping("events")
    public String save(@RequestBody Event event, Map<String, Object> model) {
        try {
            Event saved = eventService.save(event);
            model.put("event", saved);
            model.put("message", new Message(MessageType.SUCCESS, "Success!", "Event saved!"));
            return "event";
        } catch (Exception e) {
            model.put("event", event);
            model.put("message", new Message(MessageType.ERROR, "Error!", e.getMessage()));
            return "event";
        }
    }
}
