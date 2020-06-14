import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ztiprojekt/abstracts/AppUser.dart';
import 'package:ztiprojekt/mechanics/SignInEngine.dart';

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

  AppUser _user = new AppUser.anonymous();
  SignInEngine signInEngine = new SignInEngine();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                // <- To jest strumień z Firebase (Może być z czegokolwiek...)
                stream: Firestore.instance.collection('tanks').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  var snpErr = snapshot.hasError;
                  var snpConn = snapshot.connectionState;
                  var spsht = snapshot.data.documents;

                  var tankName = spsht[0].data['name'];

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(_user.userPicUrl),
                        ),
                        Text(_user.userName),
                        Text(_user.userMail),
                        Text('$snpConn'),
                        Text('$snpErr'),
                        Text(tankName.toString()),
                        FlatButton(
                          onPressed: () {
                            signInEngine.login();
                          },
                          color: Colors.green,
                          child: Text('Sign in with Google'),
                        ),
                        FlatButton(
                          onPressed: () {
                            signInEngine.logout();
                            setState(() {
                              _user = AppUser.anonymous();
                            });
                          },
                          color: Colors.red,
                          child: Text('Signout from Google'),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _user = signInEngine.GetUser();
                            });
                          },
                          color: Colors.blue,
                          child: Text('GetData'),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
