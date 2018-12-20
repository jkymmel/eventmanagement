package ee.ttu.idu0230.eventmanagement.occupation;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "amet")
public class Occupation {
    @Id
    @Column(name = "amet_kood")
    private String id;

    @Column(name = "nimetus", unique = true)
    private String name;

    @Column(name = "kirjeldus")
    private String description;
}
