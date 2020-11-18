import 'package:clup/StoreProfile/StoreSignup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'CustomerProfile/CustomerLogin.dart';
import 'CustomerProfile/CustomerSignup.dart';
import 'StoreProfile/StoreLogin.dart';
import 'StoreProfile/StoreSignup.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final signupBtnText = Text("Sign Up",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ));

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
                            controller: usernameController,
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
                            controller: passwordController,
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
                      onPressed: () {
                        _setUsername(usernameController.text);
                        _setPassword(passwordController.text);
                        _onButtonPressed(context, 3);
                      },
                      label: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.7,
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
                    padding: EdgeInsets.fromLTRB(20, 0, 13, 0),
                    margin: EdgeInsets.only(left: 45),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color.fromARGB(255, 33, 150, 243),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        underline: null,
                        icon: Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                        //iconSize: 0.0,
                        value: signupBtnText,
                        onChanged: (Text value) {
                          setState(() {
                            if (value.data == "Customer") {
                              _onButtonPressed(context, 1);
                            } else if (value.data == "Store") {
                              _onButtonPressed(context, 2);
                            }
                          });
                        },
                        isExpanded: false,
                        items: <Text>[
                          signupBtnText,
                          Text("Customer"),
                          Text("Store"),
                        ].map<DropdownMenuItem<Text>>((Text value) {
                          return DropdownMenuItem<Text>(
                            value: value,
                            child: value,
                          );
                        }).toList(),
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
            ],
          ),
        ),
      ),
    );
  }

  _setUsername(String input) {
    username = input;
  }

  _setPassword(String input) {
    password = input;
  }

  _onButtonPressed(BuildContext context, int option) {
    String customerUsername = 'customer';
    String customerPassword = 'password';

    String storeUsername = 'store';
    String storePassword = 'password';

    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSignup(),
              ));
        }
        break;
      case 2:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSignup(),
              ));
        }
        break;
      case 3:
        {
          if (username != customerUsername && username != storeUsername) {
            Fluttertoast.showToast(
              msg: 'Username did not match any users.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          } else if (password != customerPassword &&
              password != storePassword) {
            Fluttertoast.showToast(
              msg: 'Password was incorrect.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          } else if (username == customerUsername) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerLogin(),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreLogin(),
                ));
          }
        }
        break;
        return null;
    }
  }
}
