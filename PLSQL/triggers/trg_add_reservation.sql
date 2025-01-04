CREATE OR REPLACE TRIGGER trg_add_reservation
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
  INSERT INTO LOG (reservation_id, log_date, status)
  VALUES (:NEW.reservation_id, TO_CHAR(SYSDATE, 'YYYY-MM-DD'), :NEW.status);
END;
/
