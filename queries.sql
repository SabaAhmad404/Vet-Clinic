-- Find all animals whose name ends in "mon".
SELECT * 
FROM animals
WHERE name LIKE '%mon'

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE (date_of_birth) between '2016-01-01' and '2019-12-31'

-- List the name of all animals that are neutered and have less than 3 escape attempts.

select name
from animals
where neutered=true and escape_attempts <3

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

select date_of_birth,name
from animals
where name='Agumon'or name='pikachu'

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
From animals
where weight_kg >10.5

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
