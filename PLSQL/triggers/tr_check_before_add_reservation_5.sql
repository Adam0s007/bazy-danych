create or replace trigger TR_CHECK_BEFORE_ADD_RESERVATION_5
before insert
on RESERVATION
for each row
DECLARE PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
IF free_places_5(:NEW.trip_id) <= 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'No available places');
END IF;
END;
/