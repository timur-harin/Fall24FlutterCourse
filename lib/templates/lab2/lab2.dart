class Book with Readable{
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages');
  }
}


class FictionBook extends Book with Readable {
  String genre;

  FictionBook({required String title, required String author, required int numberOfPages, required this.genre})
      : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print('Book is being read.');
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  }
  return length * width;
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
void main() {

  Book myBook = Book(title: '1984', author: 'George Orwell', numberOfPages: 328);
  myBook.bookDetails();
  myBook.read();
  FictionBook myFictionBook = FictionBook(title: 'Dune', author: 'Frank Herbert', numberOfPages: 412, genre: 'Science Fiction');
  myFictionBook.bookDetails();
  myFictionBook.read();
  double areaRectangle = calculateArea(length: 10.0, width: 5.0);
  print('Area of Rectangle: $areaRectangle');

  double areaCircle = calculateArea(length: 7.0, width: 0, shape: 'circle');
  print('Area of Circle: $areaCircle');

  User user1 = User(name: 'Almaz', age: 19, email: 'a.gayazov@innopolis.university');
  user1.printUserDetails();

  User user2 = User(name: 'Efim');
  user2.printUserDetails();
}