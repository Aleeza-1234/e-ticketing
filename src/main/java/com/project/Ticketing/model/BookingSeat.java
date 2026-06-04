package com.project.Ticketing.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class BookingSeat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name="booking_id")
    @JsonIgnore
    private Booking booking;

    @ManyToOne
    @JoinColumn(name="seat_id")
    private Seat seat;

    public int getId(){
        return id;
    }

    public Booking getBooking(){
        return booking;
    }

    public void setBooking(Booking booking){
        this.booking = booking;
    }

    public Seat getSeat(){
        return seat;
    }

    public void setSeat(Seat seat){
        this.seat = seat;
    }
}