/*1. Create a view that displays patient appointments with doctor details.*/
CREATE VIEW PatientAppointmentView AS
SELECT
    p.FirstName as Patients_FirstName,
    p.LastName as Patients_LastName,
    AppointmentDate,
    d.FirstName AS Doctors_FirstName,
    d.LastName AS Doctors_LastName
FROM Patient as p
JOIN Appointment as a 
    ON p.PatientID = a.PatientID
JOIN Doctor as d
    ON a.DoctorID = d.DoctorID;
    
SELECT 
   * 
FROM PatientAppointmentView;

/*2. Create a procedure that returns all appointments for a given patient.*/
DELIMITER //

CREATE PROCEDURE GetPatientAppointments
(
    IN PatientCode CHAR(6)
)
BEGIN

    SELECT 
        *
    FROM Appointment
    WHERE PatientID = PatientCode;

END //

DELIMITER ;

CALL GetPatientAppointments('P00001');

/*3. Automatically update PaymentStatus to 'Paid' when payment covers the bill amount.*/
DELIMITER //

CREATE TRIGGER trg_UpdateBillStatus
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    UPDATE Billing
    SET PaymentStatus =
        CASE
            WHEN (
                SELECT COALESCE(SUM(AmountPaid), 0)
                FROM Payment
                WHERE BillID = NEW.BillID
            ) >= Amount
            THEN 'Paid'
            ELSE 'Pending'
        END
    WHERE BillID = NEW.BillID;
END //

DELIMITER ;


/*4. Create a temporary table containing only outstanding bills.*/
CREATE TEMPORARY TABLE OutstandingBills AS
	SELECT 
	   *
	FROM Billing
	WHERE PaymentStatus = 'Pending';
