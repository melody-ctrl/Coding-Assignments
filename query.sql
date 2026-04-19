USE HairstylistBooking;

-- Specific scenario part 1:
-- Customer wants to find stylists who do knotless braids and see their prices 
-- Customer wants to filter these stylists to only those available next Saturday

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

-- Specific scenario part 2:
-- Customer is ready to book an appointment with blackhairldn. Needs to know available times on Saturday
-- Realised I'm missing some data in order to carry this out. need time of appointment so stylists aren't double booked

SELECT s.name, b. appointment_date AS 'Date', b.appointment_time AS 'Booked Slots'
FROM Bookings AS b 
JOIN Stylists AS s 
ON b.stylist_id = s.stylist_id 
WHERE s.name = 'blackhairldn'
AND b.appointment_date = '2026-04-25';

-- Not sure if it's possible to show the not booked times, so for simplicity:
-- Available times are determined by showing stylist's booked times for a certain date
-- Customer can choose another time outside of it 

-- Specific scenario part 3: 
-- Customer picks a time that is not in booked slot. Books an appointment. 

-- i.e. "you have booked an appointment with stylist for date. this will cost price to be paid on the day"
-- when she confirms, a new row is added to bookings table.
-- Customer wants to cancel appointment as they are no longer busy
-- Stylist wants to change prices of specific style because customers keep cancelling. 

-- Write in README: creating a scenario where customer books an appointment but realised I have no time slots in my data
-- what time is the appointment? how do we know the stylist is available at that time? I only have their opening hours. how do we avoid double booking
-- Need a time column in bookings table and maybe duration of service? 
-- when customer books, use query to Find all booked times for a stylist on a given date & check if a time slot is already taken

-- change dates in bookings table to be in the future 


