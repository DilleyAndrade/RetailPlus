CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
CREATE SCHEMA analytics;

CREATE TABLE bronze.customers(
  customer_id INT PRIMARY KEY NOT NULL UNIQUE,
  name VARCHAR(100),
  email VARCHAR(100),
  signup_date DATE,
  state VARCHAR(5)
);

CREATE TABLE bronze.products(
  product_id INT PRIMARY KEY NOT NULL UNIQUE,
  name VARCHAR(100),
  category VARCHAR(100),
  price REAL
);

CREATE TABLE bronze.orders(
  order_id INT PRIMARY KEY NOT NULL UNIQUE,
  customer_id INT,
  product_id INT,
  order_date DATE,
  quantity INT,
  total_amount REAL,
  CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES bronze.customers(customer_id),
  CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES  bronze.products(product_id)
);


CREATE TABLE silver.customers(
  customer_id INT PRIMARY KEY NOT NULL UNIQUE,
  name VARCHAR(100),
  email VARCHAR(100),
  signup_date DATE,
  state VARCHAR(5)
);

CREATE TABLE silver.products(
  product_id INT PRIMARY KEY NOT NULL UNIQUE,
  name VARCHAR(100),
  category VARCHAR(100),
  price REAL
);

CREATE TABLE silver.orders(
  order_id INT PRIMARY KEY NOT NULL UNIQUE,
  customer_id INT,
  product_id INT,
  order_date DATE,
  quantity INT,
  total_amount REAL,
  CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES bronze.customers(customer_id),
  CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES  bronze.products(product_id)
);