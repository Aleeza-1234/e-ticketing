package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.Seat;
import com.project.Ticketing.repository.SeatRepository;

@Service
public class SeatService {
   
    @Autowired
    SeatRepository repo;

    public List<Seat> getSeats(){
        return repo.findAll();
    }

    public List<Seat> getSeatsByEvent(int id){
        return repo.findByEventId(id);
    }

    public Seat getSeatByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addSeat(Seat seat){
        repo.save(seat);
    }

    public void update(Seat seat){
        repo.save(seat);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
