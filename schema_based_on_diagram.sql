CREATE TABLE patients (
    id serial primary key,
	name varchar(255) NOT NULL,
	date_of_birth date NOT NULL
)

CREATE TABLE medical_histories (
       id serial primary key,
       admitted_at timestamp NOT NULL,
	   status varchar(255) NOT NULL,
	   patient_id int NOT NULL references patients(id)
)


CREATE TABLE treatments(
       id serial primary key,
       type varchar(255) NOT NULL,
	   name varchar(255) NOT NULL
)

-- many to many relationship between treatments and medical histories

CREATE TABLE  medical_histories_treatments(
       id serial primary key,
       treatment_id int NOT NULL REFERENCES treatments(id),
	     medical_history_id int NOT NULL REFERENCES medical_histories(id)
)


CREATE TABLE invoices(
       id serial primary key,
       total_amount numeric NOT NULL,
	   generated_at timestamp NOT NULL,
	   payed_at timestamp,
	   medical_history_id int NOT NULL REFERENCES medical_histories(id)
)

CREATE TABLE invoice_items(
       id serial primary key,
       unit_price numeric NOT NULL,
	   quantity int NOT NULL,
	  totl_price numeric NOT NULL,
	  invoice_id int NOT NULL REFERENCES invoices(id),
	  treatment_id int NOT NULL REFERENCES treatments(id)
)

-- add index to the forign keys
CREATE INDEX medical_histories_patient_id_index ON medical_histories(patient_id)
CREATE INDEX medical_histories_treatments_treatment_id_index ON medical_histories_treatments(treatment_id)
CREATE INDEX medical_histories_treatments_medical_history_id_index ON medical_histories_treatments( medical_history_id)
CREATE INDEX invoices_medical_history_id_index ON invoices(medical_history_id)
CREATE INDEX invoice_items_invoice_id_index ON invoice_items(invoice_id)
CREATE INDEX invoice_items_treatment_id_index ON invoice_items(treatment_id)









