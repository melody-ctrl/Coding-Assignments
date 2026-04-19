USE HairstylistBooking;

-- Specific scenario: 
-- Customer wants to book an appointment. They want to see which stylists do a specific style
-- Out of the stylists that do this style, they need one that is available on their day off (specific day)
-- Customer has booked an appointment, receives booking details 
-- i.e. "you have booked an appointment with stylist for date. this will cost price to be paid on the day"
-- when she confirms, a new row is added to bookings table.
-- Customer wants to cancel appointment as they are no longer busy
-- Stylist wants to change prices of specific style because customers keep cancelling. 

-- Write in README: creating a scenario where customer books an appointment but realised I have no time slots in my data
-- what time is the appointment? how do we know the stylist is available at that time? I only have their opening hours. how do we avoid double booking
-- Need a time column in bookings table and maybe duration of service? 
-- when customer books, use query to Find all booked times for a stylist on a given date & check if a time slot is already taken

-- change dates in bookings table to be in the future 


