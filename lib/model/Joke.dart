class Joke {
  final int id;
  final String text;

  Joke({this.id, this.text});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['value.id'],
      text: json['value.joke']
    );
  }
}