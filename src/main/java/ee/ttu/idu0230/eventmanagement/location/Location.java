package ee.ttu.idu0230.eventmanagement.location;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "asukoht")
public class Location {
    @Id
    @Column(name = "asukoht_kood")
    private String id;

    @Column(name = "aadress")
    private String address;

    @Column(name = "nimetus", unique = true)
    private String name;
}
