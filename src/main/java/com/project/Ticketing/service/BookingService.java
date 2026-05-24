package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Ticketing.dto.BookingRequest;
import com.project.Ticketing.model.Booking;
import com.project.Ticketing.model.BookingSeat;
import com.project.Ticketing.model.Seat;
import com.project.Ticketing.repository.BookingRepository;
import com.project.Ticketing.repository.UserRepository;
import com.project.Ticketing.repository.EventRepository;
import com.project.Ticketing.repository.SeatRepository;
import com.project.Ticketing.repository.BookingSeatRepository;

@Service
public class BookingService {
   
    @Autowired
    BookingRepository repo;

    @Autowired
    UserRepository user;

    @Autowired
    EventRepository event;

    @Autowired
    SeatRepository seatRepo;

    @Autowired
    BookingSeatRepository bookingSeatRepo;

    public List<Booking> getBookings(){
        return repo.findAll();
    }

    public Booking getBookingByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addBooking(BookingRequest bookingRequest){
        Booking booking = new Booking();
        booking.setBookingTime(bookingRequest.getBookingTime());
        booking.setTotalAmount(bookingRequest.getTotalAmount());
        booking.setUser(user.findById(bookingRequest.getUserId()).orElseThrow());
        booking.setEvent(event.findById(bookingRequest.getEventId()).orElseThrow());
        
        Booking savedBooking = repo.save(booking);
        
        // Get available seats and book them
        List<Seat> availableSeats = seatRepo.findByEventId(bookingRequest.getEventId());
        int count = 0;
        for(Seat seat : availableSeats){
            if(count >= bookingRequest.getNumberOfSeats()) break;
            if("AVAILABLE".equals(seat.getStatus())){
                seat.setStatus("BOOKED");
                seatRepo.save(seat);
                
                BookingSeat bookingSeat = new BookingSeat();
                bookingSeat.setBooking(savedBooking);
                bookingSeat.setSeat(seat);
                bookingSeatRepo.save(bookingSeat);
                
                count++;
            }
        }
    }

    public void update(Booking booking){
        repo.save(booking);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
