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
