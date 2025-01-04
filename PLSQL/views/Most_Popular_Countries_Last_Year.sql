CREATE VIEW Most_Popular_Countries_Last_Year
AS
SELECT countries.country_id,countries.country_name, COUNT(trip.trip_id) AS trip_count
FROM countries
INNER JOIN trip ON countries.country_id = trip.country_id
INNER JOIN reservation ON trip.trip_id = reservation.trip_id
WHERE reservation.status in ('P','N') AND trip.trip_date >= SYSDATE - INTERVAL '1' YEAR
GROUP BY countries.country_id,countries.country_name
ORDER BY trip_count DESC
FETCH FIRST 5 ROWS ONLY;