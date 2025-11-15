class Movie {
  final String title;
  final String description;
  final String year;
  final String imageUrl;

  Movie({
    required this.title,
    required this.description,
    required this.year,
    required this.imageUrl,
  });
}

class MovieRepository {
  static List<Movie> getWatchHistory() {
    return [
      Movie(
        title: 'Avengers: Endgame',
        description: 'Action, Sci-Fi | Marvel Studios',
        year: '2019',
        imageUrl: 'https://picsum.photos/seed/endgame/60/90',
      ),
      Movie(
        title: 'Spider-Man: No Way Home',
        description: 'Action, Adventure | Marvel/Sony',
        year: '2021',
        imageUrl: 'https://picsum.photos/seed/spiderman/60/90',
      ),
      Movie(
        title: 'Black Panther',
        description: 'Action, Drama | Marvel Studios',
        year: '2018',
        imageUrl: 'https://picsum.photos/seed/panther/60/90',
      ),
      Movie(
        title: 'Doctor Strange',
        description: 'Fantasy, Adventure | Marvel Studios',
        year: '2016',
        imageUrl: 'https://picsum.photos/seed/strange/60/90',
      ),
    ];
  }

  static List<Movie> getDownloaded() {
    // Lista de películas descargadas
    return [
      Movie(
        title: 'Guardians of the Galaxy',
        description: 'Sci-Fi, Comedy | Downloaded',
        year: '2014',
        imageUrl: 'https://picsum.photos/seed/guardians/60/90',
      ),
      Movie(
        title: 'Iron Man',
        description: 'Action, Sci-Fi | Downloaded',
        year: '2008',
        imageUrl: 'https://picsum.photos/seed/ironman/60/90',
      ),
    ];
  }
}
