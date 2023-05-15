SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Update species to unspecified
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Classify species into digimon and pokemon 
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species != 'digimon';
COMMIT;

-- Update multiple columns of the animals table
BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT ezra_clinic;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO ezra_clinic;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Queries to answer the quetions
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight) FROM animals;

SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Query multiple tables 
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM animals a
JOIN owners o ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- JOIN TABLE
SELECT a.name AS last_animal_visit
FROM visits v
JOIN vets vet ON vet.id = v.vet_id
JOIN animals a ON a.id = v.animal_id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT (DISTINCT v.animal_id) AS animal_count
FROM visits v
JOIN vets vet ON vet.id = v.vet_id
WHERE vet.name = 'Stephanie Mendez';

SELECT vet.id, vet.name, specialty.name AS specialty
FROM vets vet
LEFT JOIN specializations spec ON vet.id = spec.vet_id
LEFT JOIN species specialty ON spec.species_id = specialty.id;

SELECT a.id, a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet_id
WHERE vet.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.id, a.name, COUNT(*) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.id, a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name, v.visit_date AS first_visit_date
FROM visits v
JOIN vets vet ON vet.id = v.vet_id
JOIN animals a ON a.id = v.animal_id
WHERE vet.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

SELECT a.name AS animal_name, vet.name AS vet_name, v.visit_date AS visit_date
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id
LEFT JOIN specializations spec ON vet.id = spec.vet_id AND a.species_id = spec.species_id
WHERE spec.vet_id IS NULL;

SELECT s.name AS species_name, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN species s ON a.species_id = s.id
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';


