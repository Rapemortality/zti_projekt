import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projekt ZTI',
      home: MyHomePage(title: 'Zaawansowane Tech. Internetowe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;

  String username = 'Defalut user';
  String usermail = 'Defalut mail';
  String userPic =
      'https://img.itch.zone/aW1nLzI1NjA3MTkucG5n/original/kdaCNO.png';

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    await _googleSignIn.signIn();
  }

  _logout() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userPic),
            ),
            Text(username),
            Text(usermail),
            FlatButton(
              onPressed: () {
                _login();
              },
              color: Colors.green,
              child: Text('Signin with Google'),
            ),
            FlatButton(
              onPressed: () {
                _logout();
                setState(() {
                  username = 'Defalut user';
                  usermail = 'Defalut mail';
                  userPic =
                      'https://img.itch.zone/aW1nLzI1NjA3MTkucG5n/original/kdaCNO.png';
                });
              },
              color: Colors.red,
              child: Text('Signout from Google'),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  username = _googleSignIn.currentUser.displayName;
                  usermail = _googleSignIn.currentUser.email;
                  userPic = _googleSignIn.currentUser.photoUrl;
                });
              },
              color: Colors.blue,
              child: Text('GetData'),
            ),
          ],
        ),
      ),
    );
  }
}
