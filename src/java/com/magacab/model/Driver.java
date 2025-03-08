package com.magacab.model;

public class Driver {
    private int driverId;
    private String name;
    private String nic;
    private String phone;
    private String licenseNumber;
    private int vehicleId;

    // ✅ Default Constructor (For flexibility)
    public Driver() {}

    // ✅ Parameterized Constructor
    public Driver(int driverId, String name, String nic, String phone, String licenseNumber, int vehicleId) {
        this.driverId = driverId;
        this.name = name;
        this.nic = nic;
        this.phone = phone;
        this.licenseNumber = licenseNumber;
        this.vehicleId = vehicleId;
    }

    // ✅ Constructor without driverId (For inserting new records)
    public Driver(String name, String nic, String phone, String licenseNumber, int vehicleId) {
        this.name = name;
        this.nic = nic;
        this.phone = phone;
        this.licenseNumber = licenseNumber;
        this.vehicleId = vehicleId;
    }

    // ✅ Getters and Setters
    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }

    // ✅ Debugging: Override toString() for easier logging
    @Override
    public String toString() {
        return "Driver{" +
                "driverId=" + driverId +
                ", name='" + name + '\'' +
                ", nic='" + nic + '\'' +
                ", phone='" + phone + '\'' +
                ", licenseNumber='" + licenseNumber + '\'' +
                ", vehicleId=" + vehicleId +
                '}';
    }
}