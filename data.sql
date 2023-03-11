/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', '02-03-2020', 0, true , 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '11-15-2018', 2, true , 8);
INSERT INTO animals VALUES (3, 'Pikachu', '01-07-2021', 1, false , 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '05-12-2017', 5, true , 11);
INSERT INTO animals VALUES (5, 'Charmander', '02-08-2020', 0, false , -11);
INSERT INTO animals VALUES (6, 'Plantmon', '11-15-2021', 2, true , -5.7);
INSERT INTO animals VALUES (7, 'Squirtle', '04-02-1993', 3, false , -12.13);
INSERT INTO animals VALUES (8, 'Angemon', '06-12-2005', 3, false , -45);
INSERT INTO animals VALUES (9, 'Boarmon', '06-07-2005', 7, true , 20.4);
INSERT INTO animals VALUES (10, 'Blossom', '10-13-1998', 3, true , 17);
INSERT INTO animals VALUES (11, 'Ditto', '05-14-2022', 4, true , 22);
-- owners table data
INSERT INTO owners (full_name, age) VALUES ( 'Sam Smith ', 34);
INSERT INTO owners (full_name, age) VALUES ( 'Jennifer Orwell', 19),( 'Bob', 45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38)

-- species table data

INSERT INTO species (name) VALUES ('Pokemon'),('Digimon')



                
    --  insertion and quries

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
update animals
set species_id=(select id from species where name='Digimon')
where name like '%mon'

-- All other animals are Pokemon

update animals
set species_id=(select id from species where name='Pokemon')
where name not like '%mon'

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.

update animals
set owner_id=(select id from owners where full_name='Sam Smith ')
where name='Agumon'

-- Jennifer Orwell owns Gabumon and Pikachu.
update animals
set owner_id=(select id from owners where full_name='Jennifer Orwell')
where name IN ('Gabumon', 'Pikachu')

-- Bob owns Devimon and Plantmon.
update animals
set owner_id=(select id from owners where full_name='Bob')
where name='Devimon' or name='Plantmon'

-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id=(select id from owners where full_name='Melody Pond')
where name IN ('Charmander', 'Squirtle', 'Blossom')


-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id=(select id from owners where full_name='Dean Winchester')
where name IN ('Angemon', 'Boarmon')



-- many to many relation start from here

INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet William Tatcher', 45, '04-23-2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet Maisy Smith', 26, '01-17-2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet Stephanie Mendez', 64, '05-04-1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet Jack Harkness', 38, '06-08-2008');

-- specialization table
INSERT INTO specializations(vets_id, species_id) Values((select id from vets where name='William Tatcher'),(select id from species where name='Pokemon'))

INSERT INTO specializations(vets_id, species_id) Values((select id from vets where name='Stephanie Mendez'),(select id from species where name='Digimon')),
((select id from vets where name='Stephanie Mendez'),(select id from species where name='Pokemon'))

INSERT INTO specializations(vets_id, species_id) Values((select id from vets where name='Jack Harkness'),(select id from species where name='Digimon'))



-- visits table
INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = ' William Tatcher'), '05-24-2020')
  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '07-22-2020')
  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '02-02-2021')
INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '01-05-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '03-08-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '05-14-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '05-04-2021')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '02-24-2021')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '12-21-2019')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '08-10-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '04-07-2021')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '09-29-2019')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '10-03-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '11-04-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '01-24-2019')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '05-15-2019')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '02-27-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '08-03-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '05-24-2020')

  INSERT INTO visits (animal_id, vets_id, date_of_vists) VALUES
  ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '01-11-2021')


  -- performance test start from here
  -- adding data into visits

  INSERT INTO visits (animal_id, vets_id, date_of_vists) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

  -- adding data into owners

  insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


