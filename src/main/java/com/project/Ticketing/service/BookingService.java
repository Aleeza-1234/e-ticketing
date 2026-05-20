package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.Booking;
import com.project.Ticketing.repository.BookingRepository;

@Service
public class BookingService {
   
    @Autowired
    BookingRepository repo;

    public List<Booking> getBookings(){
        return repo.findAll();
    }

    public Booking getBookingByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addBooking(Booking booking){
        repo.save(booking);
    }

    public void update(Booking booking){
        repo.save(booking);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
