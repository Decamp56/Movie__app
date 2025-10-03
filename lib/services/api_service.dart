// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:movieapp__s/models/articles.dart'; // Use Article model

// class ApiService {
//   final String apiKey = 'your_api_key'; // Insert your OMDB API key here
//   final String baseUrl = 'http://www.omdbapi.com/'; // Base URL for OMDB API

//   // Fetch a list of articles (movies) from OMDB
//   Future<List<Article>> fetchArticles() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl?s=batman&apikey=$apiKey'), // Example search for "batman"
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
      
//       // OMDB API response's "Search" field contains a list of movie results
//       if (data['Response'] == 'True') {
//         final List<dynamic> articlesJson = data['Search'];
//         return articlesJson.map((json) => Article.fromJson(json)).toList();
//       } else {
//         throw Exception('No movies found');
//       }
//     } else {
//       throw Exception('Failed to load articles');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp__s/models/articles.dart';

class ApiService {
  final String apiKey = '58a44366'; // Replace with your OMDb API key
  final String baseUrl = 'http://www.omdbapi.com/';

  // 🔍 Search movies by keyword
  Future<List<Article>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?s=$query&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['Response'] == 'True') {
        final List<dynamic> results = data['Search'];
        return results.map((json) => Article.fromSearchJson(json)).toList();
      } else {
        return []; // No results
      }
    } else {
      throw Exception('Failed to load search results');
    }
  }

  // 🎬 Fetch movie details by imdbID
  Future<Article> getMovieDetails(String imdbID) async {
    final response = await http.get(
      Uri.parse('$baseUrl?i=$imdbID&plot=full&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['Response'] == 'True') {
        return Article.fromDetailJson(data);
      } else {
        throw Exception('Movie not found');
      }
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
