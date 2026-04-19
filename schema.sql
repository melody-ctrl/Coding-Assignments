-- Create hairstylist database

-- CREATE DATABASE HairstylistBooking;
USE HairstylistBooking;

-- Create the tables

CREATE TABLE Stylists(
  stylist_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  email VARCHAR(255) UNIQUE,
  -- location VARCHAR(255)
);


CREATE TABLE Customers(
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255),
  email VARCHAR(255) UNIQUE 
);

CREATE TABLE Services(
  service_id INT PRIMARY KEY, 
  service_name VARCHAR(255) NOT NULL,
  description TEXT
);


-- Junction table (many to many relationship between services & stylists. 
-- A stylist can offer many services and a service can be offered by many stylists)

CREATE TABLE Stylist_Services(
  stylist_id INT,
  service_id INT, 
  price DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (stylist_id, service_id), -- composite primary key
  FOREIGN KEY (stylist_id) REFERENCES Stylists(stylist_id),
  FOREIGN KEY (service_id) REFERENCES Services(service_id)
);


CREATE TABLE Bookings(
  booking_id INT PRIMARY KEY, 
  stylist_id INT,
  customer_id INT,
  service_id INT,
  date_booked DATE NOT NULL ,
  appointment_date DATE NOT NULL,
  
  FOREIGN KEY (stylist_id) REFERENCES Stylists(stylist_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (service_id) REFERENCES Services(service_id)
);


-- initially indecisive but decided to have a new row for each day of the week available per stylist. 
-- means more rows of data, but this is more normalised (1NF) than listing all days available in one entry
CREATE TABLE Availability(
  availability_id INT PRIMARY KEY,
  stylist_id INT, 
  day_of_week VARCHAR(9), -- limit to max length of letters in days of week, reduce space for typos
  start_time TIME, 
  end_time TIME
);


-- Realised location column in Stylists table is useless so dropped!
ALTER TABLE Stylists
DROP COLUMN location;


-- Later realised I need to add appointment time as a column to be able to carry out a booking scenario
ALTER TABLE Bookings 
ADD appointment_time TIME;

ALTER TABLE Bookings
MODIFY booking_id INT AUTO_INCREMENT;
