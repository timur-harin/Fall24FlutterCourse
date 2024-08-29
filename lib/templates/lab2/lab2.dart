mixin Readable {
  void read() {
    print("The book is being read...");
  }
}

class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title; Author: $author; Number of Pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print("Genre: $genre");
  }
}

double calculateArea(
    {required double length, double? width, String shape = "rectangle"}) {
  const double pi = 3.14;

  if (shape == "rectangle" && width != null) {
    return length * width;
  } else if (shape == "circle") {
    return length * length * pi;
  }

  return 0;
}

class User {
  String name;
  int? age;
  String? email;

  User({
    required this.name,
    this.age,
    this.email,
  });

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}

void main() {
  var book = Book("The Great Gatsby", "F. Scott Fitzgerald", 324);
  var fictionBook = FictionBook("The Hobbit", "J.R.R. Tolkien", 810, "Fantasy");

  book.bookDetails();
  fictionBook.bookDetails();

  book.read();
  fictionBook.read();

  print("Rectangle Area: ${calculateArea(length: 3, width: 6)}");
  print("Circle Area: ${calculateArea(length: 5, shape: 'circle')}");

  var user = User(name: "Alice", age: 24, email: "alice@example.com");
  var user1 = User(name: "Bob");

  user.printUserDetails();
  user1.printUserDetails();
}
