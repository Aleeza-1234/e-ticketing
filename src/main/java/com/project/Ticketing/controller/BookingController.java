package com.project.Ticketing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.Ticketing.dto.BookingRequest;
import com.project.Ticketing.model.Booking;
import com.project.Ticketing.service.BookingService;


@RestController
public class BookingController {
    
    @Autowired
    BookingService service;

    @GetMapping("/api/bookings")
    public List<Booking> getBookings() {
        return service.getBookings();
    }

    @GetMapping("/api/booking/{id}")
    public Booking getBookingByID(@PathVariable int id){
        return service.getBookingByID(id);
    }

    @PostMapping("/api/booking")
    public void addBooking(@RequestBody BookingRequest booking){
        service.addBooking(booking);
    }

    @PutMapping("/api/booking")
    public void updateBooking(@RequestBody Booking booking){
        service.update(booking);
    }

    @DeleteMapping("/api/booking/{id}")
    public void deleteBooking(@PathVariable int id){
        service.delete(id);
    }
    
}
