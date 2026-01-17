CREATE USER 'skills-ez'@'localhost' IDENTIFIED BY '90b4SkillsEZ&&';
GRANT ALL PRIVILEGES ON *.* TO 'skills-ez'@'localhost';
FLUSH PRIVILEGES;


ALTER USER 'skills-ez'@'localhost' IDENTIFIED WITH mysql_native_password BY '90b4SkillsEZ&&';
FLUSH PRIVILEGES;