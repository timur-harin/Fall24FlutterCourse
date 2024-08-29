import 'dart:math';

class Book with Readable {
  final String title;
  final String author;
  final int numberOfPages;

  const Book(this.title, this.author, this.numberOfPages);

  void bookDetails() => print(
    'Book(title=$title, author=$author numberOfPages=$numberOfPages)'
  );

  @override
  void read() => print('Book `$title` by `$author` is read by someone');
}

class FictionBook extends Book {
  String genre;

  FictionBook(
      super.title,
      super.author,
      super.numberOfPages,
      this.genre
  );

  @override
  void bookDetails() => print(
      'Book(title=$title, author=$author numberOfPages=$numberOfPages, genre=$genre)'
  );
}

mixin Readable {
  void read();
  void readDefault() => print('Book is read by someone');
}

double calculateArea({
  required double length,
  required double width,
  String shape = 'rectangle',
}) => switch (shape) {
  'rectangle' => length * width,
  'circle' => pi * length * length,
  _ => throw UnsupportedError("Unexpected shape")
};

class User {
  final String name;
  final int? age;
  final String? email;

  const User({
    required this.name,
    this.age,
    this.email,
  });

  void printUserDetails() => print('''
Name: $name
Age: ${age ?? 'N/A'}
Email: ${email ?? 'N/A'}'''
  );

  // your code here
}

void main() {
  Book("Title", "Author", 42)
    ..bookDetails()
    ..read()
    ..readDefault();

  FictionBook("Title2", "Author2", 58, "Genre2")
    ..bookDetails()
    ..read()
    ..readDefault();

  print('Area of rectangle 5x6: ${calculateArea(length: 5, width: 6)}');
  print('Area of circle radius 3: ${calculateArea(length: 5, width: 0, shape: 'circle')}');

  User(name: 'User1').printUserDetails();
  User(name: 'User2', age: 34, email: 'aboba@gmail.com').printUserDetails();
}
