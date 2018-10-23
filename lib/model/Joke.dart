import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class Joke {
  final ImageProvider image;
  final String text;


  Joke({this.image, this.text});

  factory Joke.fromChuckNorrisJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Joke(
          image: AssetImage('assets/chuck.jpg'),
          text: htmlEscape.convert(json['joke'])
      );
    }
  }

  factory Joke.fromUmoriliJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Joke(
          image: AssetImage('assets/umorili.png'),
          text: htmlEscape.convert(json['elementPureHtml'])
      );
    }
  }

  factory Joke.fromDadJokeJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Joke(
          image: AssetImage('assets/dad_joke.png'),
          text: htmlEscape.convert(json['joke'])
      );
    }
  }

}

final HtmlUnescape htmlEscape = new HtmlUnescape();