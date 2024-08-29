void main() {
  Book deadSoulsBook = Book('Мертвые души', 'Н. В. Гоголь', 305);
  deadSoulsBook.bookDetails();

  Book otherBook = FictionBook('Otherside', 'Unknown', 112, );
  otherBook.bookDetails();

  LibraryBook libraryDeadSoulsBook = LibraryBook('Мертвые души', 'Н. В. Гоголь', 305);
  libraryDeadSoulsBook.read();

  print("Calculated area for rect 2x4: ${calculateArea(2, 4)}");
  print("Calculated area for circle r=3: ${calculateArea(3, 0, shape: 'circle')}");

  User admin = User('Paul', age: 34);
  admin.printUserDetails();
}

class Book {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Book: "$title" by $author; $numberOfPages pages.');
  }
}

class FictionBook extends Book{
  String genre = 'fiction';

  FictionBook(super.title, super.author, super.numberOfPages);

  @override
  void bookDetails() {
    print('Book: "$title" by $author of $genre genre; $numberOfPages pages.');
  }
}

mixin Readable {
  void read() {
    print("The book is being read...");
  }
}

class LibraryBook extends Book with Readable {
  LibraryBook(super.title, super.author, super.numberOfPages);
}

double calculateArea(double width, double height, {String shape = 'rectangle'})
{
  if (shape == 'rectangle') {
    return width * height;
  } else if (shape == 'circle') {
    return 3.14 * width * width;
  } else {
    throw ArgumentError('Argument shape can accept only "rectangle" [default] or "circle"');
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, {this.age, this.email});

  void printUserDetails() {
    print('Name: $name. Age: ${age ?? 'N/A'}. Email: ${email ?? 'N/A'}');
  }
}
