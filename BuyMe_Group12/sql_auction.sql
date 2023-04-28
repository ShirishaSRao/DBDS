CREATE DATABASE dbproject_buyme;
USE dbproject_buyme;

CREATE TABLE END_USER(
	userID INTEGER primary key auto_increment,
	username VARCHAR(25),
	password VARCHAR(25) NOT NULL,
    name VARCHAR(25) NOT NULL,
    email VARCHAR(25) default NULL
);

insert into end_user values(2, 'jashs13', 'pwd123jash', 'Jash', 'jash@gm.com');
insert into end_user values(1, 'saumya0220', 'password', 'Saumya', 'saumya0220@gmail.com');
insert into end_user values(3, 'root', 'root', 'user', 'user@gm.com');

insert into end_user values(0, 'toot', 'toot', 'user', 'user@gm.com');



CREATE TABLE SELLER(
	sellerID INTEGER NOT NULL auto_increment, 
    items_sold int NOT NULL, 
    primary key(sellerID), 
    foreign key(sellerID) references END_USER(userID)
);

CREATE TABLE BUYER(
	buyerID INTEGER NOT NULL auto_increment, 
    auto_bidding_enabled int NOT NULL, 
    Primary key(buyerID), 
    Foreign key(buyerID) references END_USER(userID)
);

# start time for auction is whenever it was created
CREATE TABLE AUCTION(
	auctionID INTEGER primary key auto_increment, 
    sellerID INTEGER NOT NULL, 
    itemID INTEGER NOT NULL,
    initial_price DECIMAL(10,2) NOT NULL, 
    increment DECIMAL(10,2) NOT NULL, 
    start_datetime datetime NOT NULL, 
    closing_datetime datetime NOT NULL,
	Foreign key(sellerID) references SELLER(sellerID)
	Foreign key(itemID) references ITEM(itemID)
);

CREATE TABLE CATEGORY(
	categoryID INTEGER primary key auto_increment,
    categoryName VARCHAR(30)
);

CREATE TABLE SUB_CATEGORY(
	sub_categoryID INTEGER primary key auto_increment,
    categoryID INTEGER,
    sub_categoryName VARCHAR(30),
    Foreign key(categoryID) references CATEGORY(categoryID)
);

CREATE TABLE ITEM(
	itemID INTEGER PRIMARY KEY auto_increment, 
    buyerID INTEGER, 
    sellerID INTEGER NOT NULL,
    sub_categoryID INTEGER NOT NULL,
    item_name varchar(30) NOT NULL,
    item_condition varchar(15) NOT NULL,
	minimum_price DECIMAL(10,2) NOT NULL, 
    sold_price DECIMAL(10, 2),
    Foreign key(buyerID) references BUYER(buyerID), 
    Foreign key(sellerID) references SELLER(sellerID),
    Foreign key(sub_categoryID) references SUB_CATEGORY(sub_categoryID)
);



CREATE TABLE BID(
	bidID INTEGER primary key auto_increment, 
    buyerID INTEGER NOT NULL, 
    auctionID INTEGER NOT NULL, 
    itemID INTEGER NOT NULL,
	bid_amount DECIMAL(10,2) NOT NULL, 
    bid_time datetime NOT NULL, 
    automatic_bidding_limit DECIMAL(10,2),
	Foreign key(buyerID) references BUYER(buyerID), 
    Foreign key(auctionID) references AUCTION(auctionID), 
    Foreign key(itemID) references ITEM(itemID)
);