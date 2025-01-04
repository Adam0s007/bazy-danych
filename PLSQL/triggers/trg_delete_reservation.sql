CREATE OR REPLACE TRIGGER trg_delete_reservation
BEFORE DELETE ON reservation
FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010, 'Deletion of reservations is not allowed');
END;
/