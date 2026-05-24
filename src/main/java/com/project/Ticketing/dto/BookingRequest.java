package com.project.Ticketing.dto;

import java.time.LocalDateTime;

public class BookingRequest {
    private LocalDateTime bookingTime;
    private double totalAmount;
    private int userId;
    private int eventId;
    private int numberOfSeats;

    public LocalDateTime getBookingTime(){
        return bookingTime;
    }

    public void setBookingTime(LocalDateTime bookingTime){
        this.bookingTime = bookingTime;
    }

    public double getTotalAmount(){
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount){
        this.totalAmount = totalAmount;
    }

    public int getUserId(){
        return userId;
    }

    public void setUserId(int userId){
        this.userId = userId;
    }

    public int getEventId(){
        return eventId;
    }

    public void setEventId(int eventId){
        this.eventId = eventId;
    }

    public int getNumberOfSeats(){
        return numberOfSeats;
    }

    public void setNumberOfSeats(int numberOfSeats){
        this.numberOfSeats = numberOfSeats;
    }
}
