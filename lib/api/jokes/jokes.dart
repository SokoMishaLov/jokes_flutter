import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';

const int FETCH_AMOUNT = 5;

Future<List> fetchRandomChuckNorrisJokes() async {
  final response = await http.get('${API.CHUCK_NORRIS_DATABASE_BASE_URL}/random/$FETCH_AMOUNT');
  if (response.statusCode == 200) {
    return json
        .decode(response.body)['value']
        .map((o) => Joke.fromChuckNorrisJson(o))
        .toList();
  } else {
    throw Exception('Failed to load jokes :(');
  }
}

Future<List> fetchRandomUmoriliJokes() async {
  final response = await http.get('${API.UMORILI_BASE_URL}/random?num=$FETCH_AMOUNT');
  if (response.statusCode == 200) {
    return json
        .decode(response.body)
        .map((o) => Joke.fromUmoriliJson(o))
        .toList();
  } else {
    throw Exception('Failed to load jokes :(');
  }
}