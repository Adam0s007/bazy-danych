CREATE VIEW Reservations AS
SELECT countries.country_name,
       trip.trip_date,
       trip.trip_name,
       person.firstname,
       person.lastname,
       reservation.reservation_id,
       reservation.status
FROM reservation
INNER JOIN trip ON reservation.trip_id = trip.trip_id
INNER JOIN person ON reservation.person_id = person.person_id
INNER JOIN countries ON trip.country_id = countries.country_id;
