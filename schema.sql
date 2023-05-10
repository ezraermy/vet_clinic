CREATE TABLE animals(
  id SERIAL PRIMARY KEY,
  name VARCHAR (255) NOT NULL,
  date_of_birth DATE NOT NULL,
  espcape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL (5, 2) NOT NULL,
)

ALTER TABLE animals ADD species VARCHAR(255);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name TEXT,
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER;

ALTER TABLE animals 
ADD CONSTRAINT fk_species_id 
FOREIGN KEY (species_id) 
REFERENCES species (id);


ALTER TABLE animals ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
FOREIGN KEY (owner_id)
REFERENCES owners (id);