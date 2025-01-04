create or replace type person_reservations as OBJECT
(
reservation_id int,
reservation_status char(1),
trip_date DATE,
trip_name varchar2(50),
country_name varchar2(50)
);
create or replace type person_reservations_table is table of person_reservations;

create or replace function Person_Reservations_Func(person_id int)
return person_reservations_table
as
result person_reservations_table;
tmp char(1);
null_arg exception;
begin

if Person_Reservations_Func.person_id is null then
raise_application_error(-20002,'argument jest nullem!');
end if;
-- sprawdzenie, czy istnieje osoba o podanym person_id
select 1 into tmp from person where person.person_id = Person_Reservations_Func.person_id;

select person_reservations(r.reservation_id, r.status,
t.TRIP_DATE, t.TRIP_NAME,c.COUNTRY_NAME) bulk collect
into result
from reservation r
join trip t on t.trip_id = r.TRIP_ID
join countries c on c.COUNTRY_ID = t.COUNTRY_ID
where r.PERSON_ID = Person_Reservations_Func.PERSON_ID and r.status != 'C';
return result;
EXCEPTION
WHEN NO_DATA_FOUND THEN
raise_application_error(-20001,'Nie znaleziono zadnej rezerwacji dla osoby o id: ' || Person_Reservations_Func.PERSON_ID);
RETURN NULL;
WHEN others THEN
raise_application_error(-20003,'Wystapil blad!');
RETURN NULL;
END;

SELECT * FROM Person_Reservations_Func(2);