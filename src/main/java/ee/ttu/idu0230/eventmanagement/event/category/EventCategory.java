package ee.ttu.idu0230.eventmanagement.event.category;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import ee.ttu.idu0230.eventmanagement.event.Event;
import ee.ttu.idu0230.eventmanagement.event.category.type.EventCategoryType;
import lombok.Data;
import lombok.Getter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Data
@Entity
@Table(name = "yrituse_kategooria")
public class EventCategory {
    @Id
    @Column(name = "yrituse_kategooria_kood")
    private String id;

    @Column(name = "nimetus")
    private String name;

    @ManyToOne
    @JoinColumn(name = "yrituse_kategooria_tyyp_kood")
    private EventCategoryType type;
}
