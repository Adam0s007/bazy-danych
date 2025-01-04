INSERT INTO person (firstname, lastname) VALUES ('Jan', 'Kowalski');
INSERT INTO person (firstname, lastname) VALUES ('Maria', 'Nowak');
INSERT INTO person (firstname, lastname) VALUES ('Andrzej', 'Lewandowski');
INSERT INTO person (firstname, lastname) VALUES ('Katarzyna', 'Wójcik');
INSERT INTO person (firstname, lastname) VALUES ('Piotr', 'Mazurek');
INSERT INTO person (firstname, lastname) VALUES ('Agnieszka', 'Szymańska');
INSERT INTO person (firstname, lastname) VALUES ('Tomasz', 'Jankowski');
INSERT INTO person (firstname, lastname) VALUES ('Barbara', 'Kamińska');
INSERT INTO person (firstname, lastname) VALUES ('Wojciech', 'Kaczmarek');
INSERT INTO person (firstname, lastname) VALUES ('Magdalena', 'Zając');

INSERT INTO countries (country_name) VALUES ('Polska');
INSERT INTO countries (country_name) VALUES ('Francja');
INSERT INTO countries (country_name) VALUES ('Włochy');
INSERT INTO countries (country_name) VALUES ('Hiszpania');

-- Wypełnienie tabeli "trip" danymi testowymi
INSERT INTO trip (trip_name, country_id, trip_date, max_no_places) VALUES ('Wakacje w Polsce', 1, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 20);
INSERT INTO trip (trip_name, country_id, trip_date, max_no_places) VALUES ('Wakacje we Francji', 2, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 15);
INSERT INTO trip (trip_name, country_id, trip_date, max_no_places) VALUES ('Wycieczka po Włoszech', 3, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 30);
INSERT INTO trip (trip_name, country_id, trip_date, max_no_places) VALUES ('Wakacje w Hiszpanii', 4, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 25);

-- Wypełnienie tabeli "reservation" danymi testowymi
-- rezerwacja jest odwolana jesli: nie zaplaci w odpowiednim terminie user, albo rezygnuje przed zaplatą
INSERT INTO reservation (trip_id, person_id, status) VALUES (1, 1, 'P');
INSERT INTO reservation (trip_id, person_id, status) VALUES (1, 2, 'P');
INSERT INTO reservation (trip_id, person_id, status) VALUES (1, 3, 'C');
INSERT INTO reservation (trip_id, person_id, status) VALUES (2, 7, 'N');
INSERT INTO reservation (trip_id, person_id, status) VALUES (2, 2, 'P');
INSERT INTO reservation (trip_id, person_id, status) VALUES (2, 3, 'P');
INSERT INTO reservation (trip_id, person_id, status) VALUES (3, 9, 'P');
INSERT INTO reservation (trip_id, person_id, status) VALUES (3, 6, 'C');
INSERT INTO reservation (trip_id, person_id, status) VALUES (3, 4, 'C');
INSERT INTO reservation (trip_id, person_id, status) VALUES (4, 9, 'N');

-- Wypełnienie tabeli "log" danymi testowymi
INSERT INTO log (reservation_id, log_date, status) VALUES (1, '2022-02-01', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES  (1, '2022-02-02', 'P');
INSERT INTO log (reservation_id, log_date, status) VALUES (2, '2022-02-01', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (2, '2022-02-03', 'P');
INSERT INTO log (reservation_id, log_date, status) VALUES (3, '2022-02-02', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (3, '2022-02-05', 'C');
INSERT INTO log (reservation_id, log_date, status) VALUES (4, '2022-02-03', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (5, '2022-02-04', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (5, '2022-02-07', 'P');
INSERT INTO log (reservation_id, log_date, status) VALUES (6, '2022-02-05', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (6, '2022-02-06', 'P');
INSERT INTO log (reservation_id, log_date, status) VALUES (7, '2022-02-06', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (7, '2022-02-09', 'P');
INSERT INTO log (reservation_id, log_date, status) VALUES (8, '2022-02-07', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (8, '2022-02-11', 'C');
INSERT INTO log (reservation_id, log_date, status) VALUES (9, '2022-02-08', 'N');
INSERT INTO log (reservation_id, log_date, status) VALUES (9, '2022-02-10', 'C');
INSERT INTO log (reservation_id, log_date, status) VALUES (10, '2022-02-09', 'N');


