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