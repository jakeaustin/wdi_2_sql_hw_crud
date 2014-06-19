-- Jake Austin
-- GA WDI Boston June
-- hw6 SQL
-- June 18, 2014

-- In case there is already a bank_homework database, drop it
DROP DATABASE IF EXISTS bank_homework;

-- Create a bank_homework database
CREATE DATABASE bank_homework;

-- Connect to the bank_homework databases
\c bank_homework

-- Create a payments table
--  The table should have columns of id, created_at, amount, payer_name,
--  recipient_name, and description with the appropriate datatypes

-- Couldn't get addition to work with amount as MONEY,
-- so set as NUMERIC
CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  created_at DATE,
  amount NUMERIC,
  payer_name TEXT,
  recipient_name TEXT,
  description TEXT
);

-- Alter the payments table, add the column of `zipcode`
-- to specify where the transaction was made

-- Zipcodes lose leading 0 when interpreted as integer or numeric
ALTER TABLE payments ADD zipcode INTEGER;

-- Insert 20 rows into the payments table
-- The first of these payments should be deposits
-- try to keep the accounts positive and have at least three different payers.
INSERT INTO payments(created_at, amount, payer_name, recipient_name, description, zipcode) VALUES
('2014-01-20', 300.00, 'Lender', 'Jake', 'Loan payment to maintain positive accounts', 10024),
('2014-05-10', 300.00, 'Lender', 'Chris', 'Loan payment to maintain positive accounts', 02155),
('2014-06-17', 300.00, 'Lender', 'Lili', 'Loan payment to maintain positive accounts', 10011),
('2014-06-18', 30.00, 'Jake', 'Chris', 'Grocery reimbursemnt', 02155),
('2014-01-02', 100.00, 'Chris', 'Jake', 'Electric bill', 02155),
('2014-02-20', 15.00, 'Jake', 'Lili', '', 10011),
('2014-06-15', 50.00, 'Lili', 'Lender', 'First loan payment', 10011),
('2014-06-10', 0.50, 'Lili', 'Lender', 'interest fee', 10011),
('2014-06-11', 50.00, 'Jake', 'Chris', 'Cable bill', 02155),
('2014-05-20', 1.00, 'Chris', 'Jake', 'covering delivery tip', 10024),
('2014-04-20', 1.50, 'Lili', 'Chris', 'pack of gum', 10011),
('2014-03-20', 3.00, 'Lili', 'Jake', '', 10011),
('2014-02-22', 20.00, 'Jake', 'Lender', 'First loan payment', 10024),
('2014-06-10', 10.00, 'Chris', 'Jake', 'ordered a pizza', 02155),
('2014-06-17', 1.25, 'Jake', 'Lili', '', 10011),
('2014-01-20', 40.00, 'Chris', 'Lender', 'first payment', 02155),
('2014-05-20', 60.00, 'Lili', 'Lender', 'second payment', 10011),
('2014-05-15', 30.00, 'Jake', 'Lender', 'overcharge fee', 10024),
('2014-06-16', 50.00, 'Jake', 'Lender', 'second payment', 10024),
('2014-01-20', 1.00, 'Jake', 'Chris', '', 02155);

-- You receive notice that the payment with id of 9 is $10 too low.
-- Alter that row so that it is corrected
UPDATE payments SET amount = amount + 10 WHERE id = 9;

-- Delete all payments with an amount under $2
DELETE FROM payments WHERE amount < 2.00;

-- Select all entries from the payments table
SELECT * FROM payments;

-- In a single query, output all payments ordered from the largest to the smallest
SELECT * FROM payments ORDER BY amount DESC;

-- In a single query, output the names of all distinct recipients
SELECT DISTINCT recipient_name FROM payments;

-- In a single query, select all payments created in the past week
SELECT * FROM payments WHERE created_at >= (current_date - 7);

-- In a single query, select all payments with a blank description
-- is 'blank' an empty string or null?
SELECT * FROM payments WHERE description = '';

-- In a single query, select all payments matching the name of one of the payers (choose any single one)
SELECT * FROM payments WHERE payer_name = 'Jake' OR recipient_name = 'Jake';
