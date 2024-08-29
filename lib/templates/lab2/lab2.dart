import 'package:freezed_annotation/freezed_annotation.dart';

class Book with Readable{
  // your code here
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title\nAuthor: $author\nNumber of pages: $numberOfPages\n');
  }
}

void main() {
  //book
  Book book = Book('Harry Potter and the Philosopher''s Stone', 'J. K. Rowling', 432);
  book.bookDetails();

  //fiction book
  FictionBook fictionBook = FictionBook('Harry Potter and the Philosopher''s Stone', 'J. K. Rowling', 432, 'Fantasy');
  fictionBook.bookDetails();

  //read
  fictionBook.read();

  //area
  print(calculateArea(length: 10, width: 20));
  print(calculateArea(shape: 'circle', length: 10));

  //user
  User user = User(name: 'Ankudinova Anastasooa', age: 20, email: 'a.ankudinova@innopolis.university');
  user.printUserDetails();
}

class FictionBook extends Book {
  // your code here
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre\n');
  }
}

mixin Readable {
  // your code here
  void read() {
    print('That the book is being read');
  }
}

double calculateArea({required double length,  double? width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else {
    if (width != null) {
      return length * width;
    } else {
      return 0.0;
    }
  }
}

class User{
  // your code here
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}
