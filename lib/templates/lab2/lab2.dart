class Book {
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook({
    required super.title,
    required super.author,
    required super.numberOfPages,
    required this.genre,
  });

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print("The book is being read.");
  }
}

//In this case i have just created another class (because task doesn't state to use already created ones)
class ReadableBook with Readable {
  String title;
  String author;
  int numberOfPages;

  ReadableBook({required this.title, required this.author, required this.numberOfPages});
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageText = age?.toString() ?? "N/A";
    String emailText = email ?? "N/A";
    print('Name: $name');
    print('Age: $ageText');
    print('Email: $emailText');
  }
}


void main() {
  // Task 1. Show how to call
  Book book = Book(
      title: "The Hobbit",
      author: "J.R.R.Tolkien",
      numberOfPages: 1800);
  book.bookDetails();

  // Task 2
  FictionBook fictionBook = FictionBook(
      title: "1984",
      author: "George Orwell",
      numberOfPages: 328,
      genre: "Dystopian");
  fictionBook.bookDetails();

  //Task 3
  ReadableBook readableBook = ReadableBook(
      title: "The Hobbit",
      author: "J.R.R.Tolkien",
      numberOfPages: 1800);
  readableBook.read();

  // Task 4
  print('Rectangle area: ${calculateArea(length: 5.0, width: 3.0)}');
  print('Circle area: ${calculateArea(length: 3.0, width: 0, shape: "circle")}');

  // Task 5
  User user = User(name: "Ilia Sardanadze", age: null, email: "mail@example.com");
  user.printUserDetails();
}
