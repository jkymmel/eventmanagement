package ee.ttu.idu0230.eventmanagement.country;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("country")
public class CountryController {

    @Resource
    private CountryService countryService;

    @GetMapping("")
    public String list(Map<String, Object> model) {
        model.put("countries", countryService.getAll());
        return "countries";
    }
}
