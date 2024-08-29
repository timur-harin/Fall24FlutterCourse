void main() {
  // Task 1
  print('--------------------');
  var book = Book('Moby Dick', 'Herman Melville', 200);
  book.bookDetails();

  // Task 2
  print('--------------------');
  var fictionBook = FictionBook('The Shadow over Innsmouth', 'H. P. Lovecraft', 300, 'Horror');
  fictionBook.bookDetails();

  // Task 3
  print('--------------------');
  book.read();

  // Task 4
  print('--------------------');
  print('Area of a rectangle: ${calculateArea(length: 4, width: 5)}');
  print('Area of a circle: ${calculateArea(length: 4, width: 4, shape: "circle")}');

  // Task 5
  print('--------------------');
  User user1 = User(name: 'John Doe', age: 30, email: 'john@example.com');
  user1.printUserDetails();

  User user2 = User(name: 'Jane Doe', age: null, email: null);
  user2.printUserDetails();
}
class Book with Readable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  final String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print('The book is being read.');
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * (length * length);
  } else {
    return length * width;
  }
}

class User {
  final String name;
  final int? age;
  final String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}