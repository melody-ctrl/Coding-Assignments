CREATE DATABASE travel_tracker;

USE travel_tracker;

CREATE TABLE IF NOT EXISTS trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'planned'
);

ALTER TABLE trips 
DROP COLUMN status,
ADD COLUMN booked BOOLEAN;