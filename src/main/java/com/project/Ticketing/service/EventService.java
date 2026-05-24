package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.dto.CreateEventRequest;
import com.project.Ticketing.model.Event;
import com.project.Ticketing.model.Organisation;
import com.project.Ticketing.model.Seat;
import com.project.Ticketing.repository.EventRepository;
import com.project.Ticketing.repository.OrganisationRepository;
import com.project.Ticketing.repository.SeatRepository;

@Service
public class EventService {
   
    @Autowired
    EventRepository repo;
    
    @Autowired
    OrganisationRepository organisationRepo;
    
    @Autowired
    SeatRepository seatRepo;

    public List<Event> getEvents(){
        return repo.findAll();
    }

    public List<Event> getEventsByOrganisation(int id){
        return repo.findByOrganisationId(id);
    }

    public Event getEventByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addEvent(CreateEventRequest eventRequest){
        Event event = new Event();
        event.setTitle(eventRequest.getTitle());
        event.setDescription(eventRequest.getDescription());
        event.setVenue(eventRequest.getVenue());
        event.setEventDateTime(eventRequest.getEventDateTime());
        event.setPricePerSeat(eventRequest.getPricePerSeat());
        
        Organisation organisation = organisationRepo.findById(eventRequest.getOrganisationId()).orElseThrow();
        event.setOrganisation(organisation);
        
        Event savedEvent = repo.save(event);
        
        for(int i = 1; i <= eventRequest.getNumberOfSeats(); i++){
            Seat seat = new Seat();
            seat.setSeatNumber("S" + i);
            seat.setStatus("AVAILABLE");
            seat.setEvent(savedEvent);
            seatRepo.save(seat);
        }
    }

    public void update(Event event){
        repo.save(event);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
