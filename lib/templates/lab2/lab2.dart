class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() =>
      print('Title: $title, Author: $author, Number of pages: $numberOfPages');
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() => print(
      'Title: $title, Author: $author, Genre: $genre, Number of pages: $numberOfPages');
}

mixin Readable {
  void read() {
    print("The book is being read");
  }
}

mixin JsonSerializable {
  // your code here
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name Age: ${age ?? 'N/A'} Email: ${email ?? 'N/A'}');
  }
}

double calculateArea(
    {required double length,
      required double width,
      String shape = 'rectangle'}) {
  if (shape.toLowerCase() == 'rectangle') {
    return length * width;
  } else if (shape.toLowerCase() == 'circle') {
    return 3.14 * length * length;
  } else {
    throw ArgumentError("'$shape' is an invalid shape.");
  }
}

void main() {
  var book1 = Book('Book', 'Author', 100);
  book1.bookDetails();

  book1.read();

  var fictionBook1 = FictionBook('Book', 'Author', 100, 'Fiction');
  fictionBook1.bookDetails();
  fictionBook1.read();

  try {
    print(calculateArea(length: 10, width: 10));
    print(calculateArea(length: 10, width: 10, shape: "circle"));
    print(calculateArea(length: 10, width: 10, shape: "test"));
  } catch (e) {
    print("Error: ${e.toString()}");
  }

  User user1 = User(name: 'Grisha Rybolovlev', age: 20, email: 'g.rybolovlev@innopolis.university');
  user1.printUserDetails();
  User user2 = User(name: 'Grisha Rybolovlev2');
  user2.printUserDetails();
}
