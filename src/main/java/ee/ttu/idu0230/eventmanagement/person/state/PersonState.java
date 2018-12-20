package ee.ttu.idu0230.eventmanagement.person.state;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "isiku_seisundi_liik")
@Data
public class PersonState {
    @Id
    @Column(name = "isiku_seisundi_liik_kood")
    private Short id;

    @Column(name = "nimetus")
    private String name;
}
