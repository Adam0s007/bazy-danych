CREATE VIEW Upcoming_Trips AS
SELECT * FROM TRIPS t
WHERE t.trip_date > SYSDATE;