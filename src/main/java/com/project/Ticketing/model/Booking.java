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
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private LocalDateTime bookingTime;
    private double totalAmount;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name="event_id")
    private Event event;

    @OneToMany(mappedBy="booking")
    private List<BookingSeat> bookingSeats;

    public void setBookingTime(LocalDateTime bookingTime){
        this.bookingTime = bookingTime;
    }

    public int getId(){
        return id;
    }

    public LocalDateTime getBookingTime(){
        return bookingTime;
    }

    public double getTotalAmount(){
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount){
        this.totalAmount = totalAmount;
    }

    public User getUser(){
        return user;
    }

    public void setUser(User user){
        this.user = user;
    }

    public Event getEvent(){
        return event;
    }

    public void setEvent(Event event){
        this.event = event;
    }

    public List<BookingSeat> getBookingSeats(){
        return bookingSeats;
    }

    public void setBookingSeats(List<BookingSeat> bookingSeats){
        this.bookingSeats = bookingSeats;
    }
}