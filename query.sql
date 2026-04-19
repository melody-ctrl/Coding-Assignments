USE HairstylistBooking;

-- Specific scenario: 
-- Customer wants to find stylists who do knotless braids and see their prices 
-- Customer wants to filter these stylists to only those available on a Saturday

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


-- Customer wants to book an appointment 
-- Realised I'm missing some data in order to carry this out. need time of appointment so stylists aren't double booked



-- i.e. "you have booked an appointment with stylist for date. this will cost price to be paid on the day"
-- when she confirms, a new row is added to bookings table.
-- Customer wants to cancel appointment as they are no longer busy
-- Stylist wants to change prices of specific style because customers keep cancelling. 

-- Write in README: creating a scenario where customer books an appointment but realised I have no time slots in my data
-- what time is the appointment? how do we know the stylist is available at that time? I only have their opening hours. how do we avoid double booking
-- Need a time column in bookings table and maybe duration of service? 
-- when customer books, use query to Find all booked times for a stylist on a given date & check if a time slot is already taken

-- change dates in bookings table to be in the future 


