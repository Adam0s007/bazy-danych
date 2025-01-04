create or replace type trip_participant as OBJECT
(
reservation_id int,
person_id int,
firstname varchar2(50),
Lastname varchar2(50)
);
create or replace type trip_participant_table is table of trip_participant;

create or replace function Trip_Participants_Func(trip_id int)
return trip_participant_table
as
result trip_participant_table;
tmp char(1);
no_data exception;
begin

if Trip_Participants_Func.trip_id is null then
raise_application_error(-20002,'przeslana wartosc to null');
end if;
    -- sprawdzenie, czy istnieje wycieczka o podanym trip_id
select 1 into tmp from trip where trip.TRIP_ID = Trip_Participants_Func.trip_id;

select trip_participant(r.reservation_id, p.person_id,
p.firstname, p.lastname) bulk collect
into result
from reservation r
join person p
on r.person_id = p.person_id
where r.trip_id = Trip_Participants_Func.trip_id and r.status = 'P';
return result;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001,'Nie znaleziono osoby o id: ' || Trip_Participants_Func.trip_id);
    RETURN NULL;
WHEN others THEN
    raise_application_error(-20003,'NIEPRAWIDLOWE DZIALANIE');
    RETURN NULL;
END;