create table countries
(
    country_id int generated always as identity not null,
    country_name varchar(50),
    constraint country_pk primary key ( country_id ) enable
);