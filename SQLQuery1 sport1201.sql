
--USE master

--IF EXISTS (SELECT name FROM master.sys.databases WHERE name='SportShopDB')
--DROP DATABASE SportShopDB
--GO

--CREATE DATABASE SportShopDB
--GO

USE SportShopDB; 
GO

--CREATE TABLE Products 
--( 
--ProductID int PRIMARY KEY IDENTITY(1,1), 
--ProductName nvarchar(100) NOT NULL,
--ProductType nvarchar(100) NOT NULL,
--Quantity int NOT NULL,
--PrimeCost money NOT NULL,
--Manufacturer nvarchar(100) NOT NULL,
--Price money NOT NULL
--);
--GO

--CREATE TABLE Workers 
--( 
--WorkerID int PRIMARY KEY IDENTITY(1,1), 
--FullName nvarchar(100) NOT NULL,
--Gender nvarchar(1) NOT NULL,
--Salary money NOT NULL,
--Accepted date NOT NULL
--);
--GO

--CREATE TABLE Clients
--( 
--ClientID int PRIMARY KEY IDENTITY(1,1), 
--FullName nvarchar(100) NOT NULL,
--Email nvarchar(100) NOT NULL,
--Phone nvarchar(10) NOT NULL,
--Gender nvarchar(1) NOT NULL,
--IfSubscribedToNewsletter bit NOT NULL,
--Discount int NOT NULL
--);
--GO

--CREATE TABLE Sales
--( 
--SaleID int PRIMARY KEY IDENTITY(1,1),
--WorkerID int FOREIGN KEY REFERENCES Workers(WorkerID), 
--ClientID int FOREIGN KEY REFERENCES Clients(ClientID), 
--ProductName nvarchar(100) NOT NULL,
--Price money NOT NULL,
--Quantity int NOT NULL,
--SaleDate date NOT NULL
--);
--GO

CREATE INDEX i_product ON Products(ProductName);
GO

CREATE INDEX i_worker ON Workers(FullName);
GO

CREATE INDEX i_client ON Clients(FullName);
GO

CREATE NONCLUSTERED INDEX i_client_phone ON Clients(Phone);
GO

CREATE NONCLUSTERED INDEX i_client_email ON Clients(Email);
GO

CREATE INDEX i_sale ON Sales(SaleID, ProductName);
GO

CREATE NONCLUSTERED INDEX i_sale_all
ON Sales (SaleID)  
INCLUDE (WorkerID, ClientID, ProductName, Price, SaleDate); 
GO

CREATE NONCLUSTERED INDEX i_client_all
ON Clients (ClientID)  
INCLUDE (FullName, Email, Phone, Gender, IfSubscribedToNewsletter,Discount); 
GO

CREATE NONCLUSTERED INDEX i_worker_all
ON Workers (WorkerID)  
INCLUDE (FullName, Gender, Salary, Accepted); 
GO

CREATE NONCLUSTERED INDEX i_price_filter
ON Sales(Price)
WHERE Price >1000;
GO

CREATE NONCLUSTERED INDEX i_quantity_filter
ON Products(Quantity)
WHERE Price <10;
GO