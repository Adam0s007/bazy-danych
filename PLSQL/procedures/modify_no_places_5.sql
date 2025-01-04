create or replace PROCEDURE Modify_No_Places_5(trip_id INT, no_places INT) AS
tmp_reserv0 INT;
reserved_places INT;
new_available_place INT;
BEGIN
  if trip_id is null or trip_id < 0 or no_places is null or no_places < 0 then
        raise_application_error(-20000, 'Nie mozna podawać wartosci nullowej lub mniejszej od 0');
 END IF;
    -- Sprawdzenie, czy wycieczka istnieje
  SELECT 1 INTO tmp_reserv0 FROM trip t WHERE t.trip_id  = Modify_No_Places_5.trip_id;
  -- wydobycie ilosci dostepnych miejsc
  SELECT uptr.NO_PLACES - uptr.NO_AVAILABLE_PLACES,
          uptr.NO_AVAILABLE_PLACES - uptr.NO_PLACES + Modify_No_Places_5.no_places
         INTO reserved_places,new_available_place FROM UPCOMING_TRIPS_4 uptr WHERE uptr.TRIP_ID = Modify_No_Places_5.trip_id;

  -- Aktualizacja liczby miejsc dla wycieczki
  UPDATE TRIP t SET
    t.MAX_NO_PLACES = Modify_No_Places_5.no_places,t.NO_AVAILABLE_PLACES = Modify_No_Places_5.new_available_place
    WHERE t.trip_id = Modify_No_Places_5.trip_id;
  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nie znaleziono wycieczki o zadanym id,mozliwe ze wycieczka juz sie odbyla albo niepoprawne id');
END;
/

