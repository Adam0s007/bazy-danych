CREATE VIEW Reservation_Log AS
SELECT l.log_id,l.log_date,trip.trip_name, countries.country_name,
       person.firstname, person.lastname, l.status
INNER FROM log l
INNER JOIN reservation ON l.reservation_id = reservation.reservation_id
INNER JOIN trip ON reservation.trip_id = trip.trip_id
INNER JOIN countries ON trip.country_id = countries.country_id
INNER JOIN person ON reservation.person_id = person.person_id
