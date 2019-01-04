package ee.ttu.idu0230.eventmanagement.event.report;

import ee.ttu.idu0230.eventmanagement.event.Event;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class EventReportRepository {

    @Resource
    private DataSource dataSource;

    public List<EventReportRow> get() throws SQLException {
        String statement = "SELECT * FROM yrituste_koodaruanne";
        ResultSet resultSet = dataSource.getConnection().prepareStatement(statement).executeQuery();
        List<EventReportRow> report = new ArrayList<>();
        while (resultSet.next()) {
            report.add(new EventReportRow(
                    resultSet.getShort("seisundi_kood"),
                    resultSet.getString("seisund"),
                    resultSet.getLong("arv")
            ));
        }
        return report;
    }
}
