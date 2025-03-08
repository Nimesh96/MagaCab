package com.magacab.model;

import java.math.BigDecimal;

public class Vehicle {
    private int vehicleId;
    private String model;
    private String plateNumber;
    private int capacity;
    private BigDecimal pricePerKm;

    public Vehicle(int vehicleId, String model, String plateNumber, int capacity, BigDecimal pricePerKm) {
        this.vehicleId = vehicleId;
        this.model = model;
        this.plateNumber = plateNumber;
        this.capacity = capacity;
        this.pricePerKm = pricePerKm;
    }

    public int getVehicleId() { return vehicleId; }
    public String getModel() { return model; }
    public String getPlateNumber() { return plateNumber; }
    public int getCapacity() { return capacity; }
    public BigDecimal getPricePerKm() { return pricePerKm; }
}
