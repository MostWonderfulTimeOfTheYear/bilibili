SELECT courses.coursename, courseregistrations.grade FROM courseregistrations,studentregistrationstodegrees,courses, courseoffers WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND courseregistrations.grade>5 AND courseoffers.courseid=courses.courseid AND courseoffers.courseofferid=courseregistrations.courseofferid AND studentregistrationstodegrees.degreeid=courses.degreeid AND studentregistrationstodegrees.studentid=%1% AND studentregistrationstodegrees.degreeid=%2% ORDER BY courseoffers.year, courseoffers.quartile,courseoffers.courseofferid;
SELECT DISTINCT (studentid) FROM excellentStudents WHERE excellentStudents.gpa >=%1% ORDER BY studentid;
WITH totalStudents(degreeid,total) AS (SELECT activeStudents.degreeid, COUNT(*) FROM students,activeStudents WHERE students.studentid=activeStudents.studentid GROUP BY degreeid), totalFemaleStudents(degreeid,totalFemale) AS(SELECT activeStudents.degreeid,COUNT(*) FROM students,activeStudents WHERE students.studentid=activeStudents.studentid AND students.gender='F' GROUP BY degreeid) SELECT totalStudents.degreeiD,CAST(totalFemaleStudents.totalFemale AS FLOAT)/CAST(totalStudents.total AS FLOAT) * 1.0 AS percentage FROM totalStudents,totalFemaleStudents WHERE totalStudents.degreeid=totalFemaleStudents.degreeid ORDER BY totalStudents.degreeId;
WITH StudentsInDegree AS (SELECT st.StudentId, st.Gender FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg  WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept=%1%) SELECT (1. * COUNT(*) / (SELECT COUNT(*) FROM StudentsInDegree)) AS percentage FROM StudentsInDegree WHERE Gender='F';
WITH CourseOfferGradesBelow AS (SELECT co.CourseId, COUNT(co.CourseId) AS Below FROM CourseRegistrations as cr, CourseOffers as co WHERE cr.Grade < %1% AND co.CourseOfferId=cr.CourseOfferId GROUP BY co.CourseId),CourseOfferGradesAbove AS ( SELECT co.CourseId, COUNT(co.CourseId) AS Above FROM CourseRegistrations as cr, CourseOffers as co WHERE cr.Grade >= %1% AND co.CourseOfferId=cr.CourseOfferId GROUP BY co.CourseId)SELECT cogb.CourseId, (1. * (coga.Above) / (cogb.Below + coga.Above)) as percentagePassing FROM CourseOfferGradesBelow AS cogb, CourseOfferGradesAbove coga WHERE cogb.CourseId=coga.CourseId GROUP BY cogb.CourseId, coga.Above, cogb.Below  ORDER BY cogb.CourseId;
SELECT StudentId, numberOfCoursesWhereExcellent FROM ExcellentCourseStudents WHERE numberOfCoursesWhereExcellent >= %1%;
SELECT gpas.degreeid, s.birthyearStudent, s.gender, AVG(gpas.GPA) FROM gpas, students as s WHERE gpas.studentid = s.studentid GROUP BY CUBE (gpas.degreeid, s.birthyearstudent, s.gender);
SELECT 0;
