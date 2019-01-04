package ee.ttu.idu0230.eventmanagement.event.report;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class EventReportController {
    @Resource
    private EventReportService eventReportService;

    @GetMapping("report")
    public String get(Map<String, Object> model) {
        model.put("report", eventReportService.get());
        return "report";
    }
}
