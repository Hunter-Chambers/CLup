import 'package:flutter/material.dart';

void main() {
  runApp(WebApp());
}

class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CLup",
      home: HomePage(title: "CLup Home Page"),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 20, 52),
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text("Sign Up"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 0, 52),
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text("Login"),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 3,
                indent: 30,
                endIndent: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 52, 50, 52),
                child:
                    Text("A breif description about CLup will go here, along "
                        "with why CLup was developed."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
