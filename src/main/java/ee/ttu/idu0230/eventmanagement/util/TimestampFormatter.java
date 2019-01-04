package ee.ttu.idu0230.eventmanagement.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimestampFormatter {

    private static SimpleDateFormat timestampFormat = new SimpleDateFormat("dd.MM.yy HH:mm");

    public static String format(Timestamp unformatted) {
        if (unformatted == null) {
            return "N/A";
        } else {
            return timestampFormat.format(unformatted);
        }
    }

    public static String format() {
        return "N/A";
    }

    public static String format(Object ignored) {
        return "N/A";
    }
}
