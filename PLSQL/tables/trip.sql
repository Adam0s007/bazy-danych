
create table trip
(
  trip_id int generated always as identity not null,
  trip_name varchar(100),
  country_id int,
  trip_date date,
  max_no_places int,
  constraint trip_pk primary key ( trip_id ) enable
);


alter table trip
add constraint trip_fk1 foreign key
( country_id ) references countries ( country_id ) enable;
