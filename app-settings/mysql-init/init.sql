CREATE DATABASE IF NOT EXISTS your_database;
CREATE USER IF NOT EXISTS 'your_user'@'%' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON your_database.* TO 'your_user'@'%';
FLUSH PRIVILEGES;
