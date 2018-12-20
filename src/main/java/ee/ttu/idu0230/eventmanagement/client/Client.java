package ee.ttu.idu0230.eventmanagement.client;

import ee.ttu.idu0230.eventmanagement.client.state.ClientState;
import ee.ttu.idu0230.eventmanagement.person.Person;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "klient")
public class Client implements Serializable {
    @Id
    @OneToOne
    @JoinColumn(name = "isik_id", unique = true)
    private Person person;

    @ManyToOne
    @JoinColumn(name = "kliendi_seisundi_liik_kood")
    private ClientState state;

    @Column(name = "on_nous_tylitamisega")
    private Boolean can_be_disturbed;
}
