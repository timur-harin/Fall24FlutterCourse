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

class User {
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
    print('Length considered as the radius of the circle');
    return 3.14 * length * length;
  } else {
    throw ArgumentError("'$shape' is an invalid shape.");
  }
}

void main() {
  // Classes
  var book1 = Book('Some Book', 'Some Author', 4602);
  book1.bookDetails();
  // Mixin 
  book1.read();

  // Inheritance
  var fictionBook1 = FictionBook('Justice', '???', 600, 'Detective');
  fictionBook1.bookDetails();
  // Mixin
  fictionBook1.read();
  

  // Function
  try {
    print(calculateArea(length: 3, width: 3, shape: "circle"));
    print(calculateArea(length: 3, width: 18));
    print(calculateArea(length: 3, width: 7, shape: "test"));
  } catch (e) {
    print("Error: ${e.toString()}");
  }

  // Null-safety
  User user1 = User(name: 'Test 1', age: 20, email: 'test.mail@innopolis.university');
  user1.printUserDetails();
  User user2 = User(name: 'Test 2');
  user2.printUserDetails();
}
