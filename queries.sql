-- Find all animals whose name ends in "mon".
SELECT * 
FROM animals
WHERE name LIKE '%mon'

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE (date_of_birth) between '2016-01-01' and '2019-12-31'

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name
FROM animals
WHERE neutered=true and escape_attempts <3

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth,name
FROM animals
WHERE name='Agumon'or name='pikachu'

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
From animals
where weight_kg >'10.5'

-- Find all animals that are neutered.
SELECT  *
From animals
WHERE  neutered= true

-- Find all animals not named Gabumon.
SELECT  *
From animals
WHERE not name ='Gabumon'

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT  *
From animals
WHERE weight_kg between 10.4 and 17.3


-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.


Begin; 
UPDATE animals
set species='unspecified';
Select * from animals;
rollback;
select * from animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

Begin; 
update animals
set species='digimon'
where name like '%mon';
update animals
set species='pokemon'
where species IS  null;
commit;
select * from animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
 Begin; 
 Delete  from animals;
 select * from animals;
 rollback;
 select * from animals;

--  Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

Begin; 
Delete from animals
where date_of_birth > '01-01-2022';
savepoint s1;
update animals
set  weight_kg = weight_kg * -1;
rollback to savepoint s1;
update animals
set weight_kg=weight_kg *-1
where weight_kg < 0;
commit;
select * from animals

-- How many animals are there?
select count(name) from animals

-- How many animals have never tried to escape?

select count(escape_attempts) from animals
where escape_attempts=0;

-- What is the average weight of animals?
select AVG(weight_kg) from animals

-- Who escapes the most, neutered or not neutered animals?
SELECT Max (escape_attempts), neutered from animals
group by neutered

-- What is the minimum and maximum weight of each type of animal?
SELECT Max (weight_kg), Min (weight_kg), species from animals
group by species

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT AVG(escape_attempts), date_of_birth,name, species from animals
WHERE (date_of_birth) between '1990-01-01' and '2000-12-31'
group by species, date_of_birth, name



-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?

select animals.name , owners.full_name from animals, owners where full_name='Melody Pond'
and owners.id=animals.owner_id

-- List of all animals that are pokemon (their type is Pokemon).

select animals.name animals , species.name species from animals, species
where species.id=animals.species_id
and species.name='Pokemon'

-- List all owners and their animals, remember to include those that don't own any animal.

select animals.name animals , owners.full_name owners from animals right outer join owners 
on owners.id=animals.owner_id

-- How many animals are there per species?
select count(animals.name) total_animals ,species.name species from animals inner join species
on species.id=animals.species_id
Group by species.name

-- List all Digimon owned by Jennifer Orwell.
select animals.name animals , owners.full_name owners, species.name from animals inner join owners
on owners.id=animals.owner_id
inner join species on
species.id=animals.species_id
where  species.name='Digimon'
and owners.full_name='Jennifer Orwell' 

-- List all animals owned by Dean Winchester that haven't tried to escape.
select owners.full_name, animals.name , animals.escape_attempts from animals inner join owners
on owners.id=animals.owner_id
where owners.full_name='Dean Winchester'
and animals.escape_attempts=0;
select * from animals

-- Who owns the most animals?

select  count(animals.name) total_animals, owners.full_name from animals inner join owners
on owners.id= animals.owner_id
group by owners.full_name
order by total_animals desc
limit 1



-- queries for many to many relations

-- Who was the last animal seen by William Tatcher?

select animals.name, vets.name, visits.date_of_vists from animals inner join visits on animals.id=visits.animal_id
inner join vets on visits.vets_id=vets.id
where vets.name='William Tatcher'
order by visits.date_of_vists desc
limit 1

-- How many different animals did Stephanie Mendez see?

select count(animals.name), vets.name from animals inner join visits on animals.id=visits.animal_id
inner join vets on visits.vets_id=vets.id
where vets.name='Stephanie Mendez'
group by vets.name


-- List all vets and their specialties, including vets with no specialties.

select vets.name, species.name
from specializations inner join species on specializations.species_id = species.id
right outer join vets on specializations.vets_id = vets.id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

select animals.name, vets.name, visits.date_of_vists from animals inner join visits on animals.id=visits.animal_id
inner join vets on visits.vets_id=vets.id
where vets.name='Stephanie Mendez'
and visits.date_of_vists BETWEEN '01-04-2020' AND '08-30-2020'

-- What animal has the most visits to vets?
Select count(animals.name), vets.name from animals inner join visits on animals.id=visits.animal_id
inner join vets on vets.id= visits.vets_id
group by vets.name
order by count(animals.name) desc
limit 1

-- Who was Maisy Smith's first visit?

Select animals.name, vets.name , visits.date_of_vists from animals inner join visits on animals.id=visits.animal_id
inner join vets on vets.id= visits.vets_id
where vets.name='Maisy Smith'
order by visits.date_of_vists 
limit 1

-- Details for most recent visit: animal information, vet information, and date of visit.


Select animals.name, vets.name , visits.date_of_vists from animals inner join visits on animals.id=visits.animal_id
inner join vets on vets.id= visits.vets_id
order by visits.date_of_vists desc
limit 1


-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(visits.date_of_vists)-(SELECT COUNT(vets.name) 
FROM vets, specializations, animals, visits
WHERE
visits.vets_id = vets.id
AND animals.id = visits.animal_id
AND concat(animals.species_id, visits.vets_id) = concat(specializations.species_id, specializations.vets_id)) total_unspecialized_cases 
FROM visits;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

WITH new AS(
    SELECT DISTINCT(animals.name) animal, COUNT(animals.name) total_visits, vets.name vet
FROM vets, animals, visits
WHERE visits.animal_id = animals.id
AND visits.vets_id = vets.id
AND vets.name = 'Maisy Smith'
GROUP BY animals.name, vet
)
SELECT * FROM new WHERE total_visits = (SELECT MAX(total_visits) FROM new);

