CREATE OR REPLACE FUNCTION free_places_5(trip_id IN NUMBER) RETURN NUMBER
IS
    available_places NUMBER;
BEGIN
    SELECT T.no_available_places INTO available_places FROM TRIP T WHERE t.TRIP_ID = free_places_5.trip_id;
    RETURN available_places;
END;
/