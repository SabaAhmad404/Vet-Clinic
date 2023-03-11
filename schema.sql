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
