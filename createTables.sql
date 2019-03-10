CREATE UNLOGGED TABLE IF NOT EXISTS Students(StudentId int PRIMARY KEY, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char);
CREATE UNLOGGED TABLE IF NOT EXISTS Degrees(DegreeId int PRIMARY KEY, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int);
CREATE UNLOGGED TABLE IF NOT EXISTS StudentRegistrationsToDegrees(StudentRegistrationId int PRIMARY KEY, StudentId int, DegreeId int, RegistrationYear int);
CREATE UNLOGGED TABLE IF NOT EXISTS Teachers(TeacherId int PRIMARY KEY, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char); 
CREATE UNLOGGED TABLE IF NOT EXISTS Courses(CourseId int PRIMARY KEY, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);
CREATE UNLOGGED TABLE IF NOT EXISTS CourseOffers(CourseOfferId int PRIMARY KEY, CourseId int, Year int, Quartile int);
CREATE UNLOGGED TABLE IF NOT EXISTS TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE IF NOT EXISTS StudentAssistants(CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE IF NOT EXISTS CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade int);
