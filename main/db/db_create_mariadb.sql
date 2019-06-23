CREATE DATABASE IF NOT EXISTS ntasks;

USE ntasks;

CREATE TABLE IF NOT EXISTS tasks(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(100) NOT NULL,
		group_id INT NOT NULL,
		reminder_id INT NOT NULL,
		active TINYINT NOT NULL DEFAULT 1,
		created_on DATE NOT NULL DEFAULT NOW(),
		FOREIGN KEY(group_id) REFERENCES groups(id),
		FOREIGN KEY(reminder_id) REFERENCES reminders(id)
	);
	
	
CREATE TABLE IF NOT EXISTS groups(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(100) NOT NULL,
		active TINYINT NOT NULL DEFAULT 1
	);

CREATE TABLE IF NOT EXISTS reminders(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(200) NOT NULL, 
		--params VARCHAR(100), --(for future)
		frequency TINYINT NOT NULL DEFAULT 0, -- Is frequently used? if 1: display on screen, 0: display under more reminders option
		active TINYINT NOT NULL DEFAULT 1
	);
	
--reminders 
	--Note:
		-- a) Week start day is Monday as 1. 
		-- b) M-1, T-2, W-3, T-4, F-5, S-6, S-7
		-- c) Weekday<=5, Weekend>5
		-- d) alternate_weekdays 1: [M, W, F] (Odd numbers based on b) 2: T, T (Even numbers based on b)
		-- e) all reminders are based on the task created_on value
INSERT INTO reminders(id, name) VALUES(0, 'none');
INSERT INTO reminders(id, name) VALUES(0, 'daily');
INSERT INTO reminders(id, name) VALUES(0, 'alternate_days');
INSERT INTO reminders(id, name) VALUES(0, 'all_weekdays');
INSERT INTO reminders(id, name) VALUES(0, 'alternate_weekdays');
INSERT INTO reminders(id, name) VALUES(0, 'weekends');
INSERT INTO reminders(id, name) VALUES(0, 'once_weekly');
--INSERT INTO reminders(id, name) VALUES(0, 'bi_weekly'); -- need addtional data. (for future)
INSERT INTO reminders(id, name) VALUES(0, 'fortnightly');
INSERT INTO reminders(id, name) VALUES(0, 'once_monthly');
INSERT INTO reminders(id, name) VALUES(0, 'last-day_monthly');
INSERT INTO reminders(id, name) VALUES(0, 'last-weekday_monthly');
--INSERT INTO reminders(id, name) VALUES(0, 'bi_monthly'); -- need addtional data. (for future)
INSERT INTO reminders(id, name) VALUES(0, 'quaterly');
INSERT INTO reminders(id, name) VALUES(0, 'yearly');
	
CREATE TABLE IF NOT EXISTS notifications(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		tasks_id INT NOT NULL, 
		next_reminder DATE NOT NULL,
		active TINYINT NOT NULL DEFAULT 1,
		FOREIGN KEY(tasks_id) REFERENCES tasks(id)
	);
	
CREATE TABLE IF NOT EXISTS tags(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		name INT NOT NULL, 
		active TINYINT NOT NULL DEFAULT 1
	);
	
CREATE TABLE IF NOT EXISTS map_tags_tasks(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		tasks_id INT NOT NULL, 
		tags_id INT NOT NULL,
		FOREIGN KEY(tasks_id) REFERENCES tasks(id),
		FOREIGN KEY(tags_id) REFERENCES tags(id)
	);

COMMIT;