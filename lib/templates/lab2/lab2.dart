// ignore_for_file: avoid_print

void main() {
  callBookDetails();

  callInheritedBookDetails();

  callReadForInheritedBook();

  callCalculateArea();

  callPrintUserDetails();
}

class Book with Readable {
  Book({
    required this.title,
    required this.author,
    required this.numberOfPages,
  });

  String title;
  String author;
  int numberOfPages;

  void bookDetails() {
    print(
        'Book details:\ntitle: $title,\nauthor: $author,\nnumberOfPages: $numberOfPages\n\n');
  }
}

class FictionBook extends Book {
  FictionBook({
    required super.title,
    required super.author,
    required super.numberOfPages,
    required this.genre,
  });

  String genre;

  @override
  void bookDetails() {
    print(
        'Book details:\ntitle: $title,\nauthor: $author,\nnumberOfPages: $numberOfPages,\ngenre: $genre\n');
  }
}

mixin Readable {
  void read() => print('The book is being read.\n');
}

double calculateArea({
  required double length,
  required double width,
  String shape = 'rectangle',
}) {
  if (shape == 'rectangle') {
    return length * width;
  } else if (shape == 'circle') {
    return length * width * 3.14;
  } else {
    throw Exception('Invalid shape!');
  }
}

class User {
  User({required this.name, this.age, this.email});

  String name;
  int? age;
  String? email;

  void printUserDetails() {
    print('Name: [$name]\nAge: [${age ?? 'N/A'}]\nEmail: [${email ?? 'N/A'}]');
  }
}

void callBookDetails() {
  Book book = Book(
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    numberOfPages: 180,
  );

  book.bookDetails();
}

void callInheritedBookDetails() {
  FictionBook fictionBook = FictionBook(
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    numberOfPages: 180,
    genre: 'Fiction',
  );

  fictionBook.bookDetails();
}

void callReadForInheritedBook() {
  Book book = FictionBook(
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    numberOfPages: 180,
    genre: 'Fiction',
  );
  book.read();
}

void callCalculateArea() {
  print('Area of a circle = ${calculateArea(length: 10, width: 20)}');
  print('Area of a rectangle = ${calculateArea(length: 10, width: 20, shape: 'rectangle')}');
  print('Area of a circle = ${calculateArea(length: 10, width: 20, shape: 'circle')}');
  try {
    print('Area of a triangle = ${calculateArea(length: 10, width: 20, shape: 'triangle')}');
  } catch (e) {
    print('Error: triangle is not a valid shape\n');
  }
}

void callPrintUserDetails() {
  User user = User(name: 'John', age: 30);
  user.printUserDetails();
}
