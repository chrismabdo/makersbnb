CREATE TABLE requests (request_id SERIAL PRIMARY KEY, space_id INTEGER REFERENCES spaces(space_id), guest_id INTEGER REFERENCES users(user_id), dates VARCHAR(60));
