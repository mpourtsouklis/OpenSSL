-- Create a database named GDPR in the MariaDB database management system
CREATE DATABASE GDPR;

-- Create a table named users that stores username, password, and description for each user
CREATE TABLE GDPR.users (
    username VARCHAR(255), 
    password VARCHAR(255),
    description TEXT, 
    PRIMARY KEY(username) 
    );

-- Insert into the users table 2 users, with names being admin and my student ID
INSERT INTO GDPR.users (username) VALUES ('admin');
INSERT INTO GDPR.users (username) VALUES (3190138);

-- Insert passwords for the 2 users into the users table, hashed with salt using the CRYPT_BLOWFISH algorithm
UPDATE GDPR.users SET password='$2y$10$8Wg3gb8tjUjUekusAysiourJxWkiC6WYW.YokXXQYD1bxSlEGLjgS' WHERE username='admin';
UPDATE GDPR.users SET password='$2y$10$nrDjG46cp9l8ac8a9m8upuF5ZQSQFE0vcj0pcdoYUJ81jc/E1NCcu' WHERE username='3190138';

-- Create a table named logging to store username, login attempts, and timestamp for each user
CREATE TABLE GDPR.logging (
    username VARCHAR(255) NOT NULL,
    tries INT DEFAULT 0, 
    last_try TIMESTAMP, 
    PRIMARY KEY (username)
    );

-- Insert logging data for the 2 users
INSERT INTO GDPR.logging (username) VALUES ('admin');
INSERT INTO GDPR.logging (username) VALUES ('3190138');

-- Modify the users table to also store the account status and timestamp of the last password change
ALTER TABLE GDPR.users ADD locked TINYINT(1) DEFAULT 0;
ALTER TABLE GDPR.users ADD last_password_change TIMESTAMP;