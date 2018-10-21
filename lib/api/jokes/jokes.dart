import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';

Future<List> fetchRandomChuckNorrisJokes() async {
  final response = await http.get('${API.JOKES_BASE_URL}/random/5');
  if (response.statusCode == 200) {
    return json
        .decode(response.body)['value']
        .map((o) => new Joke(id: o['id'], text: o['joke']))
        .toList();
  } else {
    throw Exception('Failed to load jokes :(');
  }
}
