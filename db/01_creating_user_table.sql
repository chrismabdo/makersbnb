CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(60),
    user_email VARCHAR(60),
    user_password VARCHAR(60)
);