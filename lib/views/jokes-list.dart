import 'package:flutter/material.dart';
import 'package:jokes_flutter/api/jokes/jokes.dart';
import 'package:jokes_flutter/model/Joke.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JokesList extends StatefulWidget {
  @override
  _JokesListState createState() => _JokesListState();
}

class _JokesListState extends State<JokesList> {
  List _randomJokes;
  RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = new RefreshController();
    _randomJokes = [];

    super.initState();

    _onRefresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return new SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        child: new ListView.builder(
          itemCount: _randomJokes?.length,
          itemBuilder: (context, index) {
            return _buildRow(_randomJokes[index]);
          },
        )
    );
  }

  Widget _buildRow(Joke joke) {
    return new ListTile(
        key: new Key(joke.id.toString()),
        leading: Icon(Icons.code),
        title: new Text(joke.text)
    );
  }

  void _onRefresh(bool up) {
    fetchRandomChuckNorrisJokes().then((jokes) => setState(() {
      if (up) {
        _randomJokes = [jokes, _randomJokes].expand((x) => x).toList();
      } else {
        _randomJokes = [_randomJokes, jokes].expand((x) => x).toList();
      }
      _refreshController.sendBack(up, RefreshStatus.completed);
    })
    );
  }
}
