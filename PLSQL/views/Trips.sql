CREATE VIEW Trips AS
SELECT
    countries.country_name AS country,
    trip.trip_date,
    trip.trip_name,
	trip.trip_id,
    trip.max_no_places AS no_places,
    trip.max_no_places - COUNT(reservation.reservation_id) AS no_available_places
FROM
    trip
    INNER JOIN countries ON trip.country_id = countries.country_id
    LEFT JOIN reservation ON trip.trip_id = reservation.trip_id AND reservation.status in ('P','N')
--LEFT JOIN sprawia, ze jesli nie ma powiazania wycieczki z rezerwacjami, tzn ze wszystkie wycieczki są dostepne

GROUP BY
    countries.country_name,
    trip.trip_date,
    trip.trip_name,
    trip.trip_id,
    trip.max_no_places;