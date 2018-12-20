package ee.ttu.idu0230.eventmanagement.country;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class CountryService {

    @Resource
    private CountryRepository countryRepository;

    public List<Country> getAll() {
        return (List<Country>) countryRepository.findAll();
    }
}
