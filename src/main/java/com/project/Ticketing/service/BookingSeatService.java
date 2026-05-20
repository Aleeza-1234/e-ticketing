package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.BookingSeat;
import com.project.Ticketing.repository.BookingSeatRepository;

@Service
public class BookingSeatService {
   
    @Autowired
    BookingSeatRepository repo;

    public List<BookingSeat> getBookingSeats(){
        return repo.findAll();
    }

    public BookingSeat getBookingSeatByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addBookingSeat(BookingSeat bookingSeat){
        repo.save(bookingSeat);
    }

    public void update(BookingSeat bookingSeat){
        repo.save(bookingSeat);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
