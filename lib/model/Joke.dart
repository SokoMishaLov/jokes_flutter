import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class Joke {
  final ImageProvider image;
  final String text;

  Joke({this.image, this.text});

  factory Joke.fromChuckNorrisJson(json) {
    return json == null
        ? null
        : Joke(
            image: AssetImage('assets/chuck.jpg'),
            text: htmlEscape.convert(json['joke']),
          );
  }

  factory Joke.fromDadJokeJson(json) {
    return json == null
        ? null
        : Joke(
            image: AssetImage('assets/smile.png'),
            text: htmlEscape.convert(json['joke']),
          );
  }
}

final HtmlUnescape htmlEscape = new HtmlUnescape();
