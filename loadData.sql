COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/Students.table' DELIMITER ',' CSV HEADER;
COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/Degrees.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER; 
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/mnt/ramdisk/tables/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseRegistrations.table' WITH DELIMITER ',' CSV HEADER NULL 'null';

ANALYZE
