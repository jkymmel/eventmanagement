package ee.ttu.idu0230.eventmanagement.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeStampFormatter {
    public String format(LocalDateTime unformatted) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yy HH:mm");
        return unformatted.format(formatter);
    }
}
