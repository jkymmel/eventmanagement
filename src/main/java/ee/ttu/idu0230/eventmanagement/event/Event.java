package ee.ttu.idu0230.eventmanagement.event;

import com.fasterxml.jackson.annotation.JsonBackReference;
import ee.ttu.idu0230.eventmanagement.event.category.EventCategory;
import ee.ttu.idu0230.eventmanagement.event.state.EventState;
import ee.ttu.idu0230.eventmanagement.location.Location;
import ee.ttu.idu0230.eventmanagement.person.Person;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Data
@Entity
@Table(name = "yritus")
public class Event {
    @Id
    @Column(name = "yritus_id")
    private Integer id;

    @Column(name = "nimi")
    private String name;

    @ManyToOne
    @JoinColumn(name = "asukoht_kood")
    private Location location;

    @Column(name = "algus_aeg")
    private LocalDateTime startTime;

    // TODO: add endTime

    @Column(name = "kirjeldus")
    private String description;

    @Column(name = "piletite_arv")
    private Integer ticketsAvailable;

    @ManyToOne
    @JoinColumn(name = "yrituse_seisundi_liik_kood")
    private EventState state;

    @Column(name = "reg_aeg")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "looja_id")
    private Person createdBy;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "yrituse_kategooria_omamine",
            joinColumns = { @JoinColumn(name = "yritus_id") },
            inverseJoinColumns = { @JoinColumn(name = "yrituse_kategooria_kood")}
    )
    private Set<EventCategory> categories = new HashSet<>();
}
