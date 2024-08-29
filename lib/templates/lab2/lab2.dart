mixin Readable {
  void read() {
    print('The book is being read');
  }
}

class Book with Readable{
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

   void bookDetails() 
   {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
   }
}

class FictionBook extends Book{
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() 
   {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre');
   }
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return length * width;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageText = age != null ? age.toString() : 'N/A';
    String emailText = email ?? 'N/A';
    print('Name: $name');
    print('Age: $ageText');
    print('Email: $emailText');
  }
}

void main() {
  Book book = Book('Modern Operating Systems', 'Andrew S. Tanenbaum', 1137);
  book.bookDetails();
  book.read();

  FictionBook fictionBook = FictionBook('Fahrenheit 451', 'Ray Bradbury', 206, 'Dystopian');
  fictionBook.bookDetails();

  print(calculateArea(length: 11, width: 12));
  print(calculateArea(length: 13, width: 13, shape: 'circle'));

  User testUser = User(name: 'Name', age: 33, email: 'test@example.ru');
  testUser.printUserDetails();
}