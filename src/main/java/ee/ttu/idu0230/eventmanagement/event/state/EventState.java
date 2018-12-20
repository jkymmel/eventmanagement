package ee.ttu.idu0230.eventmanagement.event.state;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "yrituse_seisundi_liik")
public class EventState {
    @Id
    @Column(name = "yrituse_seisundi_liik_kood")
    private Short id;

    @Column(name = "nimetus", unique = true)
    private String name;
}
