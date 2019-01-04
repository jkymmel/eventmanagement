package ee.ttu.idu0230.eventmanagement.security;

import ee.ttu.idu0230.eventmanagement.event.details.EventDetails;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

@Repository
public class SecurityRepository {

    @Resource
    private DataSource dataSource;

    public boolean checkUser(String email, String password) throws SQLException {
        String statement = "SELECT * FROM f_kontrolli_juhataja(?, ?)";
        PreparedStatement preparedStatement = dataSource.getConnection().prepareStatement(statement);
        preparedStatement.setString(1, email);
        preparedStatement.setString(2, password);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getBoolean(1);
    }
}
