CREATE TABLE spaces (
    space_id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    description VARCHAR(240),
    price VARCHAR(60),
    user_id INTEGER REFERENCES users(user_id)
);