CREATE TABLE animals
(
    id integer,
    name varchar,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg integer
)

ALTER TABLE animals
    ADD COLUMN species text;
    
    -- primary key to animals table

    ALTER TABLE animals ADD primary key (id);	

    -- altering id datatype
    ALTER TABLE animals
ALTER COLUMN id TYPE integer GENERATED ALWAYS AS IDENTITY;

-- remove species colum
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id  INT REFERENCES owners(id);



--  owners table
Create TABLE owners(
id SERIAL primary key,
full_name text,
age integer
)

--   species table
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name string
)


-- many to many relationship start from here


-- vets table
Create Table vets (
id serial primary key,
	name text,
	age integer,
	date_of_graduation date
)

-- specialization

Create Table specializations(
    id serial primary key
  vets_id integer references vets(id),
   species_id  integer references species(id),
)


--  visits
CREATE TABLE visits(
    id serial primary key
   animal_id integer references animals(id),
	vets_id integer references vets(id),
	date_of_vists date,
	
)


-- queries performance start here
-- Add colum to owners


ALTER TABLE owners ADD COLUMN email VARCHAR(120);
