package com.project.Ticketing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/user-login")
    public String userLogin() {
        return "user-login";
    }

    @GetMapping("/org-login")
    public String orgLogin() {
        return "org-login";
    }

    @GetMapping("/user-register")
    public String userRegister() {
        return "user-register";
    }

    @GetMapping("/org-register")
    public String orgRegister() {
        return "org-register";
    }

    @GetMapping("/user-dashboard")
    public String userDashboard() {
        return "user-dashboard";
    }

    @GetMapping("/org-dashboard")
    public String orgDashboard() {
        return "org-dashboard";
    }

    @GetMapping("/book-event")
    public String bookEvent() {
        return "book-event";
    }

    @GetMapping("/create-event")
    public String createEvent() {
        return "create-event";
    }

    @GetMapping("/my-bookings")
    public String myBookings() {
        return "my-bookings";
    }
}
