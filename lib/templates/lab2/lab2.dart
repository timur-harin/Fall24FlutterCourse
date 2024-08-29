class Book {
  String title;
  String author;
  int numberOfPages;

  // Constructor that initializes all the properties
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  // Constructor to initialize title, author, numberOfPages, and genre
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  // Override bookDetails method to include genre in the output
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  // your code here
}

class User{
  // your code here
}

void main() {
  // Creating an instance of Book
  var book = Book('The Three-Body Problem', 'Liu Cixin', 400);
  book.bookDetails();

  // Creating an instance of FictionBook
  var fictionBook = FictionBook('Dune', 'Frank Herbert', 412, 'Science Fiction');
  fictionBook.bookDetails();
}