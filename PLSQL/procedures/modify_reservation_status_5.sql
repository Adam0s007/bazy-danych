
create or replace PROCEDURE Modify_Reservation_Status_5(modifying_reservation_id int, new_status char)
IS
    old_reserv_status char(1);
	modifying_trip_id int;
    v_value int;
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

   IF new_status = 'C' THEN
      v_value := 1;
   ELSE
       v_value := -1;
      END IF;
   IF new_status in ('N','P') and old_reserv_status in ('N','P') THEN
      v_value := 0;
    END IF;
   --update rezerwacji
   UPDATE RESERVATION
    SET status = new_status
    WHERE reservation_id = modifying_reservation_id;
   --update ilosci miejsc
   UPDATE TRIP t SET
    t.NO_AVAILABLE_PLACES = t.NO_AVAILABLE_PLACES + v_value
    WHERE t.trip_id = modifying_trip_id;
  COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Rezerwacja o podanym ID nie istnieje lub niepoprawny status');
end;
/