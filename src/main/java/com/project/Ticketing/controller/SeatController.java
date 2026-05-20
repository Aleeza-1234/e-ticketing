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

import com.project.Ticketing.model.Seat;
import com.project.Ticketing.service.SeatService;


@RestController
public class SeatController {
    
    @Autowired
    SeatService service;

    @GetMapping("/api/seats")
    public List<Seat> getSeats() {
        return service.getSeats();
    }

    @GetMapping("/api/seats-by-event/{id}")
    public List<Seat> getSeatsByEvent(@PathVariable int id) {
        return service.getSeatsByEvent(id);
    }

    @GetMapping("/api/seat/{id}")
    public Seat getSeatByID(@PathVariable int id){
        return service.getSeatByID(id);
    }

    @PostMapping("/api/seat")
    public void addSeat(@RequestBody Seat seat){
        service.addSeat(seat);
    }

    @PutMapping("/api/seat")
    public void updateSeat(@RequestBody Seat seat){
        service.update(seat);
    }

    @DeleteMapping("/api/seat/{id}")
    public void deleteSeat(@PathVariable int id){
        service.delete(id);
    }
    
}
