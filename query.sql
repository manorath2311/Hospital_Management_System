CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

DROP TABLE IF EXISTS MedicalRecords;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Patient;

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT NOT NULL,
    BloodGroup VARCHAR(5),
    medical_history TEXT
);

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    availability VARCHAR(50) NOT NULL
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE
);

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Doctor', 'Receptionist') NOT NULL,
    doctor_id INT UNIQUE, 
    admin_id INT UNIQUE, 
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id) ON DELETE SET NULL
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);


CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    Diagnosis TEXT NOT NULL,
    Prescription TEXT,
    VisitDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL
);

INSERT INTO Patient (name, dob, gender, phone, email, address, BloodGroup, medical_history) VALUES
('John Doe', '1990-05-14', 'Male', '9876543210', 'john.doe@example.com', '123 Elm Street', 'O+', 'No major illnesses'),
('Jane Smith', '1985-09-22', 'Female', '9876543211', 'jane.smith@example.com', '456 Oak Street', 'A-', 'Diabetic'),
('Emily Johnson', '1992-11-10', 'Female', '9876543212', 'emily.johnson@example.com', '789 Pine Street', 'B+', 'Allergic to penicillin'),
('Michael Brown', '1988-03-05', 'Male', '9876543213', 'michael.brown@example.com', '101 Maple Street', 'AB+', 'History of hypertension'),
('Sarah Wilson', '1995-07-18', 'Female', '9876543214', 'sarah.wilson@example.com', '222 Birch Street', 'O-', 'Asthma patient');


INSERT INTO Doctor (name, specialization, phone, email, availability) VALUES
('Dr. Adam White', 'Cardiology', '9876543220', 'adam.white@example.com', '9AM - 5PM'),
('Dr. Laura Green', 'Dermatology', '9876543221', 'laura.green@example.com', '10AM - 4PM'),
('Dr. Kevin Black', 'Neurology', '9876543222', 'kevin.black@example.com', '8AM - 2PM'),
('Dr. Sophia Blue', 'Pediatrics', '9876543223', 'sophia.blue@example.com', '12PM - 6PM'),
('Dr. David Red', 'Orthopedics', '9876543224', 'david.red@example.com', '7AM - 1PM');


INSERT INTO Appointment (patient_id, doctor_id, date, time, status) VALUES
(1, 1, '2025-04-10', '10:30:00', 'Scheduled'),
(2, 2, '2025-04-11', '11:00:00', 'Scheduled'),
(3, 3, '2025-04-12', '12:00:00', 'Completed'),
(4, 4, '2025-04-13', '14:30:00', 'Cancelled'),
(5, 5, '2025-04-14', '16:00:00', 'Scheduled');


INSERT INTO User (username, password, role, doctor_id, admin_id) VALUES
('admin1', 'securepass1', 'Admin', NULL, 1),
('doctor1', 'docpass1', 'Doctor', 1, NULL),
('doctor2', 'docpass2', 'Doctor', 2, NULL),
('receptionist1', 'receppass1', 'Receptionist', NULL, NULL),
('admin2', 'securepass2', 'Admin', NULL, 2);


INSERT INTO Admin (name, email, phone, username, password) VALUES
('Alice Admin', 'alice.admin@example.com', '9876543230', 'aliceadmin', 'adminpass1'),
('Bob Supervisor', 'bob.supervisor@example.com', '9876543231', 'bobsuper', 'adminpass2'),
('Charlie Manager', 'charlie.manager@example.com', '9876543232', 'charliem', 'adminpass3'),
('Diana Director', 'diana.director@example.com', '9876543233', 'dianadir', 'adminpass4'),
('Ethan Executive', 'ethan.executive@example.com', '9876543234', 'ethanexec', 'adminpass5');


INSERT INTO MedicalRecords (patient_id, doctor_id, Diagnosis, Prescription, VisitDate) VALUES
(1, 1, 'High Blood Pressure', 'Prescribed Beta-blockers', '2025-04-10 10:45:00'),
(2, 2, 'Skin Rash', 'Antihistamine cream prescribed', '2025-04-11 11:20:00'),
(3, 3, 'Migraine', 'Painkillers and lifestyle advice', '2025-04-12 12:30:00'),
(4, 4, 'Flu', 'Rest and hydration recommended', '2025-04-13 14:45:00'),
(5, 5, 'Knee Injury', 'Prescribed physiotherapy sessions', '2025-04-14 16:20:00');



-------------------------------------


CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

DROP TABLE IF EXISTS MedicalRecords;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Receptionist;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS User;

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Doctor', 'Receptionist', 'Patient') NOT NULL
);

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT NOT NULL,
    BloodGroup VARCHAR(5),
    medical_history TEXT,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    availability VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Receptionist (
    receptionist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE
);

CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    prescription TEXT,
    visit_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL
);

-- Insert Users
INSERT INTO User (username, password, role) VALUES
('patient1', 'pass1', 'Patient'),
('patient2', 'pass2', 'Patient'),
('patient3', 'pass3', 'Patient'),
('patient4', 'pass4', 'Patient'),
('patient5', 'pass5', 'Patient'),
('doctor1', 'docpass1', 'Doctor'),
('doctor2', 'docpass2', 'Doctor'),
('doctor3', 'docpass3', 'Doctor'),
('doctor4', 'docpass4', 'Doctor'),
('doctor5', 'docpass5', 'Doctor'),
('receptionist1', 'receppass1', 'Receptionist'),
('admin1', 'adminpass1', 'Admin');

-- Insert Patients
INSERT INTO Patient (user_id, name, dob, gender, phone, email, address, BloodGroup, medical_history) VALUES
(1, 'John Doe', '1990-05-14', 'Male', '9876543210', 'john.doe@example.com', '123 Elm Street', 'O+', 'No major illnesses'),
(2, 'Jane Smith', '1985-09-22', 'Female', '9876543211', 'jane.smith@example.com', '456 Oak Street', 'A-', 'Diabetic'),
(3, 'Emily Johnson', '1992-11-10', 'Female', '9876543212', 'emily.johnson@example.com', '789 Pine Street', 'B+', 'Allergic to penicillin'),
(4, 'Michael Brown', '1988-03-05', 'Male', '9876543213', 'michael.brown@example.com', '101 Maple Street', 'AB+', 'History of hypertension'),
(5, 'Sarah Wilson', '1995-07-18', 'Female', '9876543214', 'sarah.wilson@example.com', '222 Birch Street', 'O-', 'Asthma patient');

-- Insert Doctors
INSERT INTO Doctor (user_id, name, specialization, phone, email, availability) VALUES
(6, 'Dr. Adam White', 'Cardiology', '9876543220', 'adam.white@example.com', '9AM - 5PM'),
(7, 'Dr. Laura Green', 'Dermatology', '9876543221', 'laura.green@example.com', '10AM - 4PM'),
(8, 'Dr. Kevin Black', 'Neurology', '9876543222', 'kevin.black@example.com', '8AM - 2PM'),
(9, 'Dr. Sophia Blue', 'Pediatrics', '9876543223', 'sophia.blue@example.com', '12PM - 6PM'),
(10, 'Dr. David Red', 'Orthopedics', '9876543224', 'david.red@example.com', '7AM - 1PM');

-- Insert Receptionist
INSERT INTO Receptionist (user_id, name, email, phone) VALUES
(11, 'Emma Receptionist', 'emma.recep@example.com', '9876543250');

-- Insert Admin
INSERT INTO Admin (user_id, name, email, phone) VALUES
(12, 'Alice Admin', 'alice.admin@example.com', '9876543230');

-- Insert Appointments
INSERT INTO Appointment (patient_id, doctor_id, date, time, status) VALUES
(1, 1, '2025-04-10', '10:30:00', 'Scheduled'),
(2, 2, '2025-04-11', '11:00:00', 'Scheduled'),
(3, 3, '2025-04-12', '12:00:00', 'Completed'),
(4, 4, '2025-04-13', '14:30:00', 'Cancelled'),
(5, 5, '2025-04-14', '16:00:00', 'Scheduled');

-- Insert Medical Records
INSERT INTO MedicalRecords (patient_id, doctor_id, diagnosis, prescription, visit_date) VALUES
(1, 1, 'High Blood Pressure', 'Prescribed Beta-blockers', '2025-04-10 10:45:00'),
(2, 2, 'Skin Rash', 'Antihistamine cream prescribed', '2025-04-11 11:20:00'),
(3, 3, 'Migraine', 'Painkillers and lifestyle advice', '2025-04-12 12:30:00'),
(4, 4, 'Flu', 'Rest and hydration recommended', '2025-04-13 14:45:00'),
(5, 5, 'Knee Injury', 'Prescribed physiotherapy sessions', '2025-04-14 16:20:00');










select User.user_id from user where user.username="$1";