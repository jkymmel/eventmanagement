package ee.ttu.idu0230.eventmanagement.person;

import ee.ttu.idu0230.eventmanagement.country.Country;
import ee.ttu.idu0230.eventmanagement.person.state.PersonState;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "isik")
@Data
public class Person {

    @Id
    @Column(name = "isik_id")
    private Integer id;

    @Column(name = "e_meil")
    private String email;

    @Column(name = "isikukood")
    private String personalCode;

    @ManyToOne
    @JoinColumn(name = "isikukoodi_riik")
    private Country personalCodeCountry;

    @Column(name = "parool")
    private String password;

    @Column(name = "eesnimi")
    private String firstName;

    @Column(name = "perenimi")
    private String lastName;

    @Column(name = "elukoht")
    private String livingPlace;

    @Column(name = "synni_kp")
    private LocalDate dateOfBirth;

    @Column(name = "reg_aeg")
    private LocalDateTime timeOfRegistration;

    @ManyToOne
    @JoinColumn(name = "isiku_seisundi_liik_kood")
    private PersonState personState;

}
