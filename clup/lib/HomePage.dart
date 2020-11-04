import 'package:clup/StoreSignup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'CustomerLogin.dart';
import 'CustomerSignup.dart';
import 'StoreLogin.dart';
import 'StoreSignup.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkBoxValue = false;
  String username = "";
  String password = "";
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
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
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
                    padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextField(
                            onSubmitted: (String input) => _setUsername(input),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            obscureText: true,
                            onSubmitted: (String input) => _setPassword(input),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "LoginBtn",
                      onPressed: () => _onButtonPressed(context, 2),
                      label: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 224, 224, 224),
                    width: 3,
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "SignupBtn",
                      onPressed: () => _onButtonPressed(context, 1),
                      label: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 35, 50, 52),
                child:
                    Text("A breif description about CLup will go here, along "
                        "with why CLup was developed."),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(280,0,300,0),
                child: CheckboxListTile(
                  title: new Text(
                    'Store',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: checkBoxValue,
                  onChanged: (bool value) {
                    setState( () {
                      checkBoxValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _setUsername(String input){
    username = input;
  }

  _setPassword(String input){
    password = input;
  }
  _onButtonPressed(BuildContext context, int option){
    String checkUsername = 'username';
    String checkPassword = 'password';

    if ( checkBoxValue == false ){
      

      if (option != 1 && username != checkUsername){
        option = 3;
      }
      else if (option != 1 && password != checkPassword){
        option = 4;
      }
      switch(option){
        case 1: {
          return Navigator.push(context, MaterialPageRoute(
            builder: (context) => CustomerSignup(),
            )
          );
        }
        break;
        case 2: {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CustomerLogin(),
          ));
        }
        break;
        case 3: {
          Fluttertoast.showToast(
            msg: 'Username did not match any users.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
        break;
        case 4: {
          Fluttertoast.showToast(
            msg: 'Password was incorrect.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
        break;
        return null;
      }
    }
    else {
      if ( option == 1 ) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => StoreSignup(),
        ));
      }
      else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => StoreLogin(),
        ));

      }
    }
  }
}