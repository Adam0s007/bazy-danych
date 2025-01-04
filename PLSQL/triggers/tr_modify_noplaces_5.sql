create trigger TR_MODIFY_NOPLACES_5
before update of no_available_places
on TRIP
for each row
DECLARE PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
IF :NEW.no_available_places < 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'trigger error: new nr of available places will be less than zero if you do that');
END IF;

END;
/


