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

class FictionBook {
  // your code here
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
}