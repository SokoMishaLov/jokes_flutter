import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';

Future<List> fetchRandomChuckNorrisJokes() async {
  final response = await http.get('${API.JOKES_BASE_URL}/random/10');
  if (response.statusCode == 200) {
    return json
        .decode(response.body)['value']
        .map((o) => Joke.fromChuckNorrisJson(o))
        .toList();
  } else {
    throw Exception('Failed to load jokes :(');
  }
}