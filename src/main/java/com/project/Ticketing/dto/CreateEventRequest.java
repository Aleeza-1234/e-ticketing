package com.project.Ticketing.dto;

import java.time.LocalDateTime;

public class CreateEventRequest {

    private String title;
    private String description;
    private String venue;
    private LocalDateTime eventDateTime;
    private double pricePerSeat;
    private int organisationId;
    private int numberOfSeats;
}