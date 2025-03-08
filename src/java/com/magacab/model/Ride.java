package com.magacab.model;

import java.math.BigDecimal;

public class Ride {
    private int bookingId; // ✅ Primary Key
    private int customerId;
    private int bookingNumber;
    private String pickupLocation;
    private String destination;
    private int distance;
    private int vehicleId;
    private int driverId;
    private BigDecimal amount;
    private String status;
    private String paymentStatus;

    // ✅ Updated Constructor to correctly include `bookingId`
    public Ride(int bookingId, int customerId, int bookingNumber, String pickupLocation,
                String destination, int distance, int vehicleId, int driverId,
                BigDecimal amount, String status, String paymentStatus) {

        this.bookingId = bookingId; // Ensure correct assignment
        this.customerId = customerId;
        this.bookingNumber = bookingNumber;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.distance = distance;
        this.vehicleId = vehicleId;
        this.driverId = driverId;
        this.amount = amount;
        this.status = status;
        this.paymentStatus = paymentStatus;
    }

    // ✅ Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(int bookingNumber) { this.bookingNumber = bookingNumber; }

    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public int getDistance() { return distance; }
    public void setDistance(int distance) { this.distance = distance; }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }

    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}