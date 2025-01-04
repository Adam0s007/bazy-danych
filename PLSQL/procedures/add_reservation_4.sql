create or replace PROCEDURE Add_Reservation_4(trip_id int, person_id int)
IS
tmp_person char(1);
tmp_trip char(1);
not_exist inT;
id int;
max_places_was_already int;
begin
    --sprawdzenie wystapienia null
    if trip_id is null or person_id is null then
        raise_application_error(-20002, 'Przesłana wartość jest równa NULL');
    end if;
    --sprawdzenie czy osoba o podanym id istnieje
    select 1 into tmp_person FROM PERSON p WHERE Add_Reservation_4.person_id = p.person_id;
    --sprawdzenie czy wycieczka o podanym id istnieje
    select 1 into tmp_trip FROM TRIP t WHERE Add_Reservation_4.trip_id = t.trip_id;
    --sprawdzenie czy osoba o podanym id nie ma juz wybranej wycieczki o podanym id i czy status rezerwacji != C
    select case
        when exists(select * FROM RESERVATION r
                             WHERE r.PERSON_ID = Add_Reservation_4.person_id
                            AND r.trip_id = Add_Reservation_4.trip_id) then 0
        else 1
        end
    into not_exist from dual;

    if not_exist = 0 then
        raise_application_error(-20003, 'Osoba z podaną nieodwołaną rezerwacją już istnieje lub ma odwolaną rezerwację, skorzystaj z modifyReservationStatus()');
    end if;
    --sprawdzamy czy wycieczka sie juz nie odbyla
	--sprawdzamy czy są wolne miejsca
    select case
            when exists(select * FROM AVAILABLE_TRIPS_4 t
                                 WHERE t.trip_id = Add_Reservation_4.trip_id ) then 1
            else 0
            end
        into max_places_was_already from dual;
        if max_places_was_already = 0 then
            raise_application_error(-20004, 'Nie można dodać rezerwacji dla wycieczki, która już się odbyła lub nie ma wolnych miejsc');
        end if;

	--dodajemy osobę
    INSERT INTO RESERVATION(trip_id,person_id,status) VALUES(Add_Reservation_4.trip_id,Add_Reservation_4.person_id,'N')
    returning reservation_id into id;
    dbms_output.PUT_LINE(id);
    INSERT INTO LOG(RESERVATION_ID,LOG_DATE,status) VALUES(id,TO_CHAR(SYSDATE, 'YYYY-MM-DD'),'N');

    UPDATE TRIP t SET
    t.NO_AVAILABLE_PLACES = t.NO_AVAILABLE_PLACES - 1
    WHERE t.trip_id = Add_Reservation_4.trip_id;

    COMMIT;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001, 'Nie znaleziono wycieczki lub osoby z podanym ID');
END;
/