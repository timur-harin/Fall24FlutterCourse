class Book with Readable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);
  bookDetails(){
    print("Title: $title,\nAuthor: $author,\nPages: $numberOfPages");
  }
}

class FictionBook extends Book with Readable{
  String genre;

  FictionBook(super.title, super.author, this.genre, super.numberOfPages);

  @override
  bookDetails() {
    print("Title: $title,\nAuthor: $author,\nGenre: $genre,\nPages: $numberOfPages");
  }
}

mixin Readable {
  read(){
    print("This book is being read");
  }
}

calculateArea(double length, double width, {String shape = "rectangle"}){
  double area = length*width;
  switch(shape){
    case "triangle": 
      area = area/2;
      break;
    case "circle": 
      area = 3.14*length*length;
      break;
    default:
      break;
  }
  print("The area is equal to $area");
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);
  
  printUserInfo(){

    if (age != null){
      if (email != null){
        print("Name: $name Age: $age Email: $email");
      } else {
        print("Name: $name Age: $age Email: N/A");
      }
    } else {
      if (email != null){
        print("Name: $name Age: N/A Email: $email");
      } else {
        print("Name: $name Age: N/A Email: N/A");
      }
    }

  }
}

int main () {
  Book book = Book("title", "author", 100);
  book.bookDetails();

  Book fBook = FictionBook("f_title", "f_author", "f_genre", 200);
  fBook.bookDetails();

  book.read();

  calculateArea(5, 6);
  calculateArea(5, 6, shape: "triangle");

  User user1 = User("name1", 20, "email@email.com");
  user1.printUserInfo();

  User user2 = User("name2", 20, null);
  user2.printUserInfo();

  return 0;
}