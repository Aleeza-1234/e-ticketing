package com.project.Ticketing.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.Ticketing.model.BookingSeat;

@Repository
public interface BookingSeatRepository extends JpaRepository<BookingSeat, Integer>{
    
}
