import 'dart:convert';
import 'joke_serializer.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.chucknorris.io/jokes/';

Future<Joke> fetchJoke(String category) async {
  String end = "random";
  if (category != "random") {
    end += "?category=$category";
  }
  final response = await http.get(Uri.parse(baseUrl + end));
  if (response.statusCode == 200) {
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load joke");
  }
}

Future<List<String>> fetchCategories() async {
  final response = await http.get(Uri.parse(baseUrl + "categories"));
  if (response.statusCode == 200) {
    List<String> ls = List<String>.from(jsonDecode(response.body));
    ls.insert(0, "random");
    return ls;
  } else {
    throw Exception("Failed to load categories");
  }
}

Future<List<JokeQuery>> fetchJokeByQuery (String query) async {
  final response = await http.get(Uri.parse(baseUrl + "search?query=" + query));
  if (response.statusCode == 200){
    Query query = Query.fromJson(jsonDecode(response.body));
    return query.result;
  }else{
    throw Exception("Failed to load query");
  }
}