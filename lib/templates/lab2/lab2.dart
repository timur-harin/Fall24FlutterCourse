// Mixin named Readable
import 'dart:ffi';
import 'dart:math';

mixin Readable {
  // Method to print out a message indicating the book is being read
  void read() {
    print('The book is being read.');
  }
}

class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  // Constructor that initializes all the properties
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book with Readable {
  String genre;

  // Constructor to initialize title, author, numberOfPages, and genre
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  // Override bookDetails method to include genre in the output
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  // your code here
}

class User{
  // your code here
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  double pi = 3.14;

  if (shape == "circle") {
    // Calculate the area of a circle using the length as the radius
    return pi * pow(length, 2);
  } else {
    // Calculate the area of a rectangle (default case)
    return length * width;
  }
}

void main() {
  // Creating an instance of Book
  var book = Book('The Three-Body Problem', 'Liu Cixin', 400);
  book.bookDetails();

  // Creating an instance of FictionBook
  var fictionBook = FictionBook('Dune', 'Frank Herbert', 412, 'Science Fiction');
  fictionBook.bookDetails();

  // Call mixin method
  fictionBook.read();


  // Example usage of the calculateArea function

  // Calculating the area of a rectangle
  double rectangleArea = calculateArea(length: 5.0, width: 3.0);
  print("Area of the rectangle: $rectangleArea");

  // Calculating the area of a circle
  double circleArea = calculateArea(length: 4.0, width: 0.0, shape: "circle");
  print("Area of the circle: $circleArea");
}