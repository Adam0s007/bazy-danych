CREATE VIEW NO_Paid_Reservations_Per_Person AS
SELECT person.lastname , person.firstname,COUNT(reservation.RESERVATION_ID) as NO_paid_reservations
FROM person
LEFT JOIN reservation ON person.person_id = reservation.person_id  and reservation.status = 'P'
GROUP BY person.lastname , person.firstname
