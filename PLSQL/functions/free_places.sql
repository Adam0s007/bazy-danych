CREATE OR REPLACE FUNCTION free_places(trip_id IN NUMBER) RETURN NUMBER
IS
    total_places NUMBER;
    reserved_places NUMBER;
    available_places NUMBER;
BEGIN
    SELECT MAX_NO_PLACES INTO total_places FROM TRIP T WHERE t.TRIP_ID = free_places.trip_id;
    SELECT COUNT(*) INTO reserved_places FROM RESERVATION r WHERE r.TRIP_ID = free_places.trip_id AND STATUS IN ('N','P');
    available_places := total_places - reserved_places;
    RETURN available_places;
END;
/
