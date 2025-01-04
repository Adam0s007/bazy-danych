create or replace trigger TR_CHECK_BEFORE_ADD_RESERVATION
before insert
on RESERVATION
for each row
DECLARE PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
IF free_places(:NEW.trip_id) <= 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'Trigger error: No available places!');
END IF;
END;
/
