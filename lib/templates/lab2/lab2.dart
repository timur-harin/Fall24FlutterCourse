class Book with Readable {
  // Properties
  String title;
  String author;
  int numberOfPages;

  // Constructor
  Book(this.title, this.author, this.numberOfPages);

  // Method to print book details
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  // New property specific to FictionBook
  String genre;

  // Constructor for FictionBook, including genre
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  // Overriding bookDetails method to include genre
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print('The book is being read.');
  }
}

// Method to calculate area
double calculateArea( {required double length, required double width, String shape = "rectangle"} ) {
  if (shape == "circle") {
    return 3.14 * length * width;
  } else {
    return length * width;
  }
}

class User {
  // Properties
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  // Method to print user details
  void printUserDetails() {
    String ageStr = age?.toString() ?? "N/A";
    String emailStr = email ?? "N/A";

    print('Name: $name Age: $ageStr Email: $emailStr');
  }
}

void main() {
  // Creating a Book instance
  Book myBook = Book('The Catcher in the Rye', 'J.D. Salinger', 214);
  myBook.bookDetails();

  // Creating a FictionBook instance
  FictionBook myFictionBook = FictionBook('The Hobbit', 'J.R.R. Tolkien', 310, 'Fantasy');
  myFictionBook.bookDetails();

  myBook.read();

  // Calculate area of a rectangle
  double rectangleArea = calculateArea(length: 5.0, width: 10.0);
  print("Rectangle Area: $rectangleArea");

  // Calculate area of a circle
  double circleArea = calculateArea(length: 3.0, width: 3.0, shape: "circle");
  print("Circle Area: $circleArea");

  // Creating a User instance with all properties
  User user1 = User(name: 'Alice', age: 25, email: 'alice@example.com');
  user1.printUserDetails();

  // Creating a User instance with age as null
  User user2 = User(name: 'Bob', email: 'bob@example.com');
  user2.printUserDetails();
}