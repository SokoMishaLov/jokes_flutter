import 'package:flutter/material.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';
import 'package:jokes_flutter/api/jokes/jokes.dart';
import 'package:jokes_flutter/model/Joke.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JokesListWidget extends StatefulWidget {
  @override
  _JokesListWidgetState createState() => _JokesListWidgetState();
}

class _JokesListWidgetState extends State<JokesListWidget> {
  List _randomJokes;
  RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: true);
    _randomJokes = [];

    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            indent: 5.0,
            height: 15.0,
            color: Colors.deepPurple,
          );
        },
        itemCount: _randomJokes?.length,
        itemBuilder: (context, index) {
          return _buildRow(_randomJokes[index]);
        },
      ),
    );
  }

  Widget _buildRow(Joke joke) {
    return ListTile(
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: joke.image,
          ),
        ),
      ),
      title: HtmlWidget(
        html: joke.text,
      ),
    );
  }

  void _onRefresh() async {
    var newJokes = await fetchJokesFromAllSources();
    setState(() {
      _randomJokes = [newJokes, _randomJokes].expand((x) => x).toList();
    });
  }

  void _onLoading() {
    _refreshController.loadComplete();
  }
}
