package com.project.Ticketing.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.Ticketing.model.Organisation;

@Repository
public interface OrganisationRepository extends JpaRepository<Organisation, Integer>{
    Organisation findByEmail(String email);
}
