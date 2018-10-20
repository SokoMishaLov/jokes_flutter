import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<Joke> fetchRandomChuckNorrisJokes() async {
  final response = await http.get('${API.JOKES_BASE_URL}/random');

  if (response.statusCode == 200) {
    return Joke.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load joke');
  }
}
