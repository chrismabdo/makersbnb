require 'pg'

def clear_table
  connection = PG.connect(dbname: 'makersbnb_test')

  # Clear the bookmarks table
  result = connection.exec "DROP TABLE spaces"
  result = connection.exec "DROP TABLE users"
  result = connection.exec "CREATE TABLE users (user_id SERIAL PRIMARY KEY, username VARCHAR(60), user_email VARCHAR(60), user_password VARCHAR(60));"
  result = connection.exec "CREATE TABLE spaces (space_id SERIAL PRIMARY KEY, name VARCHAR(60), description VARCHAR(240), price VARCHAR(60), user_id INTEGER REFERENCES users(user_id));"
end
