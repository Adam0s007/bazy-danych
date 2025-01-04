CREATE VIEW Trips_4 AS
SELECT
    countries.country_name AS country,
    trip.trip_date,
    trip.trip_name,
	trip.trip_id,
    trip.max_no_places AS no_places,
    trip.no_available_places
FROM
    trip
    INNER JOIN countries ON trip.country_id = countries.country_id;
------------------------------------------