-- POPULATING THE TABLES

USE HairstylistBooking;

-- Stylists
INSERT INTO Stylists (stylist_id, name, email) VALUES
(1, 'StyledbyOlivia', 'olivia.bennett@example.com'),
(2, 'MimiCuts', 'mimicuts@example.com'),
(3, 'HairGirl', 'hairgirl@example.com'),
(4, 'AfroTamer', 'tamer@example.com'),
(5, 'LacedbyReb', 'RebLaced@example.com'),
(6, 'LaidnSlicked', 'laidnslickedr@example.com'),
(7, 'blackhairldn', 'blackhairldns@example.com'),
(8, 'MoyinBraids', 'moyinBraids@example.com');

-- Customers
INSERT INTO Customers (customer_id, first_name, last_name, email) VALUES
(1, 'Emily', 'Watson', 'emily.watson@example.com'),
(2, 'Mel', 'Evans', 'mel.evans@example.com'),
(3, 'Chloe', 'Ward', 'chloe.ward@example.com'),
(4, 'Sheila', 'Morris', 'sheila.morris@example.com'),
(5, 'Grace', 'Cooper', 'grace.cooper@example.com'),
(6, 'Keriley', 'Bailey', 'rileybailey@example.com'),
(7, 'Lily', 'Richardson', 'lily.richardson@example.com'),
(8, 'Simi', 'Cox', 'simicox@example.com');

-- Services
INSERT INTO Services (service_id, service_name, description) VALUES
(1, 'Haircut', 'Basic haircut and styling'),
(2, 'Wig Install', 'Closure or Frontal install and styling'),
(3, 'Highlights', 'Partial or full highlights'),
(4, 'Blow Dry', 'Professional blow dry and finish'),
(5, 'Keratin Treatment', 'Smoothing keratin treatment'),
(6, 'Hair Extensions', 'Application of hair extensions'),
(7, 'Knotless braids', 'Shoulder length and no knots'),
(8, 'Bridal Styling', 'Special occasion or bridal hair styling');

INSERT INTO Stylist_Services (stylist_id, service_id, price) VALUES
-- StyledbyOlivia
(1, 1, 35.00),
(1, 4, 25.00),
(1, 8, 120.00),

-- MimiCuts
(2, 1, 30.00),
(2, 2, 70.00),
(2, 4, 20.00),

-- HairGirl
(3, 2, 65.00),
(3, 3, 75.00),
(3, 5, 90.00),

-- AfroTamer
(4, 7, 80.00),
(4, 5, 85.00),
(4, 4, 25.00),

-- LacedbyReb
(5, 6, 150.00),
(5, 2, 80.00),
(5, 8, 130.00),

-- LaidnSlicked
(6, 4, 30.00),
(6, 2, 80.00),
(6, 1, 28.00),

-- blackhairldn
(7, 7, 75.00),
(7, 6, 140.00),

-- MoyinBraids
(8, 7, 80.00),
(8, 1, 30.00);



INSERT INTO Bookings (booking_id, stylist_id, customer_id, service_id, date_booked, appointment_date) VALUES
(1, 1, 1, 1, '2026-04-01', '2026-04-20'),
(2, 2, 2, 2, '2026-04-02', '2026-04-21'),
(3, 3, 3, 3, '2026-04-03', '2026-04-22'),
(4, 4, 4, 7, '2026-04-04', '2026-04-23'),
(5, 5, 5, 6, '2026-04-05', '2026-04-24'),
(6, 6, 6, 4, '2026-04-06', '2026-04-25'),
(7, 7, 7, 7, '2026-04-07', '2026-04-25'),
(8, 8, 8, 7, '2026-04-08', '2026-04-26');



INSERT INTO Availability (availability_id, stylist_id, day_of_week, start_time, end_time) VALUES
(1, 1, 'Monday', '09:00:00', '17:00:00'),
(2, 2, 'Tuesday', '10:00:00', '18:00:00'),
(3, 3, 'Wednesday', '09:00:00', '17:00:00'),
(4, 4, 'Thursday', '11:00:00', '19:00:00'),
(5, 5, 'Friday', '09:00:00', '16:00:00'),
(6, 6, 'Saturday', '08:00:00', '14:00:00'),
(7, 7, 'Saturday', '10:00:00', '15:00:00'),
(8, 8, 'Saturday', '09:00:00', '17:00:00'),
(9, 4, 'Sunday', '11:00:00', '18:00:00');



-- Later realised I need to add appointment time as a column to be able to carry out a booking scenario
-- This was a chore. Next time I think I would just delete the table and re-create it.
UPDATE Bookings SET appointment_time = '12:00:00' WHERE booking_id = 1;
UPDATE Bookings SET appointment_time = '10:00:00' WHERE booking_id = 2;
UPDATE Bookings SET appointment_time = '15:00:00' WHERE booking_id = 3;
UPDATE Bookings SET appointment_time = '16:00:00' WHERE booking_id = 4;
UPDATE Bookings SET appointment_time = '09:00:00' WHERE booking_id = 5;
UPDATE Bookings SET appointment_time = '10:00:00' WHERE booking_id = 6;
UPDATE Bookings SET appointment_time = '12:00:00' WHERE booking_id = 7;
UPDATE Bookings SET appointment_time = '15:00:00' WHERE booking_id = 8;

