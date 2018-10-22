class Joke {
  final int id;
  final String text;

  Joke({this.id, this.text});

  factory Joke.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Joke(
          id: json['id'],
          text: json['joke'].toString().replaceAll("&quot;", "\"")
      );
    }
  }
}