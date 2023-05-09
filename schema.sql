CREATE TABLE animals(
  id SERIAL PRIMARY KEY,
  name VARCHAR (255) NOT NULL,
  date_of_birth DATE NOT NULL,
  espcape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL (5, 2) NOT NULL,
  species VARCHAR (255) NOT NULL
)