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
import com.project.Ticketing.model.User;
import com.project.Ticketing.service.UserService;


@RestController
public class UserController {
    
    @Autowired
    UserService service;

    @GetMapping("/api/users")
    public List<User> getUsers() {
        return service.getUsers();
    }

    @GetMapping("/api/user/{id}")
    public User getUserByID(@PathVariable int id){
        return service.getUserByID(id);
    }

    @PostMapping("/api/user")
    public void addUser(@RequestBody User user){
        service.addUser(user);
    }

    @PutMapping("/api/user")
    public void updateUser(@RequestBody User user){
        service.update(user);
    }

    @DeleteMapping("/api/user/{id}")
    public void deleteUser(@PathVariable int id){
        service.delete(id);
    }

    @PostMapping("/api/user/login")
    public User userLogin(@RequestBody LoginRequest request){
        return service.login(request.getEmail(), request.getPassword());
    }
    
}
