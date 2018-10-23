import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokes_flutter/api/jokes/jokes.dart';
import 'package:jokes_flutter/model/Joke.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';

class JokesListWidget extends StatefulWidget {
  @override
  _JokesListWidgetState createState() => _JokesListWidgetState();
}

class _JokesListWidgetState extends State<JokesListWidget> {
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
        child: new ListView.separated(
          separatorBuilder: (context, index) => new Divider(
            indent: 5.0,
            height: 15.0,
            color: Colors.deepPurple,
          ),
          itemCount: _randomJokes?.length,
          itemBuilder: (context, index) {
            return _buildRow(_randomJokes[index]);
          },
        )
    );
  }

  Widget _buildRow(Joke joke) {
    Key key = new Key(new Random().nextInt(1000).toString());

    return new ListTile(
        key: key,
        leading: new Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: joke.image
                )
            )
        ),
        title:  new HtmlWidget(html: joke.text, key: key)
    );
  }

  void _onRefresh(bool up) {
    fetchJokesFromAllSources().then((jokes) => setState(() {
      if (up) {
        _randomJokes = [jokes, _randomJokes].expand((x) => x).toList();
      } else {
        _randomJokes = [_randomJokes, jokes].expand((x) => x).toList();
      }
      _refreshController.sendBack(up, RefreshStatus.completed);
    }));
  }
}
