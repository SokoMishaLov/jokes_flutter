import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';

const int FETCH_AMOUNT = 5;
const int DAD_JOKES_TOTAL_AMOUNT = 500;

Future<List> fetchJokesFromAllSources() async {

  List<List> list = await Future
      .wait([
        fetchRandomChuckNorrisJokes(),
        fetchDadJokes()
      ]);

  List result = [];

  list.forEach((list) => result.addAll(list));
  result.shuffle(new Random(DateTime.now().millisecondsSinceEpoch));

  return result;
}

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

Future<List> fetchDadJokes() async {
  int page = new Random(DateTime.now().millisecondsSinceEpoch).nextInt((DAD_JOKES_TOTAL_AMOUNT / FETCH_AMOUNT).floor());

  final response = await http.get('${API.DAD_JOKE_BASE_URL}/search?page=$page&limit=$FETCH_AMOUNT', headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return json
        .decode(response.body)['results']
        .map((o) => Joke.fromDadJokeJson(o))
        .toList();
  } else {
    throw Exception('Failed to load jokes :(');
  }
}