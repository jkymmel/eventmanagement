package ee.ttu.idu0230.eventmanagement.event.category.type;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "yrituse_kategooria_tyyp")
public class EventCategoryType {
    @Id
    @Column(name = "yrituse_kategooria_tyyp_kood")
    private String id;

    @Column(name = "nimetus")
    private String name;
}
