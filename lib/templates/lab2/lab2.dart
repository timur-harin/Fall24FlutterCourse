void main() {
  var book = Book('Car', 'Henry Ford', 141);
  book.bookDetails();
  book.read();

  var fiction = FictionBook('Car', 'Henry Ford', 141, 'Biography');
  fiction.bookDetails();
  fiction.read();

  print(calculateArea(length: 20, width: 30));
  print(calculateArea(length: 29, width: 30, shape: "circle"));

  var user = User(name: 'Andrey', age: 20, email: 'mail@dehopen.ru');
  user.printUserDetails();

  var anotherUser = User(name: 'Andrey', email: 'mail@dehopen.ru');
  anotherUser.printUserDetails();
}

class Book with Readable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages.');
  }

}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Genre: $genre, Number of pages: $numberOfPages.');
  }
}

mixin Readable {
  void read() {
    print('Reading the book...');
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape.toLowerCase() == "rectangle") {
    return length * width;
  } else if (shape.toLowerCase() == "circle") {
    return 3.14 * length * length;
  } else {
    return 0;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name, Age: ${age ?? 'N/A'}, Email: ${email ?? 'N/A'}');
  }
}
