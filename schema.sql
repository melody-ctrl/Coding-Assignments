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


-- Realised I forgot to auto increment tables (rookie mistake. i have to do better. this is such a drag)
-- Can't auto increment customers due to foreign key. have to drop it first then re insert
ALTER TABLE Bookings
DROP FOREIGN KEY bookings_ibfk_2;

-- add auto increment 
ALTER TABLE Customers
MODIFY customer_id INT AUTO_INCREMENT;

-- add foreign key back
ALTER TABLE Bookings
ADD CONSTRAINT bookings_ibfk_2
FOREIGN KEY (customer_id)
REFERENCES Customers(customer_id);

-- Same thing with stylist id.
ALTER TABLE Stylist_Services
DROP FOREIGN KEY stylist_services_ibfk_1;

ALTER TABLE Bookings 
DROP FOREIGN KEY bookings_ibfk_1;

-- add auto increment
ALTER TABLE Stylists
MODIFY stylist_id INT AUTO_INCREMENT;

-- add foreign keys back 
ALTER TABLE Stylist_Services 
ADD CONSTRAINT stylist_services_ibfk_1
FOREIGN KEY (stylist_id)
REFERENCES Stylists(stylist_id);

ALTER TABLE Bookings 
ADD CONSTRAINT bookings_ibfk_1
FOREIGN KEY (stylist_id)
REFERENCES Stylists(stylist_id);

-- never again. I will learn to always remember autoincrement from the start.
-- did all this because i felt like dropping the whole tables was overkill. 
