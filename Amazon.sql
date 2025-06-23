create database Amazon;
use Amazon;
CREATE TABLE signin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE
);
INSERT INTO signin (username, password, email)
VALUES ('Sami', MD5('0plm0plm'), 'samkhan123.com'),
 ('Sumaiya', MD5('sumaiya123'), 'sumaiya@example.com'),
  ('Akshata', MD5('akshata123'), 'akshata@example.com'),
  ('Maaz', MD5('maaz123'), 'maaz@example.com'),
  ('Rohit', MD5('rohit123'), 'rohit@example.com');

DELIMITER //

CREATE PROCEDURE signup_or_login(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(300),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE existing_user INT;

    -- Checking if the user already exists
    SELECT COUNT(*) INTO existing_user
    FROM signin
    WHERE username = p_username;

    IF existing_user = 0 THEN
        -- User not found: Register them
        INSERT INTO signin (username, password, email)
        VALUES (p_username, MD5(p_password), p_email);
        SELECT 'Registration successful. Please log in.' AS message;

    ELSE
        
        IF EXISTS (
            SELECT 1 FROM signin
            WHERE username = p_username AND password = MD5(p_password)
        ) THEN
            SELECT 'Login successful. Welcome!' AS message;
        ELSE
            SELECT 'Login failed. Incorrect password.' AS message;
        END IF;

    END IF;
END//

DELIMITER ;

call signup_or_login('Sami','0plm0plm', 'samkhan123.com');
call signup_or_login('Akshata','0plm0plm', 'samkhan123.com');

drop procedure signup_or_login;


drop table signin;
select * from signin;

