package ee.ttu.idu0230.eventmanagement.security;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.SQLException;

@Service
public class SecurityService {

    @Resource
    private SecurityRepository securityRepository;

    public boolean checkUser(String email, String password) {
        try {
            return securityRepository.checkUser(email, password);
        } catch (SQLException ignored) {
            return false;
        }
    }
}
