import 'package:flutter/material.dart';
import 'package:jokes_flutter/api/users/users.dart';
import 'package:jokes_flutter/model/Profile.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Profile _profile;

  static final Color _fontColor = Colors.white;
  static final List<Color> _bgGradient = [Colors.black87, Colors.black26];

  @override
  void initState() {
    _profile = null;

    super.initState();

    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {

    var children;
    if (_profile != null) {
      final avatar = Hero(
            tag: 'hero',
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.transparent,
                backgroundImage: _profile?.avatar,
              ),
            ),
          );

      final fullName = Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          '${_profile?.firstName} ${_profile?.lastName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40.0, color: _fontColor),
        ),
      );

      final ages = Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 4.0),
        child: Text(
          '${(DateTime.now().difference(_profile?.dateOfBirth).inDays / 365).floor()} лет',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: _fontColor),
        ),
      );

      final phone = Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          '${_profile?.phone}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: _fontColor),
        ),
      );


      children = <Widget>[avatar, fullName, ages, phone];

    } else {
      var loader  = Center(
          child: CircularProgressIndicator()
      );

      children = <Widget>[loader];
    }


    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: _bgGradient),
          ),
          child: Column(
            children: children,
          ),
        )
    );
  }

  _loadProfile() {
    fetchProfile().then((profile) => setState(() {
      _profile = profile;
    }));
  }
}