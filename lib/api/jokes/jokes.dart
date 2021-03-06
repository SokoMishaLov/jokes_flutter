import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Joke.dart';

import '../http.dart';

const int FETCH_AMOUNT = 5;
const int DAD_JOKES_TOTAL_AMOUNT = 500;

Future<List<Joke>> fetchJokesFromAllSources() async {
  List<List> list = await Future.wait([
    fetchRandomChuckNorrisJokes(),
    fetchDadJokes(),
  ]);

  List result = [];

  list.forEach((list) => result.addAll(list));
  result.shuffle(new Random(DateTime.now().millisecondsSinceEpoch));

  return result;
}

Future<List<Joke>> fetchRandomChuckNorrisJokes() async {
  final response =
      await http.get('$CHUCK_NORRIS_DATABASE_BASE_URL/random/$FETCH_AMOUNT');
  if (response?.statusCode == 200) {
    return json
        .decode(response.body)['value']
        .map((o) => Joke.fromChuckNorrisJson(o))
        .toList();
  } else {
    return [];
  }
}

Future<List<Joke>> fetchDadJokes() async {
  int page = new Random(DateTime.now().millisecondsSinceEpoch)
      .nextInt((DAD_JOKES_TOTAL_AMOUNT / FETCH_AMOUNT).floor());

  final response = await http.get(
    '$DAD_JOKE_BASE_URL/search?page=$page&limit=$FETCH_AMOUNT',
    headers: {"Accept": "application/json"},
  );

  if (response?.statusCode == 200) {
    return json
        .decode(response.body)['results']
        .map((o) => Joke.fromDadJokeJson(o))
        .toList();
  } else {
    return [];
  }
}
