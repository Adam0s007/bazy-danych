CREATE VIEW Country_Statistics AS
SELECT countries.COUNTRY_ID,countries.country_name, COUNT(trip.trip_id) AS no_trips,
       SUM(trip.max_no_places) AS no_total_places,
       SUM(CASE WHEN trip.trip_date > SYSDATE THEN trip.max_no_places ELSE 0 END) AS no_available_places
FROM countries
INNER JOIN trip ON countries.country_id = trip.country_id
GROUP BY countries.COUNTRY_ID,countries.country_name;
