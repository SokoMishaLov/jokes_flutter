import 'package:flutter/material.dart';

class Joke {
  final int id;
  final ImageProvider image;
  final String text;

  Joke({this.id, this.image, this.text});

  factory Joke.fromChuckNorrisJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Joke(
          id: json['id'],
          image: AssetImage('assets/chuck.jpg'),
          text: json['joke'].toString().replaceAll("&quot;", "\"")
      );
    }
  }

  @override
  String toString() {
    return 'Joke{id: $id, text: $text}';
  }
}
