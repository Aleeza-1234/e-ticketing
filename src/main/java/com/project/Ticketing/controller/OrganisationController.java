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

import com.project.Ticketing.dto.LoginRequest;
import com.project.Ticketing.model.Organisation;
import com.project.Ticketing.service.OrganisationService;


@RestController
public class OrganisationController {
    
    @Autowired
    OrganisationService service;

    @GetMapping("/api/organisations")
    public List<Organisation> getOrganisations() {
        return service.getOrganisations();
    }

    @GetMapping("/api/organisation/{id}")
    public Organisation getOrganisationByID(@PathVariable int id){
        return service.getOrganisationByID(id);
    }

    @PostMapping("/api/organisation")
    public void addOrganisation(@RequestBody Organisation organisation){
        service.addOrganisation(organisation);
    }

    @PutMapping("/api/organisation")
    public void updateOrganisation(@RequestBody Organisation organisation){
        service.update(organisation);
    }

    @DeleteMapping("/api/organisation/{id}")
    public void deleteOrganisation(@PathVariable int id){
        service.delete(id);
    }

    @PostMapping("/api/organisation/login")
    public Organisation organisationLogin(@RequestBody LoginRequest request){
        return service.login(request.getEmail(), request.getPassword());
    }
    
}
