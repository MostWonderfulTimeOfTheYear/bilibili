CREATE MATERIALIZED VIEW gpas(studentid,degreeid,GPA) AS
    WITH maxGrades(studentid,degreeid,courseid,totalGrade , totalects) AS (
        SELECT activeStudents.studentid, srtd.degreeid, co.courseid, SUM(cr.grade), SUM(c.ects) 
        FROM activeStudents, courseRegistrations as cr, courseOffers as co, studentregistrationstodegrees as srtd, courses as c
        WHERE cr.grade > 5 AND cr.courseOfferId=co.courseOfferId AND srtd.studentregistrationid=cr.studentregistrationid
        AND srtd.studentid=activeStudents.studentid
        GROUP BY studentid,degreeid)
    SELECT tg.studentid, tg.degreeid, CAST (tg.totalGrade AS FLOAT)/CAST(tg.totalects AS FLOAT) AS gpa 
    FROM maxGrades AS tg
    GROUP BY studentid, degreeid, tg.totalGrade, tg.totalects;
CREATE MATERIALIZED VIEW excellentStudents(studentid,gpa) AS
With noFailure(studentid,degreeid) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid
			FROM studentregistrationstodegrees,courseregistrations
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid
			HAVING MIN(courseregistrations.grade)>=5),
	nerdyStudents(studentid,degreeid,weightedtotalgrades,totalects) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid,SUM(courseregistrations.grade*courses.ects) as weightedtotalgrades ,SUM(courses.ects) as totalects
			FROM studentregistrationstodegrees,courseregistrations,courses,courseoffers
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND
			  courseoffers.courseofferid=courseregistrations.courseofferid AND  courseregistrations.grade IS NOT NULL AND courses.courseid=courseoffers.courseid AND 
			  (studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid) IN (SELECT studentid,degreeid
										FROM noFailure)
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid),
	studentsGpa(studentid,GPA) AS(
	SELECT nerdyStudents.studentid,CAST (nerdyStudents.weightedtotalgrades AS FLOAT)/CAST(nerdyStudents.totalects AS FLOAT) as GPA
	FROM nerdyStudents, degrees
	WHERE nerdyStudents.degreeid=degrees.degreeid AND nerdyStudents.totalects>=degrees.totalects)
	SELECT studentid,GPA
	FROM studentsGpa 
	WHERE GPA BETWEEN 9 AND 10;
Create MATERIALIZED VIEW totalECTS(studentid,degreeid,totalECTS) AS
	SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid,SUM(courses.ects) AS totalECTS
	FROM studentregistrationstodegrees, courseregistrations,courses,courseoffers
	WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND
		courses.courseid=courseoffers.courseid AND courseoffers.courseofferid=courseregistrations.courseofferid 
	AND courseregistrations.grade>=5 AND courseregistrations.grade IS NOT NULL 
	GROUP BY studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid;
CREATE MATERIALIZED VIEW activeStudents(studentid,degreeid) AS 
	SELECT totalECTS.studentid,totalECTS.degreeid
	FROM totalECTS, degrees
	WHERE totalECTS.degreeid=degrees.degreeid AND totalECTS.totalECTS < degrees.totalects;
CREATE MATERIALIZED VIEW ExcellentCourseStudents(StudentId, NumberOfCoursesWhereExcellent) AS
    WITH
        HighestGradeCourseOffers AS (
            SELECT cr.CourseOfferId, Max(Grade) AS highestGrade 
                FROM CourseRegistrations AS cr, CourseOffers AS co 
                    WHERE co.CourseOfferId=cr.CourseOfferId AND co.Quartile=1 AND co.Year=2018 
                        GROUP BY cr.CourseOfferId
        )
    SELECT st2deg.StudentId, COUNT(st2deg.StudentId) AS numberOfCoursesWhereExcellent 
        FROM HighestGradeCourseOffers AS gco, StudentRegistrationsToDegrees AS st2deg, CourseRegistrations AS cr 
            WHERE gco.CourseOfferId=cr.CourseOfferId AND cr.StudentRegistrationId=st2deg.StudentRegistrationId AND cr.Grade=gco.highestGrade 
                GROUP BY st2deg.StudentId;
