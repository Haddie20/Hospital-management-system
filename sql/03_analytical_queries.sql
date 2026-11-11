/*1. Display each Patient's name, appointment date, appointment status, and the doctor's name.*/
SELECT
   p.FirstName as Patients_FirstName,
   p.LastName as Patients_LastName,
   AppointmentDate,
   Status,
   d.FirstName as Doctors_FirstName,
   d.LastName as Doctors_LastName
FROM Patient as p
JOIN Appointment as a
  ON p.PatientID=a.PatientID
JOIN Doctor as d
  ON a.DoctorID=d.DoctorID;
  
/*2. Show the number of patients handled by each doctor.*/
SELECT
    d.DoctorID,
    d.FirstName as Doctors_FirstName,
    d.LastName as Doctors_LastName,
    COUNT(a.PatientID) as Total_patients
FROM Doctor as d
LEFT JOIN Appointment as a
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;

/*3. Classify bills as Low, Medium, or High value, using CASE Expression.*/
SELECT
    BillID,
    Amount,
    CASE
        WHEN Amount < 500 THEN 'Low'
        WHEN Amount BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS Bill_category
FROM Billing;

/*4. Display patient names and whether their bill has been fully paid.*/
SELECT
    p.FirstName,
    p.LastName,
    Amount,
    CASE
        WHEN b.PaymentStatus = 'Paid' THEN 'Fully Paid'
        ELSE 'Outstanding'
    END AS Bill_status
FROM Patient as p
JOIN Billing as b
    ON p.PatientID = b.PatientID;
    
/*5. Find patients whose bill amount is above the average bill amount.*/
SELECT
    PatientID,
    Amount
FROM Billing
WHERE Amount > (
				SELECT AVG(Amount)
				FROM Billing
			   );
               
/*6. Show doctors who have handled more than one appointment.*/
WITH cte_Doctor_Appointments AS
								(
									SELECT
										DoctorID,
										COUNT(*) AS Appointment_count
									FROM Appointment
									GROUP BY DoctorID
								)
SELECT 
   *
FROM cte_Doctor_Appointments
WHERE Appointment_count > 1;

/*7. Rank doctors according to the number of appointments they have handled.*/
SELECT
    d.DoctorID,
    d.FirstName,
    d.LastName,
    COUNT(a.AppointmentID) AS Total_appointments,
    RANK() OVER(ORDER BY COUNT(a.AppointmentID) DESC) AS Doctor_rank
FROM Doctor as d
LEFT JOIN Appointment as a
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;

/*8. Display billing records with a running total of revenue.*/
SELECT
    BillID,
    BillingDate,
    Amount,
    SUM(Amount) OVER(ORDER BY BillingDate) AS Running_revenue
FROM Billing;

/*9. Display patient name, doctor name, department, diagnosis, and treatment.*/
SELECT
    p.FirstName as Patients_FirstName,
    p.LastName as Patients_LastName,
    d.FirstName as Doctors_FirstName,
    d.LastName as Doctors_LastName,
    DepartmentName,
    Diagnosis,
    Treatment
FROM Patient as p 
JOIN MedicalRecord as mr
    ON p.PatientID = mr.PatientID
JOIN Doctor as d
    ON mr.DoctorID = d.DoctorID
JOIN Department as dep
    ON d.DepartmentID = dep.DepartmentID;
    
/*10. Display departments that have more than one doctor.*/
SELECT
    DepartmentName,
    COUNT(d.DoctorID) AS Number_Of_Doctors
FROM Department as dep
JOIN Doctor as d
    ON dep.DepartmentID = d.DepartmentID
GROUP BY DepartmentName
HAVING COUNT(d.DoctorID) > 1;
