class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages) {}

  void bookDetails() {
    title = this.title;
    author = this.author;
    numberOfPages = this.numberOfPages;
    print(
        "Book title is $title. Book auth is $author. Book number of pages is $numberOfPages.");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages,
    };
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  void bookDetails() {
    title = this.title;
    author = this.author;
    numberOfPages = this.numberOfPages;
    genre = this.genre;
    print(
        "Book title is $title. Book auth is $author. Book number of pages is $numberOfPages. Book genre is $genre.");
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: ${name} Age: ${age ?? "N/A"} Email: ${email ?? "N/A"}');
  }
}

double calculateArea(
    {required double length,
    required double width,
    String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

void main() {
  // Book class method
  print("Task 1:");
  var book = Book("The lord of the rings", "J.R.R. Tolkien", 1077);
  book.bookDetails();

  // FictionBook class method
  print("Task 2:");
  var fictionBook =
      FictionBook("The lord of the rings", "J.R.R. Tolkien", 1077, "Fantasy");
  fictionBook.bookDetails();

  // toJson() method
  print("Task 3:");
  print(book.toJson());

  // calculateArea function
  print("Task 4:");
  print(calculateArea(length: 5.0, width: 10.0));
  print(calculateArea(length: 5.0, width: 0, shape: "circle"));

  // User class method
  print("Task 5:");
  var user =
      User(name: "Louay", age: 21, email: "l.farah@innopolis.university");
  user.printUserDetails();
  var undefinedUser = User(name: "Bob");
  undefinedUser.printUserDetails();
}
