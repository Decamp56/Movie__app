
class Article {
  final String title;
  final String year;
  final String imdbID;
  final String posterUrl;
  final String? plot; // optional, because search results don't include it

  const Article({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.posterUrl,
    this.plot,
  });

  // From Search Results (list API -> s=keyword)
  factory Article.fromSearchJson(Map<String, dynamic> json) {
    return Article(
      title: json['Title'] ?? 'No Title',
      year: json['Year'] ?? 'Unknown',
      imdbID: json['imdbID'] ?? '',
      posterUrl: json['Poster'] ?? 'https://via.placeholder.com/150',
    );
  }

  // From Detail Response (single movie API -> i=imdbID)
  factory Article.fromDetailJson(Map<String, dynamic> json) {
    return Article(
      title: json['Title'] ?? 'No Title',
      year: json['Year'] ?? 'Unknown',
      imdbID: json['imdbID'] ?? '',
      posterUrl: json['Poster'] ?? 'https://via.placeholder.com/150',
      plot: json['Plot'] ?? 'No Plot Available',
    );
  }
}
