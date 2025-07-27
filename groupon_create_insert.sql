-- Address table
CREATE TABLE Address (
    Address_ID NUMBER PRIMARY KEY,
    Street VARCHAR2(100) NOT NULL,
    City VARCHAR2(50) NOT NULL,
    PostalCode VARCHAR2(10),
    Country VARCHAR2(50) NOT NULL
);

-- Customer table
CREATE TABLE Customer (
    Customer_ID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    RegistrationDate DATE DEFAULT SYSDATE NOT NULL
);

-- Merchant table
CREATE TABLE Merchant (
    Merchant_ID NUMBER PRIMARY KEY,
    BusinessName VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(20),
    Address_ID NUMBER NOT NULL,
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);

-- Category table
CREATE TABLE Category (
    Category_ID NUMBER PRIMARY KEY,
    CategoryName VARCHAR2(100) NOT NULL
);

-- Deal table
CREATE TABLE Deal (
    Deal_ID NUMBER PRIMARY KEY,
    Merchant_ID NUMBER NOT NULL,
    Title VARCHAR2(100) NOT NULL,
    Description VARCHAR2(500),
    Price NUMBER(10,2) NOT NULL,
    DiscountRate NUMBER(5,2),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    MaxPurchases NUMBER,
    FOREIGN KEY (Merchant_ID) REFERENCES Merchant(Merchant_ID)
);

-- Associative table: Deal_Category
CREATE TABLE Deal_Category (
    Deal_ID NUMBER NOT NULL,
    Category_ID NUMBER NOT NULL,
    PRIMARY KEY (Deal_ID, Category_ID),
    FOREIGN KEY (Deal_ID) REFERENCES Deal(Deal_ID),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Purchase table
CREATE TABLE Purchase (
    Purchase_ID NUMBER PRIMARY KEY,
    Customer_ID NUMBER NOT NULL,
    Deal_ID NUMBER NOT NULL,
    PurchaseDate DATE DEFAULT SYSDATE NOT NULL,
    Quantity NUMBER DEFAULT 1 NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Deal_ID) REFERENCES Deal(Deal_ID)
);

-- Redemption table
CREATE TABLE Redemption (
    Redemption_ID NUMBER PRIMARY KEY,
    Purchase_ID NUMBER NOT NULL,
    RedeemDate DATE,
    Redeemed CHAR(1) DEFAULT 'N' CHECK (Redeemed IN ('Y', 'N')),
    FOREIGN KEY (Purchase_ID) REFERENCES Purchase(Purchase_ID)
);

-- Payment table
CREATE TABLE Payment (
    Payment_ID NUMBER PRIMARY KEY,
    Purchase_ID NUMBER NOT NULL,
    PaymentDate DATE DEFAULT SYSDATE NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    FOREIGN KEY (Purchase_ID) REFERENCES Purchase(Purchase_ID)
);

-- Insert Dummy Data

-- Address
INSERT INTO Address VALUES (1, 'Main St 123', 'New York', '10001', 'USA');
INSERT INTO Address VALUES (2, 'Ocean Blvd 42', 'Miami', '33101', 'USA');
INSERT INTO Address VALUES (3, 'King St 88', 'Toronto', 'M5H2N2', 'Canada');

-- Customer
INSERT INTO Customer VALUES (1, 'Alice', 'Smith', 'alice@example.com', SYSDATE);
INSERT INTO Customer VALUES (2, 'Bob', 'Jones', 'bob@example.com', SYSDATE);
INSERT INTO Customer VALUES (3, 'Clara', 'Wells', 'clara@example.com', SYSDATE);

-- Merchant
INSERT INTO Merchant VALUES (1, 'Spa World', 'spa@example.com', '123456789', 1);
INSERT INTO Merchant VALUES (2, 'Burger Town', 'burger@example.com', '987654321', 2);
INSERT INTO Merchant VALUES (3, 'Yoga Center', 'yoga@example.com', '555555555', 3);

-- Category
INSERT INTO Category VALUES (1, 'Health');
INSERT INTO Category VALUES (2, 'Food');
INSERT INTO Category VALUES (3, 'Fitness');

-- Deal
INSERT INTO Deal VALUES (1, 1, 'Full Body Massage', '60-minute relaxing massage', 50, 30, SYSDATE, SYSDATE + 30, 100);
INSERT INTO Deal VALUES (2, 2, 'Burger Combo', 'Burger + Fries + Drink', 15, 20, SYSDATE, SYSDATE + 15, 200);
INSERT INTO Deal VALUES (3, 3, 'Yoga Monthly Pass', 'Unlimited yoga classes', 100, 40, SYSDATE, SYSDATE + 60, 50);

-- Deal_Category
INSERT INTO Deal_Category VALUES (1, 1);
INSERT INTO Deal_Category VALUES (2, 2);
INSERT INTO Deal_Category VALUES (3, 3);

-- Purchase
INSERT INTO Purchase VALUES (1, 1, 1, SYSDATE, 1);
INSERT INTO Purchase VALUES (2, 2, 2, SYSDATE, 2);
INSERT INTO Purchase VALUES (3, 3, 3, SYSDATE, 1);

-- Redemption
INSERT INTO Redemption VALUES (1, 1, SYSDATE, 'Y');
INSERT INTO Redemption VALUES (2, 2, NULL, 'N');
INSERT INTO Redemption VALUES (3, 3, SYSDATE, 'Y');

-- Payment
INSERT INTO Payment VALUES (1, 1, SYSDATE, 35.00);
INSERT INTO Payment VALUES (2, 2, SYSDATE, 24.00);
INSERT INTO Payment VALUES (3, 3, SYSDATE, 60.00);
