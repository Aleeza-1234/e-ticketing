package com.project.Ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.Ticketing.model.User;
import com.project.Ticketing.repository.UserRepository;

@Service
public class UserService {
   
    @Autowired
    UserRepository repo;
    
    @Autowired
    PasswordEncoder passwordEncoder;

    public List<User> getUsers(){
        return repo.findAll();
    }

    public User getUserByID(int id){
        return repo.findById(id).orElseThrow();
    }

    public void addUser(User user){
        // Encrypt password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        repo.save(user);
    }

    public void update(User user){
        repo.save(user);
    }

    public void delete(int id){
        repo.deleteById(id);
    }
}
