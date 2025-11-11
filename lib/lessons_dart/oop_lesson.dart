import 'package:equatable/equatable.dart';

void main() {
  // Book firstBook = Book('', '', 1);
  // Book secondBook = Book('', '', 2);
  // Book thirdBook = Book('', '', 3);

  // firstBook.displayInfo();
  // secondBook.displayInfo();
  // thirdBook.displayInfo();

  // Animal animal = Animal('lol', 3);
  // print(animal.isAdult());

  // Fish cambola = Fish('cambola', 1);
  // print('Im ${cambola.species}, ${cambola.swim()}');

  // SportsClub club = SportsClub();
  // club.addSport(Soccer());
  // club.addSport(Basketball());
  // club.playAll();

  // Coordinate c1 = Coordinate(50.45, 30.52);
  // Coordinate c2 = Coordinate(50.45, 30.52);
  // Coordinate c3 = Coordinate(49.84, 24.03);

  // print(c1 == c2);
  // print(c1 == c3);

  const coordA = Coordinate2(50.45, 30.52);
  const coordB = Coordinate2(50.45, 30.52);
  const coordC = Coordinate2(49.84, 24.03);

  print(coordA == coordB);
  print(coordA == coordC);
}

// 1
class Book {
  String name;
  String author;
  int publishYear;

  Book(this.name, this.author, this.publishYear);

  void displayInfo() {
    print('Назва книги: $name, Автор: $author, Дата публікації: $publishYear');
  }
}

// 2
class Animal {
  String? species;
  int age;
  Animal(this.species, this.age);
  Animal.newBorn({this.age = 0});

  bool isAdult() {
    return age > 2;
  }
}

// 3
mixin Swimming {
  String swim() {
    return "I can swim";
  }
}

class Fish extends Animal with Swimming {
  Fish(super.species, super.age);

  void prinFishtInfo() {
    print('I’m a fish and ${swim()}');
  }
}

class Duck extends Animal with Swimming {
  Duck(super.species, super.age);
  void prinDuckInfo() {
    print('I’m a duck and ${swim()}');
  }
}

// 4
abstract class Playable {
  String play();
}

class Soccer extends Playable {
  @override
  String play() => 'play football';
}

class Basketball extends Playable {
  @override
  String play() => 'play basketball';
}

class SportsClub {
  final List<Playable> _sports = [];

  void addSport(Playable playable) {
    _sports.add(playable);
  }

  void playAll() {
    for (var sport in _sports) {
      print(sport.play());
    }
  }
}

// 5
class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate(this.latitude, this.longitude);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinate &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() => 'Coordinate(latitude: $latitude, longitude: $longitude)';
}

class Coordinate2 extends Equatable {
  final double latitude;
  final double longitude;

  const Coordinate2(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
