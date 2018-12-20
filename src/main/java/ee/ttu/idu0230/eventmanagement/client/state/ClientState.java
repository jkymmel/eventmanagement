package ee.ttu.idu0230.eventmanagement.client.state;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "kliendi_seisundi_liik")
public class ClientState {
    @Id
    @Column(name = "kliendi_seisundi_liik_kood")
    private Short id;

    @Column(name = "nimetus", unique = true)
    private String name;
}
