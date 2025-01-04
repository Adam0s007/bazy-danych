create or replace PROCEDURE Modify_No_Places(trip_id INT, no_places INT) AS
tmp_reserv0 INT;
reserved_places INT;
BEGIN
  if trip_id is null or trip_id < 0 or no_places is null or no_places < 0 then
        raise_application_error(-20001, 'Nie mozna podawać wartosci nullowej lub mniejszej od 0');
 END IF;
    -- Sprawdzenie, czy wycieczka istnieje
  SELECT 1 INTO tmp_reserv0 FROM trip t WHERE t.trip_id  = Modify_No_Places.trip_id;
  -- wydobycie ilosci dostepnych miejsc
  SELECT uptr.NO_PLACES - uptr.NO_AVAILABLE_PLACES INTO reserved_places FROM UPCOMING_TRIPS uptr WHERE uptr.TRIP_ID = Modify_No_Places.trip_id;


  IF (Modify_No_Places.no_places < reserved_places) THEN
    RAISE_APPLICATION_ERROR(-20002, 'Ilosc zarezerwowanych miejsc na daną wycieczkę musi byc mniejsza od nowej ilosc miejsc');
  END IF;

  -- Aktualizacja liczby miejsc dla wycieczki
  UPDATE TRIP t SET t.MAX_NO_PLACES = Modify_No_Places.no_places WHERE t.trip_id = Modify_No_Places.trip_id;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nie znaleziono wycieczki o zadanym id,mozliwe ze wycieczka juz sie odbyla albo niepoprawne id');
END;
/