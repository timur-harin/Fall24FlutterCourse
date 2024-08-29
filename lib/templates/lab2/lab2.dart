void main() {
  Book myBook = Book(
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    numberOfPages: 180,
  );

  myBook.bookDetails();
  myBook.read();

  FictionBook myFictionBook = FictionBook(
    title: "Pride and Prejudice",
    author: "Jane Austen",
    numberOfPages: 180,
    genre: "Romance",
  );

  myFictionBook.bookDetails();
  myBook.read();

  print('');

  double area = calculateArea(
    length: 10.0,
    width: 5.5
  );
  print(area);

  double circleArea = calculateArea(
    length: 4.3,
    width: 4.3,
    shape: "circle"
  );
  print(circleArea);

  print('');

  User user = User(
    name: "John"
  );
  user.printUserDetails();

  User user2 = User(
    name: "Denis",
    age: 20,
    email: "d.mikhailov@innopolis.university"
  );
  user2.printUserDetails();
}

class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages");
  }
}

class FictionBook extends Book with Readable {
  String genre;

  FictionBook({
    required String title,
    required String author,
    required int numberOfPages,
    required this.genre,
  }): super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre");
  }
}

mixin Readable {
  void read() {
    print("Reading...");
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
    print("Name: $name");
    print("Age: ${age ?? 'N/A'}");
    print("Email: ${email ?? 'N/A'}");
  }
}
