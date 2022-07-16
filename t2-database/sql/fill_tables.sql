-- Set params
set session my.number_of_sales = '100';
set session my.number_of_customers = '100';
set session my.number_of_salespersons = '20';
set session my.number_of_cars = '100';
set session my.start_date = '2021-01-01 00:00:00';
set session my.end_date = '2022-07-01 00:00:00';

-- load the pgcrypto extension to gen_random_uuid ()
CREATE EXTENSION pgcrypto;

-- Filling of cars
INSERT INTO car
select id,
       concat('Car ', id),
       concat('manufacturer ', id),
       concat('Model ', id),
       concat('Serial ', id),
       round(CAST(float8 (random() * 100) as numeric), 3),
       round(CAST(float8 (random() * 1000000) as numeric), 3)
FROM GENERATE_SERIES(1, current_setting('my.number_of_cars')::int) as id;


-- Filling of customers
INSERT INTO customer
select id,
       concat('User ', id),
       concat('Phone ', id)
FROM GENERATE_SERIES(1, current_setting('my.number_of_customers')::int) as id;

-- Filling of sale_persons
INSERT INTO salesperson
select id,
       concat('Salesperson ', id)
FROM GENERATE_SERIES(1, current_setting('my.number_of_salespersons')::int) as id;


-- Filling of sales
INSERT INTO sale
select gen_random_uuid ()
     , round(CAST(float8 (random() * 1000000) as numeric), 3)
     , TO_TIMESTAMP(start_date, 'YYYY-MM-DD HH24:MI:SS') +
       random()* (TO_TIMESTAMP(end_date, 'YYYY-MM-DD HH24:MI:SS')
           - TO_TIMESTAMP(start_date, 'YYYY-MM-DD HH24:MI:SS'))
     , floor(random() * (current_setting('my.number_of_cars')::int) + 1)::int
     , floor(random() * (current_setting('my.number_of_customers')::int) + 1)::int
     , floor(random() * (current_setting('my.number_of_salespersons')::int) + 1)::int
FROM GENERATE_SERIES(1, current_setting('my.number_of_sales')::int) as id
   , current_setting('my.start_date') as start_date
   , current_setting('my.end_date') as end_date;
