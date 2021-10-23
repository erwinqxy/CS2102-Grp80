------------------------------------

-- TABLES

------------------------------------

-- Employees

CREATE TABLE Employees (
	eid INTEGER IDENTITY(1,1) PRIMARY KEY,
	ename TEXT NOT NULL,
	email TEXT UNIQUE NOT NULL WHERE email = eid + name + "@company.com", 
-- Prioritise Mobile number to be NOT NULL whereas the rest are optional.
	contact_mobile INTEGER NOT NULL,
	contact_home INTEGER DEFAULT NULL,
	contact_office INTEGER DEFAULT NULL,
-- Resigned Date is NULL by Default and only when an employeee resigns is it updated.
	resigned_date DATE DEFAULT NULL,
	dept_id INTEGER NOT NULL,
	FOREIGN KEY (dept_id) REFERENCES Departments(did) ON DELETE CASCADE
);

CREATE TABLE Juniors (
	eid INTEGER PRIMARY KEY,
	FOREIGN KEY (eid) REFERENCES Employees (eid) ON DELETE CASCADE
);

CREATE TABLE Bookers (
	eid INTEGER PRIMARY KEY,
	FOREIGN KEY (eid) REFERENCES Employees (eid) ON DELETE CASCADE
);

CREATE TABLE Seniors (
	eid INTEGER PRIMARY KEY,
	FOREIGN KEY (eid) REFERENCES Bookers (eid) ON DELETE CASCADE
);

CREATE TABLE Managers (
	eid INTEGER PRIMARY KEY,
	FOREIGN KEY (eid) REFERENCES Bookers (eid) ON DELETE CASCADE
);

-- Departments

CREATE TABLE Departments (
	did INTEGER PRIMARY KEY,
	dname TEXT NOT NULL
);

-- Meeting Rooms

CREATE TABLE MeetingRooms (
	room INTEGER,
	floor INTEGER,
	rname TEXT NOT NULL,
	dep_id INTEGER NOT NULL,
	PRIMARY KEY(room, floor),
	FOREIGN KEY(dep_id) REFERENCES Departments(did) ON DELETE CASCADE
);

CREATE TABLE Updates (
	udate DATE,
	new_cap INTEGER check (new_cap > 0),
-- We use check here for the constraint that there should be minimum 1 person inside the Meeting Room.
	room_id INTEGER,
	floor_id INTEGER,
	manager_id INTEGER,
	PRIMARY KEY(date, room_id, floor_id, manager_id),
	FOREIGN KEY(room_id, floor_id) REFERENCES MeetingRooms(room, floor) 
			ON DELETE CASCADE,f
	FOREIGN KEY(manager_id) REFERENCES Managers(eid) ON DELETE CASCADE
);

-- Booking Sessions

CREATE TABLE Sessions (
  -- session instance information
  sess_time TIME,
  sess_date DATE,

  -- session venue (meeting room 'from')
  room_id INTEGER,
  floor_id INTEGER,

  -- employees involved in the booking 
  -- all session on default are not booked and approved yet
  booked_by_eid INTEGER NOT NULL,
  approved_by_eid INTEGER DEFAULT NULL,

	PRIMARY KEY(room_id, floor_id, sess_time, sess_date) ,
  FOREIGN KEY(room_id, floor_id) REFERENCES MeetingRooms(room, floor) 
	  ON DELETE CASCADE, 
  FOREIGN KEY(booked_by_eid ) REFERENCES Bookers(eid) 
	  ON DELETE CASCADE, 
  FOREIGN KEY(approved_by_eid ) REFERENCES Managers(eid) 
	  ON DELETE CASCADE
);

CREATE TABLE Joins (
	eid INTEGER,
	sess_time TIME,
  sess_date DATE,
  room_id INTEGER,
  floor_id INTEGER,

	PRIMARY KEY (eid, sess_time, sess_date, room),
	FOREIGN KEY(eid) REFERENCES Employees(eid)
	  ON DELETE CASCADE,
	FOREIGN KEY(sess_time, sess_date, room_id, floor_id) REFERENCES Sessions(sess_time, sess_date, room_id, floor_id) ON DELETE CASCADE
);

