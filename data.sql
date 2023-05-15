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

-- JOIN TABLE
-- Insert data to the vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES 
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1);

SELECT id FROM vets WHERE name = 'Stephanie Mendez';

INSERT INTO specializations (vet_id, species_id)
VALUES (3, 1), (3, 2);

SELECT id FROM vets WHERE name = 'Jack Harkness';

INSERT INTO specializations (vet_id, species_id)
VALUES (4, 2);

-- Insert data to the visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 3, '2020-07-22'),
       (2, 4, '2021-02-02'),
       (3, 2, '2020-01-05'),
       (3, 2, '2020-03-08'),
       (3, 2, '2020-05-14'),
       (4, 3, '2021-05-04'),
       (5, 4, '2021-02-24'),
       (6, 2, '2019-12-21'),
       (6, 1, '2020-08-10'),
       (6, 2, '2021-04-07'),
       (7, 3, '2019-09-29'),
       (8, 4, '2020-10-03'),
       (8, 4, '2020-11-04'),
       (9, 2, '2019-01-24'),
       (9, 2, '2019-05-15'),
       (9, 2, '2020-02-27'),
       (9, 2, '2020-08-03'),
       (10, 3, '2020-05-24'),
       (10, 1, '2021-01-11')
ON CONFLICT DO NOTHING;

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, 
generate_series('1980-01-01'::timestamp, '2023-01-01', '1 hour') visit_timestamp ON CONFLICT DO NOTHING;

INSERT INTO owners (full_name, email)
SELECT 'Owner ' || generate_series(1, 2500000), 'owner_' || generate_series(1, 2500000) || '@mail.com';

