package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.Event;
import com.project.Ticketing.repository.EventRepository;

@Service
public class EventService {
   
    @Autowired
    EventRepository repo;

    public List<Event> getEvents(){
        return repo.findAll();
    }

    public List<Event> getEventsByOrganisation(int id){
        return repo.findByOrganisationId(id);
    }

    public Event getEventByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addEvent(Event event){
        repo.save(event);
    }

    public void update(Event event){
        repo.save(event);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
