package ee.ttu.idu0230.eventmanagement.event;

import lombok.Data;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Entity;

@Data
@Entity
@Immutable
@Subselect()
public class EventDetails {
}
