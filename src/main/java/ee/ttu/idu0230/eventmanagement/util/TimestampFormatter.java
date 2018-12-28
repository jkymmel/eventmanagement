package ee.ttu.idu0230.eventmanagement.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimestampFormatter {
    public static String format(LocalDateTime unformatted) {
        if (unformatted == null) {
            return "N/A";
        } else {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yy HH:mm");
            return unformatted.format(formatter);
        }
    }

    public static String format() {
        return "N/A";
    }

    public static String format(Object ignored) {
        return "N/A";
    }
}
