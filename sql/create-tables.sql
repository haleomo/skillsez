DROP DATABASE IF EXISTS SKILLS_EZ;
CREATE DATABASE SKILLS_EZ;

USE SKILLS_EZ;


/*
DROP TABLE query_profile;
DROP TABLE skillsez_user;   
Drop TABLE query_result;
*/


-- CREATE USER 'rob'@'ipad.lan' IDENTIFIED BY '90b4MySQL&&';
-- GRANT ALL PRIVILEGES ON skills_ez.* TO 'rob'@'ipad.lan';
CREATE TABLE IF NOT EXISTS skillsez_user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    created_at DATE DEFAULT (CURRENT_DATE)
);

ALTER TABLE skillsez_user ADD CONSTRAINT UNI_USER_EMAIL UNIQUE (email, last_name);

CREATE TABLE IF NOT EXISTS query_profile (
    id INT NOT NULL AUTO_INCREMENT KEY,
    user_id INT NOT NULL,
    query_date DATE DEFAULT (CURRENT_DATE),
    query_text TEXT NULL,
    source_discipline VARCHAR(100) NOT NULL,
    subject_education_level VARCHAR(100) NOT NULL,
    subject_work_experience VARCHAR(100) NOT NULL,
    subject_discipline VARCHAR(100) NOT NULL,
    topic VARCHAR(100) NOT NULL,
    goal VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES skillsez_user(id),
);

ALTER TABLE QUERY_PROFILE ADD CONSTRAINT UNI_QUERY_PROFILE UNIQUE (user_id, source_discipline, subject_discipline, goal, role);

CREATE TABLE IF NOT EXISTS query_result (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    query_result_nickname VARCHAR(100) NOT NULL, /* User can add a name to the plan so they can pull it back up later */
    query_id INT NOT NULL,
    result_text TEXT NOT NULL,
    result_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (query_id) REFERENCES query_profile(id)
);

ALTER TABLE query_result ADD CONSTRAINT UNI_QUERY_RESULT UNIQUE (query_id, query_result_nickname);  


DROP VIEW IF EXISTS user_query_view;
DROP VIEW IF EXISTS user_query_result_view;

CREATE VIEW IF NOT EXISTS user_query_view AS
SELECT  u.id AS user_id, u.email, u.last_name, u.created_at, 
        q.id AS query_id, q.query_date, q.query_text, q.source_discipline, 
        q.subject_education_level, q.subject_work_experience, q.subject_discipline, 
        q.topic, q.goal, q.role
FROM skillsez_user u
JOIN query_profile q ON u.id = q.user_id;

CREATE VIEW IF NOT EXISTS user_query_result_view AS
SELECT  u.email, u.last_name, 
r.id AS result_id, r.query_id as query_id, r.query_result_nickname, r.result_text, r.result_date
FROM skillsez_user u
JOIN query_profile q ON u.id = q.user_id
JOIN query_result r ON q.id = r.query_id;

INSERT INTO skillsez_user (email, last_name) VALUES ('test@example.com', 'Test');
INSERT INTO query_profile (user_id, source_discipline, subject_education_level, subject_work_experience, subject_discipline, topic, goal, role) VALUES (1, 'Computer Science', 'Bachelor', '2 years', 'Software Engineering', 'Machine Learning', 'Improve skills', 'Developer');
INSERT INTO query_result (query_id, query_result_nickname, result_text) VALUES (1, 'Test Result', 'This is a test result.');
