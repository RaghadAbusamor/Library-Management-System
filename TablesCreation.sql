-- create books, borrowers & loans tables
create table books (
    bookid int identity (1, 1) primary key,
    title varchar(255),
    author varchar(255),
    isbn varchar(20),
    publisheddate date,
    genre varchar(100),
    shelflocation varchar(50),
    currentstatus varchar(20)
);


create table borrowers (
    borrowerid int identity (1, 1) primary key,
    firstname varchar(100),
    lastname varchar(100),
    email varchar(255),
    dateofbirth date,
    membershipdate date
);

create table loans (
    loanid int identity (1, 1) primary key,
    bookid int,
    borrowerid int,
    dateborrowed date,
    duedate date,
    datereturned date,
    foreign key (bookid) 
	references books(bookid),
    foreign key (borrowerid) 
	references borrowers(borrowerid)
);