class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  // Implementing the toJson method from the mixin
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages,
    };
  }

  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

class User {
  String name;
  int? age;
  String? email;
  User({
    required this.name,
    this.age,
    this.email,
  });

  void printUserDetails() {
    String ageString = age != null ? age.toString() : 'N/A';
    String emailString = email ?? 'N/A';
    print('Name: $name Age: $ageString Email: $emailString');
  }
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else if (shape == 'rectangle') {
    return length * width;
  } else {
    throw ArgumentError('Unsupported shape: $shape');
  }
}

void main() {
  // Calling of bookDetails method
  Book newBook = Book('Harry Potter and the Philosophers Stone', 'J. K. Rowling', 352);
  newBook.bookDetails();

  // Calling of overridden bookDetails method
  FictionBook newFictionBook = FictionBook('Harry Potter and the Chamber of Secrets', 'J. K. Rowling', 480, 'Fantasy');
  newFictionBook.bookDetails();

  // Calling of toJson method
  Map<String, dynamic> bookJson = newBook.toJson();
  print(bookJson);

  // Creating User with all properties
  User fullUser = User(name: 'Egor', age: 19, email: 'e.valikov@innopolis.university');
  fullUser.printUserDetails();

  // Creating User only with name
  User emptyUser = User(name: 'Egor');
  emptyUser.printUserDetails();

  //Checking calculateArea function
  double rectangleArea = calculateArea(length: 5.0, width: 3.0);
  double circleArea = calculateArea(length: 4.0, width: 4.0, shape: 'circle');
  print('Area of the rectangle: $rectangleArea');
  print('Area of the circle: $circleArea');
}
