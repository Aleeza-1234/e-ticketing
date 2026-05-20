package com.project.Ticketing.model;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;
    private String description;
    private String venue;
    private LocalDateTime eventDateTime;
    private double pricePerSeat;

    @ManyToOne
    @JoinColumn(name="organisation_id")
    private Organisation organisation;

    @OneToMany(mappedBy="event")
    private List<Seat> seats;
}