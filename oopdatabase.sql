CREATE DATABASE travel_erp;
USE travel_erp;
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
        ON DELETE SET NULL
);
CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    map_link TEXT
);
CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES countries(id)
        ON DELETE CASCADE
);
CREATE TABLE places (
    place_id INT AUTO_INCREMENT PRIMARY KEY,
    place_name VARCHAR(100) NOT NULL,
    city_id INT,
    description TEXT,
    visit_count INT DEFAULT 0,
    price_level INT CHECK (price_level BETWEEN 1 AND 5),
    FOREIGN KEY (city_id) REFERENCES cities(id)
        ON DELETE CASCADE
);
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    place_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);
CREATE TABLE budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DOUBLE NOT NULL,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);
CREATE TABLE budget_places (
    id INT AUTO_INCREMENT PRIMARY KEY,
    budget_id INT,
    place_id INT,
    estimated_cost DOUBLE,
    FOREIGN KEY (budget_id) REFERENCES budgets(budget_id)
        ON DELETE CASCADE,
    FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE
);
CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    place_id INT,
    amount DOUBLE,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE
);
INSERT INTO roles (role_name)
VALUES ('ADMIN'), ('USER');

INSERT INTO users (username, password, role_id)
VALUES 
('admin', '1234', 1),
('user1', '1234', 2);

INSERT INTO countries (name, map_link)
VALUES ('Egypt', 'https://maps.google.com');

INSERT INTO cities (name, country_id)
VALUES ('Cairo', 1), ('Alexandria', 1);

INSERT INTO places (place_name, city_id, description, visit_count, price_level)
VALUES 
('Pyramids', 1, 'Famous historical site', 100, 5),
('Bibliotheca Alexandrina', 2, 'Modern library', 80, 4);

INSERT INTO reviews (place_id, user_id, rating, comment)
VALUES 
(1, 1, 5, 'Amazing!'),
(1, 2, 4, 'Very nice'),
(2, 2, 5, 'Beautiful place');

SELECT * FROM users;
SELECT * FROM places;
SELECT * FROM reviews;

SELECT AVG(rating) 
FROM reviews 
WHERE place_id = 1;


