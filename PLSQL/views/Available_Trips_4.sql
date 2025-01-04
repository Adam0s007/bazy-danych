--dostepne wycieczki
CREATE VIEW Available_Trips_4 AS
SELECT * FROM TRIPS_4 t
WHERE t.no_available_places > 0 AND t.trip_date > SYSDATE;