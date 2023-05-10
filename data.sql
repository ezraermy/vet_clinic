INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11),
    ('Charmander', '2020-02-08', 0, false, -11.0, 'Lizard'),
    ('Plantmon', '2021-11-15', 2, true, -5.7, 'unknown'),
    ('Squirtle', '1993-04-02', 3, false, -12.13, 'Turtle'),
    ('Angemon', '2005-06-12', 1, true, -45, 'Human'),
    ('Boarmon', '2005-06-07', 7, true, 20.4, 'Mammal'),
    ('Blossom', '1998-10-13', 3, true, 17, 'Plant'),
    ('Ditto', '2022-05-14', 4, true, 22, 'unknown');

INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE animals
SET species_id = species.id
FROM species
WHERE animals.name LIKE '%mon' AND species.name = 'Digimon';

UPDATE animals
SET species_id = species.id
FROM species
WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';


UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';

