-- create patients table
CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  date_of_birth DATE NOT NULL
);

-- create medical_histories table
CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  status TEXT NOT NULL,
  patient_id INTEGER NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients (id)
);

-- create treatments table
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type TEXT NOT NULL,
  name TEXT NOT NULL
);

-- create treatments_medical_histories table for many-to-many relationship
CREATE TABLE treatments_medical_histories (
  id SERIAL PRIMARY KEY,
  treatment_id INTEGER NOT NULL,
  medical_history_id INTEGER NOT NULL,
  FOREIGN KEY (treatment_id) REFERENCES treatments (id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);

-- create invoices table
CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount NUMERIC(10,2) NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP,
  medical_history_id INTEGER NOT NULL,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);

-- create invoice_items table for many-to-many relationship
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price NUMERIC(10,2) NOT NULL,
  quantity INTEGER NOT NULL,
  total_price NUMERIC(10,2) NOT NULL,
  invoice_id INTEGER NOT NULL,
  treatment_id INTEGER NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoices (id),
  FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

-- create FK indexes
CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);