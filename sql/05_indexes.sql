/*Improve appointment search performance by indexing frequently searched columns.*/
CREATE INDEX idx_appointment_patient
  ON Appointment(PatientID);

CREATE INDEX idx_appointment_doctoradmission
  ON Appointment(DoctorID);
