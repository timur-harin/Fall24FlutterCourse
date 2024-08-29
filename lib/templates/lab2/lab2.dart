class Book with Readable{
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails(){
    print("title: $title; author: $author; number of pages: $numberOfPages");

  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails(){
    print("title: $title; author: $author; number of pages: $numberOfPages; genre: $genre");
  }

  

}

mixin Readable {
  void read(){
    print("reading a book");
  }
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

    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}){
  double pi = 3.14;
  if(shape == "rectangle"){
    if(length != null && width != null){
      return length * width;
    }
  }
  else if(shape == "circle"){
    if(length != null){
      return length * length * pi;
    }
  }
  return 0;
}

void main(){
  var book = Book("Война и мир", "Л. Толстой", 300);

  var fictionBook = FictionBook("book", "author", 88, "genre");
  book.bookDetails();
  fictionBook.bookDetails();

  book.read();
  fictionBook.read();

  print(calculateArea(length: 2, width: 4));

  print(calculateArea(length: 2, shape: "circle"));

  print(calculateArea(length: 5));

  User user = User(name: "Said", age: 20, email: "s.nurullin@innopolis.university");
  User user1 = User(name: "Undefined");
  user.printUserDetails();
  user1.printUserDetails();
}
