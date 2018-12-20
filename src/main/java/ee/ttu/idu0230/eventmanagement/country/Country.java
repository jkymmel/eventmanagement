package ee.ttu.idu0230.eventmanagement.country;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "riik")
public class Country {
    @Id
    @Column(name = "riik_kood")
    private String code;

    @Column(name = "nimetus")
    private String name;
}
