class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book({
    required this.title, 
    required this.author, 
    required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook({
    required String title,
    required String author,
    required int numberOfPages,
    required this.genre,
  }) : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin Readable {
  void read() {
    print('The book is being read.');
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageStr = age != null ? age.toString() : 'N/A';
    String emailStr = email != null ? email! : 'N/A';
    print('Name: $name, Age: $ageStr, Email: $emailStr');
  }
}

void main() {
  Book book = Book(title: 'Cool Book', author: 'Me', numberOfPages: 123);
  book.bookDetails();

  FictionBook fBook = FictionBook(title: 'Cool Fictional Book', author: 'Also Me', numberOfPages: 321, genre: 'Physiology');
  fBook.bookDetails();

  book.read();
  fBook.read();

  double testRect = calculateArea(length: 3.0, width: 2.0);
  print('Rectangle Area:: $testRect');

  double testCirc = calculateArea(length: 10.0, width: 0.0, shape: "circle");
  print('Circle Area: $testCirc');

  User user1 = User(name: 'Nikita Cherkashin', age: 20, email: 'n.cherkashin@innopolis.university');
  user1.printUserDetails();

  User user2 = User(name: 'NeNikita NeCherkashin');
  user2.printUserDetails();
}