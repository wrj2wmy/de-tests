/*
The following are known:

Each car can only be sold by one salesperson.
There are multiple manufacturers’ cars sold.
Each car has the following characteristics:
Manufacturer
Model name
Serial number
Weight
Price
Each sale transaction contains the following information:

Customer Name
Customer Phone
Salesperson
Characteristics of car sold
*/


-- Creation of car table
CREATE TABLE IF NOT EXISTS car (
    car_id INT NOT NULL,
    car_name varchar(250) NOT NULL,
    manufacturer varchar(250) NOT NULL,
    model varchar(250) NOT NULL,
    serial varchar(250) NOT NULL,
    Weight DECIMAL(20,3) NOT NULL,
    Price DECIMAL(20,3) NOT NULL,
    PRIMARY KEY (car_id)
);

-- Creation of customer table
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT NOT NULL,
    customer_name varchar(250) NOT NULL,
    customer_phone varchar(20) NOT NULL,
    PRIMARY KEY (customer_id)
);

-- Creation of sales_person table
CREATE TABLE IF NOT EXISTS salesperson (
    person_id INT NOT NULL,
    person_name varchar(250) NOT NULL,
    PRIMARY KEY (person_id)
);

-- Creation of transaction table
CREATE TABLE IF NOT EXISTS sale (
    sale_id varchar(200) NOT NULL,
    price DECIMAL(20,3) NOT NULL,
    date_sale TIMESTAMP,
    car_id INT NOT NULL,
    customer_id INT NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (sale_id),
    CONSTRAINT fk_car
    FOREIGN KEY(car_id)
    REFERENCES car(car_id),
    CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
    REFERENCES customer(customer_id),
    CONSTRAINT fk_sales_person
    FOREIGN KEY(person_id)
    REFERENCES salesperson(person_id)
);