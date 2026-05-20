package com.project.Ticketing.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.Ticketing.model.Seat;

@Repository
public interface SeatRepository extends JpaRepository<Seat, Integer>{
    List<Seat> findByEventId(int EventId);
}
