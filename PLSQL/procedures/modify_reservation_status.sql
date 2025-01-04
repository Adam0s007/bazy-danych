create or replace PROCEDURE Modify_Reservation_Status(modifying_reservation_id int, new_status char)
IS
	modif int;
    old_reserv_status char(1);
	modifying_trip_id int;
BEGIN
   if new_status NOT IN ('C','N','P') THEN
       RAISE_APPLICATION_ERROR(-20001,'Error: wrong status!');
   end if;
    SELECT r.status, r.trip_id
    INTO old_reserv_status, modifying_trip_id
    FROM RESERVATION r
    WHERE r.reservation_id = modifying_reservation_id;

	IF old_reserv_status IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001, 'Error: trip not found.');
	END IF;

	IF old_reserv_status = new_status THEN
		RAISE_APPLICATION_ERROR(-20001, 'Error: You gave same status as before.');
	END IF;

IF old_reserv_status = 'C' THEN
        SELECT CASE
                   WHEN EXISTS(SELECT *
                               FROM AVAILABLE_TRIPS avt
                               WHERE avt.trip_id = modifying_trip_id) THEN 0
                   ELSE 1
                   END
        INTO modif
        FROM DUAL;
        IF modif = 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error: the trip has already taken place or there are no vacancies.');
        END IF;
    END IF;

   UPDATE RESERVATION SET status = new_status WHERE reservation_id = modifying_reservation_id;
  -- dodanie nowego wpisu do LOG
INSERT INTO LOG(RESERVATION_ID, LOG_DATE, status) VALUES(modifying_reservation_id, TO_CHAR(SYSDATE, 'YYYY-MM-DD'),new_status);
  COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Rezerwacja o podanym ID nie istnieje lub niepoprawny status');
end;
/