-- Extra tables for functions? cos approved_by_eid = Approves and booked_by_eid = Books, technically don't need Approves and Books tables** 

  room_id INTEGER NOT NULL 
  floor_id INTEGER NOT NULL

  -- employees involved in the booking 
  -- all session on default are not booked and approved yet
  booked_by_eid INTEGER NOT NULL

  FOREIGN KEY(sess_time, sess_date, room_id, floor_id, booked_by_eid) 
    REFERENCES Sessions(sess_time, sess_date, room_id, floor_id, booked_by_eid) 
	    ON DELETE CASCADE, 
);

-- Health Declaration

CREATE TABLE HealthDeclarations (
	eid INTEGER REFERENCES Employees (eid) ON DELETE CASCADE,
	ddate DATE,
	temperature FLOAT CHECK (temperature BETWEEN 34 AND 43) NOT NULL,
	fever BOOLEAN GENERATED ALWAYS AS (temperature > 37.5) STORED,
	PRIMARY KEY (eid, ddate)
);

------------------------------------

-- FUNCTIONS AND PROCEDURES

------------------------------------

-- Employees

CREATE OR REPLACE PROCEDURE add_employee (name TEXT, contact INTEGER, kind TEXT, department TEXT) AS $$
DECLARE
	_eid INTEGER;
	_email TEXT;
	_did INTEGER;
BEGIN 
	SELECT COUNT(*) INTO _eid FROM Employees;
  _eid := _eid + 1;
	SELECT did INTO _did FROM Departments WHERE dname = department;
	INSERT INTO Employees (ename, contact_mobile, dept_id)
	    VALUES (name, contact, _did);

    CASE (kind)
      WHEN "Junior" THEN
        INSERT INTO Juniors (eid) VALUES (_eid);

      WHEN "Senior" THEN
        INSERT INTO Bookers (eid) VALUES (_eid);
        INSERT INTO Seniors (eid) VALUES (_eid);

      WHEN "Manager" THEN
        INSERT INTO Bookers (eid) VALUES (_eid);
        INSERT INTO Manager (eid) VALUES (_eid);
      
      ELSE
      END CASE;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE remove_employee (employee_id INTEGER, last_day DATE) AS $$
DECLARE
BEGIN 
	UPDATE Employees
	SET resigned_date = last_day
	WHERE eid = employee_id;
	
  --- remove future sessions booked by employee
	DELETE FROM Sessions
	WHERE sess_date > last_day AND booked_by_eid = employee_id;
	
	--- remove approval for future sessions
	UPDATE Sessions
	SET approved_by_eid IS NULL 
  WHERE sess_date > last_day AND approved_by_eid = employee_id;

  --- remove participation in future meetings
	DELETE from Joins
	WHERE sess_date > last_day AND eid = employee_id;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION view_booking_report (start_date DATE, employee_id INTEGER) 
RETURNS TABLE (floor_no INTEGER, room_no INTEGER, sess_date DATE, sess_time TIME, approved BOOLEAN) AS $$
BEGIN 

	SELECT floor_id, room_id, sess_date, sess_time, CASE 
	 		WHEN approved_by_eid IS NOT NULL THEN TRUE
	    	ELSE FALSE
	  		END AS approved
	FROM Sessions 
	WHERE booked_by_eid = employee_id AND sess_date > start_date
  ORDER BY sess_date ASC, sess_time ASC;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION view_future_meeting (start_date DATE, employee_id INTEGER) 
RETURNS TABLE (floor_no INTEGER, room_no INTEGER, sess_date DATE, sess_time TIME) AS $$
BEGIN 
RETURN QUERY

SELECT floor_id, room_id, sess_date, sess_time
 FROM Joins NATURAL JOIN Sessions
 WHERE eid = employee_id AND sess_date > start_date AND approved_by_eid IS NOT NULL
 ORDER BY sess_date ASC, sess_time ASC;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE add_department (id INTEGER, name TEXT) AS $$
BEGIN
	INSERT INTO Departments
		    VALUES (id, name);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE remove_department (id INTEGER) AS $$
