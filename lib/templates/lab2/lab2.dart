class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title\nAuthor: $author\nNumber of pages: $numberOfPages");
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'author': author, 'numberOfPages': numberOfPages};
  }
}

class FictionBook extends Book {
  String genre;

  @override
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print(
        "Title: $title\nAuthor: $author\nNumber of pages: $numberOfPages\nGenre: $genre");
  }
}

mixin Readable {
  void read() {
    print("Book was read");
  }
}

double? calculateArea(double length, double width,
    {String shape = 'rectangle'}) {
  if (shape == 'rectangle') {
    return length * width;
  } else if (shape == 'circle') {
    return 3.14 * length * length;
  }

  return 0;
}

class User {
  String name;
  int? age;
  String? email;

  User(this.name, this.age, {this.email = ''});

  void printUserDetails() {
    print("Name: $name");
    if (age == 0) {
      print("N/A");
    } else {
      print("Age: $age");
    }

    if (email == null) {
      print("N/A");
    } else {
      print("Email: $email");
    }
  }
}

void main() {
  Book book = Book("Call of Cthulhu", "Howard Lovecraft", 413);
  book.bookDetails();
  book.read();

  FictionBook fictionBook =
      FictionBook("Foundation", "Isaak Asimov", 231, "Sci-fi");
  fictionBook.bookDetails();

  print(book.toJson());

  print(calculateArea(5, 2));
  print(calculateArea(5, 0, shape: 'circle'));

  User user = User("Nikita", 20, email: "n.rashkin@innopolis.university");
  user.printUserDetails();
}
