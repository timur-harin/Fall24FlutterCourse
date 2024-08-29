import 'dart:math';

class Book with Readable {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book with Readable {
  late String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print('The book is being read');
  }
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  switch(shape) {
    case 'circle':
      return 3.14 * pow(length, 2);
    default:
      return length * width;
  }
}

class User{
  String name;
  int? age;
  String? email;
  User(this.name, [this.age, this.email]);
  void printUserDetails() {
    print('Name: $name \nAge: ${age ?? 'N/A'} \nEmail: ${email ?? 'N/A'}');
  }

}

void main() {
  Book book = Book("Capitain's daughter", 'A. S. Pushkin', 183);
  book.bookDetails();
  book.read();
  FictionBook fictionBook = FictionBook('Anna Karenina', 'Lev Tolstoy', 864, 'Realist novel');
  fictionBook.bookDetails();
  print(calculateArea(length: 3.0, width: 4.6));
  print(calculateArea(length: 3.0, width: 3.0, shape: 'circle'));
  User user = User('anna');
  user.printUserDetails();
  user = User('anna', 20, 'a.rylova@innopolis.university');
  user.printUserDetails();
}