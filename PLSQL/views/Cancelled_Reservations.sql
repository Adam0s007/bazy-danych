CREATE VIEW CANCELLED_RESERVATIONS AS
SELECT trip.trip_id,trip.TRIP_NAME , COUNT(reservation.RESERVATION_ID) as NO_cancelled_reservations
FROM trip
LEFT JOIN reservation ON trip.trip_id =  reservation.trip_id and reservation.status = 'C'
GROUP BY trip.trip_id,trip.TRIP_NAME
