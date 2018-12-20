package ee.ttu.idu0230.eventmanagement.employee;

import ee.ttu.idu0230.eventmanagement.employee.state.EmployeeState;
import ee.ttu.idu0230.eventmanagement.occupation.Occupation;
import ee.ttu.idu0230.eventmanagement.person.Person;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "tootaja")
public class Employee implements Serializable {
    @Id
    @OneToOne
    @JoinColumn(name = "isik_id", unique = true)
    private Person person;

    @ManyToOne
    @JoinColumn(name = "amet_kood")
    private Occupation occupation;

    @ManyToOne
    @JoinColumn(name = "tootaja_seisundi_liik_kood")
    private EmployeeState state;

    @ManyToOne
    @JoinColumn(name = "juhendaja_id")
    private Employee instructor;
}
