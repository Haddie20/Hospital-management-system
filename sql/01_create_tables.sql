-- Script 1: Database and Table creation
-- Database: MySQL

CREATE DATABASE Hospital_Management_System;

USE Hospital_Management_System;

CREATE TABLE Patient (
    PatientID CHAR(6) PRIMARY KEY,
    FirstName VARCHAR(28) NOT NULL,
    LastName VARCHAR(29) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(6),
    Address VARCHAR(50),
    PhoneNumber CHAR(10),
    Email VARCHAR(26) UNIQUE,
    BloodGroup CHAR(3),
    EmergencyContact CHAR(10)
);

CREATE TABLE Department (
    DepartmentID CHAR(10) PRIMARY KEY,
    DepartmentName VARCHAR(35) NOT NULL,
    Location VARCHAR(40)
);

CREATE TABLE Doctor (
    DoctorID CHAR(7) PRIMARY KEY,
    FirstName VARCHAR(26) NOT NULL,
    LastName VARCHAR(27) NOT NULL,
    Specialization VARCHAR(80),
    PhoneNumber CHAR(10),
    Email VARCHAR(25) UNIQUE,
    DepartmentID CHAR(10),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment (
    AppointmentID CHAR(10) PRIMARY KEY,
    PatientID CHAR(6),
    DoctorID CHAR(7),
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE MedicalRecord (
    RecordID VARCHAR(20) PRIMARY KEY,
    Diagnosis VARCHAR(200),
    Treatment VARCHAR(150),
    Prescription VARCHAR(100),
    RecordDate DATE,
    PatientID CHAR(6),
    DoctorID CHAR(7),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Admission (
    AdmissionID CHAR(10) PRIMARY KEY,
    RoomNumber CHAR(10),
    AdmissionDate DATE,
    DischargeDate DATE,
    PatientID CHAR(6),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Billing (
    BillID VARCHAR(20) PRIMARY KEY,
    Amount DECIMAL(10,2),
    BillingDate DATE,
    PaymentStatus VARCHAR(15),
    PatientID CHAR(6),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Payment (
    PaymentID VARCHAR(20) PRIMARY KEY,
    PaymentDate DATE,
    PaymentMethod VARCHAR(10),
    AmountPaid DECIMAL(10,2),
    BillID VARCHAR(20),
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);
