USE HairstylistBooking;

-- SCENARIO PART 1:
-- Customer named Ayra Starr wants to do knotless braids 
-- She first wants to see how many stylists provide this service
SELECT se.service_name, COUNT(ss.stylist_id) AS total_stylists
FROM Stylist_Services ss 
JOIN Services se
ON ss.service_id = se.service_id 
WHERE se.service_name = 'Knotless braids'
GROUP BY se.service_name

-- SCENARIO PART 2:
-- Ayra Starr wants to show the stylists who do knotless braids and their prices
-- and filter these stylists to only those available next Saturday

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

-- SCENARIO PART 3:
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
-- We will implement the assumption that each appointment is 1 hour long

-- SCENARIO PART 4:
-- Ayra Starr picks a time that is not in booked slot (2pm). Collect her info so she can book appt

INSERT INTO Customers (first_name, last_name, email) VALUES -- no need for customer id field due to auto increment
('Ayra', 'Starr', 'ayrastarr@hotgirl.com');

-- SCENARIO PART 5: 
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


-- SCENARIO PART 6: 
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


-- SCENARIO PART 7: 
-- blackhairldn has just seen she's been booked by a celebrity! Ayra Starr!! 
-- She decides to respect herself and will likely increase prices 

CREATE PROCEDURE UpdateServicePrice(IN service_id INT, IN new_price DECIMAL(5,2))
BEGIN
	UPDATE Stylist_Services ss
    SET price = new_price
    WHERE stylist_id = service_id;
END;

-- SCENARIO PART 8:
-- But first, she wants to compare her prices to whatever the highest price another stylist is charging for the same services

SELECT se.service_name
FROM Services se
JOIN Stylist_services ss 
  ON se.service_id = ss.service_id 
JOIN Stylists s
  ON s.stylist_id = ss.stylist_id
WHERE s.name = 'blackhairldn';

-- blackhairldn provides Hair extension and Knotless braids services 

SELECT se.service_id, se.service_name, ss.price AS stylist_price,
 (SELECT MAX(ss2.price)
  FROM Stylist_Services ss2 -- second alias (ss2) in the subquery to reference the Stylist_Services table separate from main query
  WHERE ss2.service_id = ss.service_id  -- only compare same services as the ones being compared for blackhairldn
  ) AS highest_price
FROM Stylist_Services ss
JOIN Stylists s 
  ON ss.stylist_id = s.stylist_id
JOIN services se 
  ON ss.service_id = se.service_id 
WHERE s.name = 'blackhairldn' 
  AND se.service_name IN ('Hair Extensions', 'Knotless braids')


-- SCENARIO PART 9: 
-- Based on this revelation, blackhairldn will increase prices for all her services. 
-- She now does celebrity hair. She deserves more
  
CALL UpdateServicePrice(6, 160);
CALL UpdateServicePrice(7, 90);


-- SCENARIO PART 10: 
-- Because she feels high and mighty, blackhairldn decides to cancel the booking she has with another customer on the same Saturday 
-- She needs the whole day to prepare to do Ayra Starr's hair. Sorry to the other babe, whoever she is

-- show her bookings for saturday
SELECT 
    b.booking_id,
    c.first_name,
    c.last_name,
    se.service_name,
    b.appointment_date,
    b.appointment_time
FROM Bookings AS b 
JOIN Stylists s 
  ON b.stylist_id = s.stylist_id
JOIN Customers c 
  ON b.customer_id = c.customer_id
JOIN Services se 
  ON b.service_id = se.service_id
WHERE s.name = 'blackhairldn'
  AND b.appointment_date = '2026-04-25';
  
-- Lily Richardson, you've got to go!

DELETE FROM Bookings
WHERE booking_id = 7;
