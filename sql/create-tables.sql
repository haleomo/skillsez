CREATE TABLE IF NOT EXISTS skillsez_user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    created_at DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS query_profile (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    query_date DATE DEFAULT (CURRENT_DATE),
    query_text TEXT NOT NULL,
    source_discipline VARCHAR(100) NOT NULL,
    subjecteducation_level VARCHAR(100) NOT NULL,
    subject_discipline VARCHAR(100) NOT NULL,
    topic VARCHAR(100) NOT NULL,
    goal VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES skillsez_user(id)
);

CREATE TABLE IF NOT EXISTS query_result (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    query_result_nickname VARCHAR(100) NOT NULL, /* User can add a name to the plan so they can pull it back up later */
    query_id INT NOT NULL,
    result_text TEXT NOT NULL,
    result_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (query_id) REFERENCES query_profile(id)
);



CREATE VIEW IF NOT EXISTS user_query_view AS
SELECT  u.id AS user_id, u.email, u.last_name, u.created_at, 
        q.id AS query_id, q.query_date, q.query_text, q.source_discipline, 
        q.subjecteducation_level, q.subject_discipline, q.topic, q.goal, 
        q.role
FROM skillsez_user u
JOIN query_profile q ON u.id = q.user_id;

CREATE VIEW IF NOT EXISTS user_query_result_view AS
SELECT  u.email, u.last_name, 
r.query_result_nickname, r.result_text, r.result_date
FROM skillsez_user u
JOIN query_profile q ON u.id = q.user_id
JOIN query_result r ON q.id = r.query_id;