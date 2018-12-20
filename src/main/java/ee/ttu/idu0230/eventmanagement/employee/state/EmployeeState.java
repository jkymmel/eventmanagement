package ee.ttu.idu0230.eventmanagement.employee.state;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "tootaja_seisundi_liik")
public class EmployeeState {
    @Id
    @Column(name = "tootaja_seisundi_liik_kood")
    private Short id;

    @Column(name = "nimetus", unique = true)
    private String name;
}
