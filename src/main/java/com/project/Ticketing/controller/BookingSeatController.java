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

import com.project.Ticketing.model.BookingSeat;
import com.project.Ticketing.service.BookingSeatService;


@RestController
public class BookingSeatController {
    
    @Autowired
    BookingSeatService service;

    @GetMapping("/api/bookingSeats")
    public List<BookingSeat> getBookingSeats() {
        return service.getBookingSeats();
    }

    @GetMapping("/api/bookingSeat/{id}")
    public BookingSeat getBookingSeatByID(@PathVariable int id){
        return service.getBookingSeatByID(id);
    }

    @PostMapping("/api/bookingSeat")
    public void addBookingSeat(@RequestBody BookingSeat bookingSeat){
        service.addBookingSeat(bookingSeat);
    }

    @PutMapping("/api/bookingSeat")
    public void updateBookingSeat(@RequestBody BookingSeat bookingSeat){
        service.update(bookingSeat);
    }

    @DeleteMapping("/api/bookingSeat/{id}")
    public void deleteBookingSeat(@PathVariable int id){
        service.delete(id);
    }
    
}
