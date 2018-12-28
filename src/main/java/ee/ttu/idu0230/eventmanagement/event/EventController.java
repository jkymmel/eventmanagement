package ee.ttu.idu0230.eventmanagement.event;

import ee.ttu.idu0230.eventmanagement.location.LocationService;
import ee.ttu.idu0230.eventmanagement.util.Message;
import ee.ttu.idu0230.eventmanagement.util.MessageType;
import org.springframework.core.NestedRuntimeException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;

import javax.annotation.Resource;
import javax.validation.Valid;
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

    @PostMapping("events/{id}")
    public String save(@PathVariable Integer id, @Valid @ModelAttribute Event event, Map<String, Object> model) {
        try {
            event.setId(id);
            Event saved = eventService.save(event);
            model.put("event", saved);
            model.put("message", new Message(MessageType.SUCCESS, "Success!", "Event saved!"));
            return "event";
        } catch (NestedRuntimeException e) {
            model.put("event", eventService.get(id));
            model.put("locations", locationService.findAll());
            model.put("message", Message.ofError(e));
            return "eventEdit";
        }
    }
}
