create table log
(
	log_id int  generated always as identity not null,
	reservation_id int not null,
	log_date date  not null,
	status char(1),
	constraint log_pk primary key ( log_id ) enable
);

alter table log
add constraint log_chk1 check
(status in ('N','P','C')) enable;

alter table log
add constraint log_fk1 foreign key
( reservation_id ) references reservation ( reservation_id ) enable;

