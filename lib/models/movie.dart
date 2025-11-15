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
        imageUrl:
            'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      ),
      Movie(
        title: 'Spider-Man: No Way Home',
        description: 'Action, Adventure | Marvel/Sony',
        year: '2021',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      ),
      Movie(
        title: 'Black Panther',
        description: 'Action, Drama | Marvel Studios',
        year: '2018',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg',
      ),
      Movie(
        title: 'Doctor Strange',
        description: 'Fantasy, Adventure | Marvel Studios',
        year: '2016',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/gwi5kL7HEWAOTffiA14e4SbOGra.jpg',
      ),
    ];
  }

  static List<Movie> getDownloaded() {
    return [
      Movie(
        title: 'Guardians of the Galaxy',
        description: 'Sci-Fi, Comedy | Downloaded',
        year: '2014',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/r7vmZjiyZw9rpJMQJdXpjgiCOk9.jpg',
      ),
      Movie(
        title: 'Iron Man',
        description: 'Action, Sci-Fi | Downloaded',
        year: '2008',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg',
      ),
    ];
  }

  static List<Movie> getRecommended() {
    return [
      Movie(
        title: 'Captain Marvel',
        description: 'Action, Sci-Fi',
        year: '2019',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg',
      ),
      Movie(
        title: 'Shang-Chi',
        description: 'Action, Fantasy',
        year: '2021',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg',
      ),
      Movie(
        title: 'Thor: Ragnarok',
        description: 'Action, Comedy',
        year: '2017',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg',
      ),
      Movie(
        title: 'WandaVision',
        description: 'Series, Fantasy',
        year: '2021',
        imageUrl:
            'https://image.tmdb.org/t/p/w500/glKDfE6btIRcVB5zrjspRIs4r52.jpg',
      ),
    ];
  }
}
