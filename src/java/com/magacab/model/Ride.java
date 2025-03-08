package com.magacab.model;
import java.math.BigDecimal;



public class Ride {
    private int customerId;
    private int bookingNumber;
    private String pickupLocation;
    private String destination;
    private int distance;
    private int vehicleId;
    private BigDecimal amount;
    private String status;

public Ride(int customerId, int bookingNumber, String pickupLocation, String destination, int distance, int vehicleId, BigDecimal amount, String status) {
    this.customerId = customerId;
    this.bookingNumber = bookingNumber;
    this.pickupLocation = pickupLocation;
    this.destination = destination;
    this.distance = distance;
    this.vehicleId = vehicleId;
    this.amount = amount;
    this.status = status;
}

    // ✅ Getters and Setters (Ensure all fields have them)
    public int getCustomerId() { return customerId; }
    public int getBookingNumber() { return bookingNumber; }
    public String getPickupLocation() { return pickupLocation; }
    public String getDestination() { return destination; }
    public int getDistance() { return distance; }
    public int getVehicleId() { return vehicleId; }
    public BigDecimal getAmount() { return amount; }
    public String getStatus() { return status; }
}
