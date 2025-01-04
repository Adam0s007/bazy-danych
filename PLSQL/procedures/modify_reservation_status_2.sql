create or replace PROCEDURE Modify_Reservation_Status_2(modifying_reservation_id int, new_status char)
IS
	can_modify int;
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
                               WHERE avt.trip_id = modifying_trip_id) THEN 1
                   ELSE 0
                   END
        INTO can_modify
        FROM DUAL;
        IF can_modify = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error: the trip has already taken place or there are no vacancies.');
        END IF;
    END IF;

   UPDATE RESERVATION
    SET status = new_status
    WHERE reservation_id = modifying_reservation_id;
  COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Rezerwacja o podanym ID nie istnieje lub niepoprawny status');
end;
/