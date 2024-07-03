import 'routine.dart';

class Game {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String genre;
  final int year;
  final String developer;
  final String link;
  final double rating;
  List<Routine> routines;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.genre,
    required this.year,
    required this.developer,
    required this.link,
    required this.rating,
    this.routines = const [],
  });

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      genre: map['genre'],
      year: map['year'],
      developer: map['developer'],
      link: map['link'],
      rating: map['rating'],
    );
  }

  factory Game.empty() {
    return Game(
      id: 0,
      name: '',
      description: '',
      imageUrl: 'assets/games.png',
      genre: '',
      year: 0,
      developer: '',
      link: '',
      rating: 0.0,
      routines: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'genre': genre,
      'year': year,
      'developer': developer,
      'link': link,
      'rating': rating,
    };
  }
}
