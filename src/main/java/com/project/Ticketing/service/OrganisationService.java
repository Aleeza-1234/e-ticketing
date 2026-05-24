package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.Organisation;
import com.project.Ticketing.repository.OrganisationRepository;

@Service
public class OrganisationService {
   
    @Autowired
    OrganisationRepository repo;
    
    @Autowired
    PasswordEncoder passwordEncoder;

    public List<Organisation> getOrganisations(){
        return repo.findAll();
    }

    public Organisation getOrganisationByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addOrganisation(Organisation organisation){
        // Encrypt password before saving
        organisation.setPassword(passwordEncoder.encode(organisation.getPassword()));
        repo.save(organisation);
    }

    public void update(Organisation organisation){
        repo.save(organisation);
    }

    public void delete(int id){
        repo.deleteById(id);
    }

    public Organisation login(String email, String password){
        Organisation organisation = repo.findByEmail(email);
        if(organisation != null && passwordEncoder.matches(password, organisation.getPassword())){
            return organisation;
        }
        return null;
    }
}
