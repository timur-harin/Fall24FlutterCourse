class Book with Readable {
  String title, author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Book Details: \n'
        'Title: $title\n'
        'Author: $author\n'
        'Number of Pages: $numberOfPages\n');
  }
}

class FictionBook extends Book with Readable {
  String genre;

  FictionBook(title, author, numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print('Book Details: \n'
        'Title: $title\n'
        'Author: $author\n'
        'Number of Pages: $numberOfPages\n'
        'Genre: $genre\n');
  }
}

mixin Readable {
  void read() {
    print('Book is being read');
  }
}

class User {
  String name;
  int? age;
  String? email;

  User(this.name);

  void printUserDetails() {
    email ??= 'N/A';

    if (age != null) {
      print('Name: $name Age: $age Email: $email');
    } else {
      print('Name: $name Age: N/A Email: $email');
    }
  }
}

double calculateArea(
    {double? length, double? width, String shape = 'rectangle'}) {
  if (shape == 'rectangle' && length != null && width != null) {
    var area = length * width;
    return area;
  } else if (shape == 'circle' && length != null) {
    var pi = 3.14;
    var area = pi * length * length;
    return area;
  } else {
    print("Incorrect inputs");
    return 0;
  }
}

void main() {
  var javaBook = Book('The Philosophy of Java', 'Bruce Eckel', 1168);
  javaBook.bookDetails();

  var fictionBook =
      FictionBook('Back to the Future', 'Bob Gale', 256, 'Science Fiction');
  fictionBook.bookDetails();

  javaBook.read();
  fictionBook.read();

  print("\nCalculation area of rectangle with length = 4.2 and width = 3.4: "
          "${calculateArea(length: 4.2, width: 3.4)}");
  print("Calculation area of circle with radius = 2.6"
      "${calculateArea(length: 4.2, shape: 'circle')}");
  print("Test calculation with incorrect inputs:");
  print("Default answer with incorrect inputs: ${calculateArea()}\n");

  User anonymous = User('Anonymous');
  User bookLover = User('Nikita')
    ..age = 21
    ..email = 'bookLover123@yahoo.com';

  anonymous.printUserDetails();
  bookLover.printUserDetails();
}
