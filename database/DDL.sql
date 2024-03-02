-- Disable commits + foreign key checks, re-enabled at end to minimize import errors
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- creates the category table. 
CREATE OR REPLACE TABLE Categories(
    category_id int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    sport varchar(255) NOT NULL,
    UNIQUE (category_id) 
);

-- creates the customer table
CREATE OR REPLACE TABLE Customers(
    customer_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    full_name varchar(255) NOT NULL,   
    email varchar(255) NOT NULL,
    phone_number varchar(15) NOT NULL,
    shipping_address varchar(255) NOT NULL,

    UNIQUE (customer_id)   
);

-- creates the product_types table
CREATE OR REPLACE TABLE Product_types(
    product_type_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    item_type varchar(255) NOT NULL,
    product_size varchar(45) NOT NULL,
    brand varchar(255) NOT NULL
);

-- creates the product table
CREATE OR REPLACE TABLE Products(
    product_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    product_name varchar(255) NOT NULL,
    inventory int NOT NULL,
    price decimal NOT NULL,
    category_id int NOT NULL,
    product_type_id int NOT NULL, 

    FOREIGN KEY (category_id) REFERENCES Categories(category_id), 
    FOREIGN KEY (product_type_id) REFERENCES Product_types(product_type_id),
    UNIQUE (product_id) 
);


-- creates the invoice table
CREATE OR REPLACE TABLE Invoices(
    invoice_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    customer_id int NOT NULL, 
    product_id int NOT NULL,
    date_placed DATE NOT NULL,
    total_amount int NOT NULL,
    total_price decimal NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id), 
    UNIQUE (invoice_id)
);



-- creates the product_invoice table
CREATE OR REPLACE TABLE Product_invoices(
    invoice_id int, 
    product_id int,

    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Adding example data

-- adds Categories example data
INSERT INTO Categories(sport)
VALUES ("Football"), 
("Baseball"),
("Soccer"),
("Basketball");

-- adds Products example data
INSERT INTO Products(product_name, inventory, price, category_id)
VALUES ("Air Jordans", 4, 119.99, 4),
("Beavers Jersey", 9, 59.99, 1),
("Soccer Ball", 23, 30, 3),
("Football Pads", 12, 250.00, 1),
("Baseball Glove", 19, 99.99, 2);

-- adds Product_types data
INSERT INTO Product_types(item_type, product_size, brand)
VALUES ("Equipment", "12", "Nike"),
("Apparel", "Large", "Adidas"),
("Ball", "Official size", "Wilson");

-- adds Customers data
INSERT INTO Customers(full_name, email, phone_number, shipping_address)
VALUES ("Bob Ross", "realbobross@gmail.com", 9862416969, "123 Happy Accident Drive"),
("Tom Brady", "tb12@yahoo.com", 1212121212, "283 Deflated Ball Avenue"),
("Steve McSteve", "stevesquared@aol.com", 1234567890, "1544 Stevenson Street"),
("Joe Biden", "realpotus@president.gov", 9998887777, "1600 Pennsylvania Avenue");

-- adds Invoices data
INSERT INTO Invoices(customer_id, product_id, date_placed, total_amount, total_price)
VALUES (1, 2, "2020-9-17", 3, 179.97),
(2, 4, "2023-8-12", 1, 250.00),
(3, 1, "2021-3-20", 1, 119.99),
(4, 5, "2024-1-3", 26, 1199.98);

-- adds Product_invoices data
INSERT INTO Product_invoices(invoice_id, product_id)
VALUES (1, 2),
(2, 4),
(3, 1),
(4, 4);


-- display the values
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Product_types;
SELECT * FROM Customers;
SELECT * FROM Invoices;
SELECT * FROM Product_invoices;


-- reenabling this to avoid any corrupting file problems (hopefully)
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
