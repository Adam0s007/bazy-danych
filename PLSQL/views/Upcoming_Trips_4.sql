CREATE VIEW Upcoming_Trips_4 AS
SELECT * FROM TRIPS_4 t
WHERE t.trip_date > SYSDATE;