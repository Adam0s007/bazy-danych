create or replace type available_trips_obj as OBJECT
(
trip_date DATE,
trip_name varchar(100),
NO_places int,
NO_available_places int
);
create or replace type available_trips_table is table of available_trips_obj;

create or replace function available_Trips_Func(country_name varchar, date_from DATE, date_to DATE)
return available_trips_table
AS
result available_trips_table;
null_arg exception;
wrong_order exception ;
tmp char(1);
begin
IF country_name is null or date_from is null or date_to is null then
raise_application_error(-20003,'przeslana wartosc to null');
END IF;

IF date_to < date_from THEN
raise_application_error(-20002,'from_data wieksze od to_data');
END IF;
-- sprawdzenie, czy istnieje wycieczka o podanym country_name i czasie
select 1 into tmp from Available_Trips avt
where avt.country = available_Trips_Func.country_name
AND avt.trip_date BETWEEN available_Trips_Func.date_from AND available_Trips_Func.date_to;

--zapytanie wsadzone do result
select available_trips_obj(avt.trip_date,
avt.trip_name, avt.no_places, avt.no_available_places)
bulk collect into result
from Available_Trips avt
where avt.country = available_Trips_Func.country_name
AND avt.trip_date BETWEEN available_Trips_Func.date_from AND available_Trips_Func.date_to;
--zwracanie wyniku
return result;
EXCEPTION
WHEN NO_DATA_FOUND THEN
raise_application_error(-20001,'wycieczka z podanym country_name oraz datą nie istnieje lub się odbyła');
RETURN NULL;
WHEN others THEN
raise_application_error(-20004,'Wystapil blad!');
RETURN NULL;
END;