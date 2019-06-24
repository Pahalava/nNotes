CREATE DATABASE IF NOT EXISTS nnotes;

USE nnotes;

CREATE TABLE IF NOT EXISTS notes(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	group_id INT NOT NULL,
	reminder_id INT NOT NULL,
	active TINYINT NOT NULL DEFAULT 1,
	created_on DATE NOT NULL DEFAULT NOW(),
	effective_from DATE,
	disp_order INT NOT NULL DEFAULT 0,
	notes_type VARCHAR(1) NOT NULL, -- T: Tasks, L: Lists
	FOREIGN KEY(group_id) REFERENCES groups(id),
	FOREIGN KEY(reminder_id) REFERENCES reminders(id)
);

CREATE TABLE IF NOT EXISTS groups(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	disp_order INT NOT NULL DEFAULT 0,
	active TINYINT NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS reminders(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL, 
	params VARCHAR(100), --(for future use)
	frequency TINYINT NOT NULL DEFAULT 0, -- increment by 1 for each usage, max 4 values: display on screen, others: display under more reminders option
	active TINYINT NOT NULL DEFAULT 1
);
	
--reminders 
	--Note:
		-- a) Week start day is Monday as 1. 
		-- b) M-1, T-2, W-3, T-4, F-5, S-6, S-7
		-- c) Weekday<=5, Weekend>5
		-- d) alternate_weekdays 1: [M, W, F] (Odd numbers based on b) 2: T, T (Even numbers based on b)
		-- e) all reminders are based on the task created_on value
INSERT INTO reminders(name) VALUES('none');
INSERT INTO reminders(name) VALUES('daily');
INSERT INTO reminders(name) VALUES('alternate_days');
INSERT INTO reminders(name) VALUES('all_weekdays');
INSERT INTO reminders(name) VALUES('alternate_weekdays');
INSERT INTO reminders(name) VALUES('weekends');
INSERT INTO reminders(name) VALUES('once_weekly');
INSERT INTO reminders(name, active) VALUES('bi_weekly', 0); -- need addtional data. (for future use)
INSERT INTO reminders(name) VALUES('fortnightly');
INSERT INTO reminders(name) VALUES('once_monthly');
INSERT INTO reminders(name) VALUES('last-day_monthly');
INSERT INTO reminders(name) VALUES('last-weekday_monthly');
INSERT INTO reminders(name, active) VALUES('bi_monthly', 0); -- need addtional data. (for future use)
INSERT INTO reminders(name) VALUES('quaterly');
INSERT INTO reminders(name) VALUES('yearly');
	
CREATE TABLE IF NOT EXISTS notifications(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	notes_id INT NOT NULL, 
	next_reminder DATE NOT NULL,
	active TINYINT NOT NULL DEFAULT 1,
	FOREIGN KEY(notes_id) REFERENCES notes(id)
);

CREATE TABLE IF NOT EXISTS tags(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(200) NOT NULL,  
	active TINYINT NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS map_tags_notes(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	notes_id INT NOT NULL, 
	tags_id INT NOT NULL,
	FOREIGN KEY(notes_id) REFERENCES notes(id),
	FOREIGN KEY(tags_id) REFERENCES tags(id)
);
	
CREATE TABLE IF NOT EXISTS list_items(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	status TINYINT NOT NULL DEFAULT 0,
	notes_id INT NOT NULL,
	disp_order INT NOT NULL DEFAULT 0,
	FOREIGN KEY(notes_id) REFERENCES notes(id)
);

COMMIT;