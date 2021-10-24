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
