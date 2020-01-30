import 'package:flutter/material.dart';
import 'package:jokes_flutter/views/jokes-list.dart';
import 'package:jokes_flutter/views/profile.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Jokes",
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
  int _pageIndex;

  @override
  void initState() {
    _pageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Jokes"),
      ),
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: _pageIndex != 0,
            child: new TickerMode(
              enabled: _pageIndex == 0,
              child: new JokesListWidget(),
            ),
          ),
          new Offstage(
            offstage: _pageIndex != 1,
            child: new TickerMode(
              enabled: _pageIndex == 1,
              child: new ProfileWidget(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setPageIndex,
        currentIndex: _pageIndex,
        iconSize: 20.0,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Лента'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Мой профиль'))
        ],
      ),
    );
  }

  void _setPageIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
