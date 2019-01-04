package ee.ttu.idu0230.eventmanagement.event.details;

import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class EventDetailsRepository {

    @Resource
    private DataSource dataSource;

    public List<EventDetails> getAll() throws SQLException {
        String statement = "SELECT * FROM yrituse_detailandmed";
        ResultSet resultSet = dataSource.getConnection().prepareStatement(statement).executeQuery();
        List<EventDetails> eventDetailsList = new ArrayList<>();
        while (resultSet.next()) {
            eventDetailsList.add(new EventDetails(
                    resultSet.getInt("yritus_kood"),
                    resultSet.getString("yrituse_nimi"),
                    resultSet.getString("kirjeldus"),
                    resultSet.getTimestamp("algus_aeg"),
                    resultSet.getTimestamp("lopp_aeg"),
                    resultSet.getString("asukoht"),
                    resultSet.getString("aadress"),
                    resultSet.getInt("piletite_arv"),
                    resultSet.getTimestamp("reg_aeg"),
                    resultSet.getString("registreerija"),
                    resultSet.getString("e_meil"),
                    null
            ));
        }
        return eventDetailsList;
    }

    public Optional<EventDetails> findOneById(Integer id) throws SQLException {
        String statement = "SELECT * FROM yrituse_detailandmed WHERE yritus_kood = ? LIMIT 1";
        PreparedStatement preparedStatement = dataSource.getConnection().prepareStatement(statement);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        EventDetails eventDetails = null;
        if (resultSet.next()) {
            eventDetails = new EventDetails(
                    resultSet.getInt("yritus_kood"),
                    resultSet.getString("yrituse_nimi"),
                    resultSet.getString("kirjeldus"),
                    resultSet.getTimestamp("algus_aeg"),
                    resultSet.getTimestamp("lopp_aeg"),
                    resultSet.getString("asukoht"),
                    resultSet.getString("aadress"),
                    resultSet.getInt("piletite_arv"),
                    resultSet.getTimestamp("reg_aeg"),
                    resultSet.getString("registreerija"),
                    resultSet.getString("e_meil"),
                    new ArrayList<>());
            statement = "SELECT * FROM yrituse_kategooriad WHERE yritus_kood = ?";
            preparedStatement = dataSource.getConnection().prepareStatement(statement);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                eventDetails.getCategories().add(resultSet.getString("kategooria"));
            }
            return Optional.of(eventDetails);
        } else {
            return Optional.empty();
        }
    }

    public void endEventById(Integer id) throws SQLException {
        String statement = "SELECT f_lopeta_yritus(?)";
        PreparedStatement preparedStatement = dataSource.getConnection().prepareStatement(statement);
        preparedStatement.setInt(1, id);
        preparedStatement.executeQuery();
    }
}
