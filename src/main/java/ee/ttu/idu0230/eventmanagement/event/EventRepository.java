package ee.ttu.idu0230.eventmanagement.event;

import ee.ttu.idu0230.eventmanagement.event.details.EventDetails;
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
public class EventRepository {

    @Resource
    private DataSource dataSource;

    public List<Event> getAll() throws SQLException {
        String statement = "SELECT * FROM koik_yritused";
        ResultSet resultSet = dataSource.getConnection().prepareStatement(statement).executeQuery();
        List<Event> eventList = new ArrayList<>();
        while (resultSet.next()) {
            eventList.add(new Event(
                    resultSet.getInt("yritus_kood"),
                    resultSet.getString("yrituse_nimi"),
                    resultSet.getString("asukoht"),
                    resultSet.getTimestamp("algus_aeg"),
                    resultSet.getString("seisund")
            ));
        }
        return eventList;
    }

    public List<Event> getAllActiveOrInactive() throws SQLException {
        String statement = "SELECT * FROM aktiivsed_mitteaktiivsed_yritused";
        ResultSet resultSet = dataSource.getConnection().prepareStatement(statement).executeQuery();
        List<Event> eventList = new ArrayList<>();
        while (resultSet.next()) {
            eventList.add(new Event(
                    resultSet.getInt("yritus_kood"),
                    resultSet.getString("yrituse_nimi"),
                    resultSet.getString("asukoht"),
                    resultSet.getTimestamp("algus"),
                    resultSet.getString("hetke_seisund")
            ));
        }
        return eventList;
    }
}
