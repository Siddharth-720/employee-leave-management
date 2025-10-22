 USE leave_management_system;
  ALTER TABLE users
  ADD COLUMN vacation_balance INT NOT NULL DEFAULT 20,
  ADD COLUMN sick_balance INT NOT NULL DEFAULT 10,
  ADD COLUMN personal_balance INT NOT NULL DEFAULT 5;