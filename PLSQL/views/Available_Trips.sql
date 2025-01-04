CREATE VIEW Available_Trips AS
SELECT * FROM TRIPS t
WHERE t.no_available_places > 0 AND t.trip_date > SYSDATE;

