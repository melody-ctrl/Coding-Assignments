USE HairstylistBooking;

-- SCENARIO PART 1:
-- Customer named Ayra Starr wants to find stylists who do knotless braids and see their prices 
-- Ayra Starr wants to filter these stylists to only those available next Saturday

SELECT s.name, se.service_name, ss.price
FROM Stylists s
JOIN Stylist_Services ss 
  ON s.stylist_id = ss.stylist_id
JOIN Services se 
  ON ss.service_id = se.service_id
JOIN Availability a 
  ON s.stylist_id = a.stylist_id
WHERE se.service_name = 'Knotless braids'
  AND a.day_of_week = 'Saturday'
ORDER BY ss.price ASC; -- show cheapest stylist first 

-- SCENARIO PART 2:
-- Ayra Starr is ready to book an appointment with blackhairldn because she's cheaper
-- She now needs to know available times on Saturday
-- Realised I'm missing some data in order to carry this out. need time of appointment column so stylists aren't double booked

SELECT s.name, b. appointment_date AS 'Date', b.appointment_time AS 'Booked Slots'
FROM Bookings AS b 
JOIN Stylists AS s 
  ON b.stylist_id = s.stylist_id 
WHERE s.name = 'blackhairldn'
  AND b.appointment_date = '2026-04-25';

-- For simplicity: Available times are determined by showing stylist's booked times for a certain date
-- Customer can choose another time outside of it. I am very aware I am making assumptions and simplifying this to match my skillset.
-- We will implement the assumption that each appointment is 1 hour long (stated in README)

-- SCENARIO PART 3:
-- Ayra Starr picks a time that is not in booked slot (2pm). Collect her info so she can book appt

INSERT INTO Customers (first_name, last_name, email) VALUES -- no need for customer id field due to auto increment
('Ayra', 'Starr', 'ayrastarr@hotgirl.com');

-- SCENARIO PART 4: 
-- Create a new booking for her. Using INSERT INTO SELECT query to save some time

INSERT INTO Bookings (stylist_id, customer_id, service_id, date_booked, appointment_date, appointment_time)
SELECT
  s.stylist_id, 
  (SELECT customer_id FROM Customers WHERE email = 'ayrastarr@hotgirl.com'), 
  se.service_id, 
  CURDATE(), 
  '2026-04-25', 
  '14:00:00'
FROM Stylists s 
JOIN Stylist_Services ss
  ON s.stylist_id = ss.stylist_id 
JOIN Services se
  ON se.service_id = ss.service_id 
WHERE s.name = 'blackhairldn' 
  AND se.service_name = 'Knotless braids';


-- SCENARIO PART 5: 
-- Create a booking confirmation message for Ayra Starr using concat 
SELECT CONCAT(
  'You have a confirmed booking with ', 
  s.name, 
  ' for ',
  se.service_name,
  ' on ',
  b.appointment_date, 
  ' at ',
  b.appointment_time,
  ' at the cost of £',
  ss.price
) AS booking_confirmation
FROM Bookings b 
JOIN Stylist_Services ss
  ON b.stylist_id = ss.stylist_id  
  JOIN Services se 
  ON se.service_id = b.service_id 
JOIN Stylists s
  ON s.stylist_id = b.stylist_id
  AND ss.service_id = b.service_id  -- prevents duplicates as stylist can have many services and service can have many stylists
WHERE booking_id = '9';


-- i.e. "you have booked an appointment with stylist for date. this will cost price to be paid on the day"
-- when she confirms, a new row is added to bookings table.
-- Customer wants to cancel appointment as they are no longer busy
-- Stylist wants to change prices of specific style because customers keep cancelling. 

-- Write in README: creating a scenario where customer books an appointment but realised I have no time slots in my data
-- what time is the appointment? how do we know the stylist is available at that time? I only have their opening hours. how do we avoid double booking
-- Need a time column in bookings table and maybe duration of service? 
-- when customer books, use query to Find all booked times for a stylist on a given date & check if a time slot is already taken

-- change dates in bookings table to be in the future 


