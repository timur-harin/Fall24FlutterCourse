
class Book{
  String ? title, author;
  int ? numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title, \nAuthor: $author, \nAmount of pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String ? genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);


  @override
  void bookDetails() {
    print("Title: $title, \nAuthor: $author, \nGenre: $genre, \nAmount of pages: $numberOfPages");
  }
}

mixin Readable {
  void read(){
    print("Reading the book...");
  }
}

class Reading extends Book with Readable{
  Reading(String title, String author, int numberOfPages) : super(title, author, numberOfPages);
}

double calculateArea({double ? length, double ? width, String shape = "rectangle"}){
  double area;
  if (shape == "rectangle"){
    area = (length ?? 0) * (width ?? 0);
  }else if (shape == "circle"){
    area = 3.14 * (length ?? 0) * (length ?? 0);
  }else{
    area = 0;
  }
  return area;
}

class User{
  String name;
  int ? age;
  String ? email;

  User(this.name, this.age, this.email);

  void printUserDetails(){
    print("Name: $name");
    print("Age:  ${age ?? "N/A"}");
    print("Email: ${email ?? "N/A"}");
  }
}

void main(){
  Book myBook = Book("White Fang", "Jack London", 333);
  myBook.bookDetails();
  print("\n");

  FictionBook myFictionBook = FictionBook("Harry Potter", "Rowling", 555, "Fiction");
  myFictionBook.bookDetails();
  print("\n");

  Reading myReadingBook = Reading("White Fang", "Jack London", 333);
  myReadingBook.bookDetails();
  myReadingBook.read();
  print("\n");

  print(calculateArea(length: 5, width: 10));        
  print(calculateArea(length: 7, shape: "circle"));   
  print(calculateArea(length: 8, width: 4, shape: "triangle")); 
  print("\n");
  
  User user1 = User("Lesya", 21, "Oles@gmail.com");
  User user2 = User("Nastya", null , "");

  user1.printUserDetails();
  print("\n");
  user2.printUserDetails();

}