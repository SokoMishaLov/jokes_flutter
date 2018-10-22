import 'package:flutter/material.dart';
import 'package:jokes_flutter/api/jokes/jokes.dart';
import 'package:jokes_flutter/model/Joke.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Шуточки с Чаком Норрисом",
      supportedLocales: [Locale("en", ""), Locale("ru", "")],
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _randomJokes;
  RefreshController _refreshController;
  int _index;

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

  @override
  void initState() {
    _refreshController = new RefreshController();
    _randomJokes = [];
    _index = 0;

    super.initState();

    _onRefresh(true);
  }

  @override
  Widget build(BuildContext context) {
    var listViewBuilder = new SmartRefresher(
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

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Шуточки с Чаком Норрисом"),
      ),
      body: listViewBuilder,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) { setState((){ _index = index; }); },
        currentIndex: _index, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Шуточки!'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Мой профиль')
          )
        ],
      ),
    );
  }

  Widget _buildRow(Joke joke) {
    return new ListTile(
        key: new Key(joke.id.toString()),
        leading: Icon(Icons.code),
        title: new Text(joke.text)
    );
  }
}