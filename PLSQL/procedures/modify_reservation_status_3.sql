create or replace PROCEDURE Modify_Reservation_Status_3(modifying_reservation_id int, new_status char)
IS
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

   UPDATE RESERVATION
    SET status = new_status
    WHERE reservation_id = modifying_reservation_id;
  COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Rezerwacja o podanym ID nie istnieje lub niepoprawny status');
end;
/