// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Library {
    // Define a Book struct to represent each book
    struct Book {
        string title;
        string author;
        bool available;
        address borrower;
    }

    // Define a mapping to store the books using their ID as the key
    mapping(uint256 => Book) public books;

    // Define a variable to keep track of the next available ID for new books
    uint256 public nextBookId = 1;

    // Define an event to emit when a book is borrowed
    event BookBorrowed(uint256 bookId, address borrower);

    // Define an event to emit when a book is returned
    event BookReturned(uint256 bookId, address borrower);

    // Define a function to add a new book to the library
    function addBook(string memory _title, string memory _author) public {
        books[nextBookId] = Book(_title, _author, true, address(0));
        nextBookId++;
    }

    // Define a function to borrow a book from the library
    function borrowBook(uint256 _bookId) public {
        require(books[_bookId].available == true, "Book is not available");
        books[_bookId].available = false;
        books[_bookId].borrower = msg.sender;
        emit BookBorrowed(_bookId, msg.sender);
    }

    // Define a function to return a book to the library
    function returnBook(uint256 _bookId) public {
        require(books[_bookId].available == false, "Book is already available");
        require(books[_bookId].borrower == msg.sender, "You are not the borrower of this book");
        books[_bookId].available = true;
        books[_bookId].borrower = address(0);
        emit BookReturned(_bookId, msg.sender);
    }
}