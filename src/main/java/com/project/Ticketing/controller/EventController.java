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

import com.project.Ticketing.model.Event;
import com.project.Ticketing.service.EventService;


@RestController
public class EventController {
    
    @Autowired
    EventService service;

    @GetMapping("/api/events")
    public List<Event> getEvents() {
        return service.getEvents();
    }

    @GetMapping("/api/event/{id}")
    public Event getEventByID(@PathVariable int id){
        return service.getEventByID(id);
    }

    @GetMapping("/api/event-by-organisation/{id}")
    public List<Event> getEventByOrganisationID(@PathVariable int id){
        return service.getEventsByOrganisation(id);
    }

    @PostMapping("/api/event")
    public void addEvent(@RequestBody Event event){
        service.addEvent(event);
    }

    @PutMapping("/api/event")
    public void updateEvent(@RequestBody Event event){
        service.update(event);
    }

    @DeleteMapping("/api/event/{id}")
    public void deleteEvent(@PathVariable int id){
        service.delete(id);
    }
    
}