BEGIN
	DELETE FROM Departments
	WHERE did = id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE add_room (floorid INTEGER, roomid INTEGER,
roomname TEXT, roomcap INTEGER, depid INTEGER, mid INTEGER, _date DATE) AS $$
BEGIN
	INSERT INTO MeetingRooms
	    VALUES (roomid, floorid, roomname, depid);

	CALL change_capacity(floorid, roomid, roomcap, CURRENT_DATE, mid);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE change_capacity (floorid INTEGER, roomid INTEGER,
roomcap INTEGER, _date DATE, mid INTEGER) AS $$
BEGIN
	INSERT INTO Updates
		VALUES (_date, roomcap, roomid, floorid, mid);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_room(IN cap INTEGER, _date DATE, 
start_t TIME, end_t TIME)
RETURNS TABLE(floorid INTEGER, roomid INTEGER, 
depid INTEGER, roomcap INTEGER) AS $$
BEGIN
	WITH UpdatedUpdates AS (
			SELECT u1.floor_id AS fid, u1.room_id AS rid, u1.new_cap AS cap
			FROM Updates u1 INNER JOIN (
	    SELECT u2.floor_id, u2.room_id, MIN(u2.udate) as MinDate
	    FROM Updates u2
	    GROUP BY u2.floor_id, u2.room_id
			) u2 on u1.floor_id = u2.floor_id AND u1.room_id = u2.room_id 
				AND u1.udate = u2.MaxDate),
			RoomInfo AS (
			SELECT m.floor_id AS flrid, m.room_id AS rmid, u.cap AS ncap, m.dep_id AS depid
			FROM MeetingRooms m JOIN UpdatedUpdates u
			ON m.floor = u.fid AND m.room = u.rmid )
	(SELECT r.flrid, r.mid, r.depid, r.ncap 
	FROM RoomInfo
	ORDER BY r.ncap ASC)
	EXCEPT
	(SELECT r.flrid, r.rmid, r.depid, r.ncap 
	FROM RoomInfo r, Sessions s
	WHERE r.flrid = s.floor_id AND r.rmid = s.room_id AND s.approved_by_eid IS NOT NULL
	AND s.sess_time >= start_t AND s.sess_time < end_t)
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE book_room(start_hour TIME, end_hour TIME, meeting_date DATE, room_no INTEGER, floor_no INTEGER, _eid INTEGER) 
AS $$

DECLARE 
	is_booker Boolean 

BEGIN 

-- Employee is Booker or not
SELECT
	CASE WHEN EXISTS 
		(SELECT eid
			FROM Bookers 
			WHERE eid = _eid)
		THEN 1
		ELSE 0 
	END
 

-- Employee is having fever or is close contact or not
-- Employee is resigned or not
INSERT INTO Sessions(sess_time, sess_date, room_id, floor_id, booked_by_eid)
VALUES start_hour, meeting_date, room_no, floor_no , eid);

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE unbook_room(start_hour TIME, end_hour TIME, meeting_date DATE, room_no INTEGER, floor_no INTEGER, eid INTEGER) 
AS $$
BEGIN 

-- need to check if the person who wants to unbook the room is the same person who wbooked the room previously 
DELETE FROM Sessions 
WHERE start_hour = sess_time AND meeting_date = sess_date 
	AND room_id = room_no AND floor_id = floor_no AND booked_by_eid = eid

-- need to check the join table and remove the employees who join 
DELETE FROM Joins 
WHERE start_hour = sess_time AND meeting_date = sess_date AND room_id = room_no AND floor_id = floor_no;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE join_meeting(floor_number INTEGER, room_number INTEGER, meeting_date DATE, start_hour TIME, end_hour TIME, employee_id INTEGER) 
AS $$
DECLARE
	is_approved INTEGER;
BEGIN 

-- check if employee is allowed to join -> probaobly the health constraints
-- check resign or not 

-- check if the meeting is already approved -> if approved cannot join 
SELECT approved_by_eid INTO is_approved 
FROM Sessions 
WHERE start_hour = sess_time AND meeting_date = sess_date 
	AND room_id = room_no AND floor_id = floor_no;

	IF is_approved IS NULL THEN
		INSERT INTO Joins (eid, sess_time, sess_date, room_id, floor_id)
		VALUES employee_id, start_hour, meeting_date, room_number, floor_number 
	ELSE
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE leave_meeting(floor_number INTEGER, room_number INTEGER, meeting_date DATE, start_hour TIME, end_hour TIME, emnployee_id INTEGER) 
AS $$

DECLARE
	is_approved INTEGER;
BEGIN 

