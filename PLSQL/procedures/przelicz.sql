CREATE OR REPLACE PROCEDURE przelicz
IS
BEGIN
    FOR trip_rec IN (SELECT * FROM TRIP)
    LOOP
        UPDATE TRIP
        SET no_available_places = trip_rec.max_places - (SELECT COUNT(*) FROM RESERVATION WHERE RESERVATION.trip_id = trip_rec.trip_id AND RESERVATION.status != 'C')
        WHERE trip_id = trip_rec.trip_id;
    END LOOP;
    COMMIT;
END;
/