-- check if the meeting is already approved -> if approved cannot leave
SELECT approved_by_eid INTO is_approved 
FROM Sessions 
WHERE start_hour = sess_time AND meeting_date = sess_date 
	AND room_id = room_no AND floor_id = floor_no;

IF is_approved IS NULL THEN
	DELETE FROM Joins 
	WHERE eid = employee_id AND sess_time AND sess_date = meeting_date AND room_id = room_number AND floor_id = floor_number
ELSE
END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE approve_meeting(floor_number INTEGER, room_number INTEGER, meeting_date DATE, start_hour TIME, end_hour TIME, eid INTEGER) 
AS $$
BEGIN 

-- need to check if the employee is allowed to approve? 

-- create a new session in Sessions 
UPDATE Sessions (sess_time, sess_date, room_id, floor_id, approved_by_eid)
SET approved_by_eid = eid 
WHERE sess_time = start_hour AND sess_date = meeting_data AND room_id = room_number AND floor_id = floor_number;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE declare_health 
	(eid INT, ddate DATE, temp FLOAT)
AS $$
	INSERT INTO healthdeclarations VALUES (eid, ddate, temp);
$$ LANGUAGE sql ;


CREATE OR REPLACE FUNCTION contact_tracing ( trace_eid INT, trace_date DATE )
RETURNS TABLE ( cc_eid INT, cc_date DATE ) AS $$
DECLARE
	--Latest and earliest close contact dates
	min_cc_date DATE;
	max_cc_date DATE;
BEGIN
	--Check if fever is declared on trace_date
	IF NOT EXISTS (SELECT 1
		FROM healthdeclarations hd
		WHERE hd.eid = eid
			AND hd.ddate = trace_date
			AND hd.fever = TRUE) THEN
		RETURN;
	END IF;

	min_cc_date := trace_date - 3;
	max_cc_date := trace_date;

	--Remove future meetings for employee with fever
	DELETE FROM Sessions
	WHERE booked_by_eid = trace_eid
		AND sess_date >= CURRENT_DATE;

	DELETE FROM Joins
	WHERE j.eid = trace_eid
		AND sess_date >= CURRENT_DATE;
	
	--Remove future meetings for close contacts for next 7 days
	FOR cc_eid, cc_date IN
		SELECT j.eid, MAX(j.date) --Latest meeting in close contact
		FROM Joins j NATURAL JOIN Sessions s NATURAL JOIN Joins trace_j
		WHERE trace_j.eid = trace_eid
			AND j.eid <> trace_eid
			AND s.sess_date BETWEEN min_cc_date AND max_cc_date
		GROUP BY j.eid
	LOOP
		DELETE FROM Sessions
		WHERE booked_by_eid = cc_eid
			AND sess_date BETWEEN CURRENT_DATE AND cc_date + 7;

		DELETE FROM Joins
		WHERE eid = cc_eid
			AND sess_date BETWEEN CURRENT_DATE AND cc_date + 7;
	END LOOP;

	--Return close contact eids and their respective close contact dates
	RETURN QUERY
		SELECT j.eid, MAX(j.date) --Latest meeting in close contact
		FROM Joins j NATURAL JOIN Sessions s NATURAL JOIN trace_j
		WHERE trace_j.eid = trace_eid
			AND j.eid <> trace_eid
			AND s.sess_date BETWEEN min_cc_date AND max_cc_date
		GROUP BY j.eid;
END
$$ LANGUAGE plpgsql ;


CREATE OR REPLACE FUNCTION view_manager_report ( man_eid INT, start_date DATE)
RETURNS TABLE ( floor_id INT, room_id INT, sess_date DATE, sess_time TIME, booked_by_eid INT) AS $$
DECLARE
	man_did INT;
BEGIN
	IF man_eid NOT IN (SELECT eid FROM Managers) THEN RETURN;
	END IF;
	
	SELECT did INTO man_did FROM Employees WHERE eid = man_eid;

	RETURN QUERY
		SELECT s.floor_id, s.room_id, s.sess_date, s.sess_time, s.booked_by_eid
		FROM Sessions s, MeetingRooms mr
		WHERE s.floor_id = mr.floor_id
			AND s.room_id = mr.room_id
			AND mr.dep_id = man_did
			AND s.approved_by_eid IS NULL
			AND s.sess_date >= start_date
		ORDER BY s.sess_date ASC, s.sess_time ASC;
END
$$ LANGUAGE plpgsql ;